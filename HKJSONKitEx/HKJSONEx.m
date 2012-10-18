//
//  HKDicToObj.m
//  HKJSONKitEx
//
//  Created by akwei on 12-10-15.
//  Copyright (c) 2012年 huoku. All rights reserved.
//

#import "HKJSONEx.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation HKObjClassPropertyInfo
@end

@implementation HKObjClassInfo

-(id)initWithClass:(Class)cls{
    self = [super init];
    if (self) {
        self.cls = cls;
        self.propertyInfoDic = [[NSMutableDictionary alloc] init];
        unsigned int outCount;
        objc_property_t *props=class_copyPropertyList(cls, &outCount);
        for (int i = 0; i < outCount; i++) {
            objc_property_t prop=props[i];
            const char* propName = property_getName(prop);
            NSString* _propName=[[NSString alloc] initWithUTF8String:propName];
            Ivar ivar=class_getInstanceVariable(cls, propName);
            if (!ivar) {
                NSString* pn=[[NSString alloc] initWithFormat:@"_%@",_propName];
                ivar=class_getInstanceVariable(cls, [pn UTF8String]);
            }
            const char* typeEncoding=ivar_getTypeEncoding(ivar);
            NSString* _typeEncoding=[[NSString alloc] initWithUTF8String:typeEncoding];
            HKObjClassPropertyInfo* pinfo = [[HKObjClassPropertyInfo alloc] init];
            pinfo.name = _propName;
            pinfo.type =_typeEncoding;
            [self.propertyInfoDic setObject:pinfo forKey:_propName];
        }
        return self;
    }
    return nil;
}

-(HKObjClassPropertyInfo *)objClassPropertyInfoWityName:(NSString *)propertyName{
    return [self.propertyInfoDic valueForKey:propertyName];
}

@end

//HKObjClassInfo in dic
static NSMutableDictionary* objClassInfoDic=nil;
static dispatch_queue_t syncQueue;
@implementation HKJSONEx{
    NSMutableDictionary* property_type_token_dic;
}

-(id)init{
    self = [super init];
    if (self) {
        property_type_token_dic = [[NSMutableDictionary alloc] init];
        return self;
    }
    return nil;
}

-(id)objectForClass:(Class)cls values:(NSDictionary *)values{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
         objClassInfoDic = [[NSMutableDictionary alloc] init];
        syncQueue = dispatch_queue_create("HKDicToObj_syncQueue", DISPATCH_QUEUE_SERIAL);
    });
    HKObjClassInfo* cInfo = [self objClassInfoWithClass:cls];
    id instance = [[cls alloc] init];
    [values enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [self setPropertyValue:key object:instance objClassInfo:cInfo value:obj];
    }];
    return instance;
}

-(NSString*)classNameWithTypeEncoding:(NSString*)typeEncoding{
    NSString* s = [[typeEncoding stringByReplacingOccurrencesOfString:@"@" withString:@""] stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    return s;
}

-(void)setPropertyValue:(NSString *)propertyName
                 object:(id)obj
           objClassInfo:(HKObjClassInfo*)classInfo
                  value:(id)value{
    HKObjClassPropertyInfo* pinfo = [classInfo objClassPropertyInfoWityName:propertyName];
    if (pinfo) {
        if ([pinfo.type isEqualToString:@"@\"NSDate\""]) {
            NSDate* date = [HKJSONEx dateFromString:value format:self.dateFormat timeZone:self.timeZone];
            [obj setValue:date forKey:propertyName];
        }
        else if (
                 [pinfo.type isEqualToString:@"@\"NSString\""] ||
                 [pinfo.type isEqualToString:@"i"] ||
                 [pinfo.type isEqualToString:@"I"] ||
                 [pinfo.type isEqualToString:@"s"] ||
                 [pinfo.type isEqualToString:@"S"] ||
                 [pinfo.type isEqualToString:@"l"] ||
                 [pinfo.type isEqualToString:@"L"] ||
                 [pinfo.type isEqualToString:@"q"] ||
                 [pinfo.type isEqualToString:@"Q"] ||
                 [pinfo.type isEqualToString:@"f"] ||
                 [pinfo.type isEqualToString:@"d"] ||
                 [pinfo.type isEqualToString:@"B"]
                 ){
            [obj setValue:value forKey:propertyName];
        }
        //集合属性是，查看集合元素类型匹配，如果没有匹配，就忽略
        else if ([value isKindOfClass:[NSArray class]]){
            NSArray* tmps = value;
            Class objCls = [self typeTokenForProperty:propertyName cls:classInfo.cls];
            NSMutableArray* list = [[NSMutableArray alloc] init];
            if (objCls == [NSNumber class] || objCls == [NSString class]) {
                [list addObjectsFromArray:tmps];
            }
            else{
                for (NSDictionary* dic in tmps) {
                    id objOfProperty = [self objectForClass:objCls values:dic];
                    [list addObject:objOfProperty];
                }
                [obj setValue:list forKey:propertyName];
            }
        }
        //可能是类属性
        else{
            Class cls = NSClassFromString([self classNameWithTypeEncoding:pinfo.type]);
//            Class cls = [self typeTokenForProperty:propertyName cls:classInfo.cls];
            id objOfProperty = [self objectForClass:cls values:value];
            [obj setValue:objOfProperty forKey:propertyName];
        }
    }
}

-(HKObjClassInfo*)objClassInfoWithClass:(Class)cls{
    __block HKObjClassInfo* cInfo = nil;
    dispatch_sync(syncQueue, ^{
        NSString* clsName=[[NSString alloc] initWithUTF8String:class_getName(cls)];
        cInfo = [objClassInfoDic valueForKey:clsName];
        if (!cInfo) {
            cInfo = [[HKObjClassInfo alloc] initWithClass:cls];
            [objClassInfoDic setObject:cInfo forKey:clsName];
        }
    });
    return cInfo;
}

-(void)property:(NSString *)propertyName cls:(Class)cls addTypeToken:(Class)typeToken{
    NSString* clsName=[[NSString alloc] initWithUTF8String:class_getName(cls)];
    NSString* key = [[NSString alloc] initWithFormat:@"%@.%@",clsName,propertyName];
    [property_type_token_dic setValue:typeToken forKey:key];
}

-(Class)typeTokenForProperty:(NSString *)propertyName cls:(Class)cls{
    NSString* clsName=[[NSString alloc] initWithUTF8String:class_getName(cls)];
    NSString* key = [[NSString alloc] initWithFormat:@"%@.%@",clsName,propertyName];
    return [property_type_token_dic valueForKey:key];
}


+(NSDate *)dateFromString:(NSString *)string format:(NSString *)format timeZone:(NSTimeZone*)timeZone{
    NSDateFormatter *fmt=[[NSDateFormatter alloc] init];
    if (timeZone) {
        [fmt setTimeZone:timeZone];
    }
    else{
        [fmt setTimeZone:[NSTimeZone systemTimeZone]];
    }
	[fmt setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
	[fmt setDateFormat:format];
    return [fmt dateFromString:string];
}



@end
