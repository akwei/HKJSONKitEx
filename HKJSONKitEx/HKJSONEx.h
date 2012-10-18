//
//  HKDicToObj.h
//  HKJSONKitEx
/*
 可以简化json对应的对象的赋值操作，例如json数据对应 User 对象，只要json中key与 User 对象的property对应就可以赋值
 目前支持类型为 NSString NSInteger double float BOOL  NSNumber long long 等数字类型，支持自定义对象类型 NSArray 需要定义好集合中的对象类型
    example:
     HKJSONEx* ex = [[HKJSONEx alloc] init];//初始化
 
     //添加参数cls类中 集合属性foodcats中元素的类型为参数addTypeToken
     [ex property:@"foodcats" cls:[HKRestaurantMenu class] addTypeToken:[HKFoodCat class]];
 
     [ex property:@"foods" cls:[HKRestaurantMenu class] addTypeToken:[HKFood class]];
 
     [ex property:@"prices" cls:[HKFood class] addTypeToken:[HKFoodPrice class]];
 
     [ex property:@"food_ids" cls:[HKFoodCat class] addTypeToken:[NSNumber class]];
     
     HKRestaurantMenu* menu = [ex objectForClass:[HKRestaurantMenu class] values:[dic valueForKey:@"menu"]];
     
     HKRestaurant* info = [ex objectForClass:[HKRestaurant class] values:[dic valueForKey:@"info"]];
 */
//  Created by akwei on 12-10-15.
//  Copyright (c) 2012年 huoku. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HKObjClassPropertyInfo : NSObject
@property(nonatomic,copy)NSString* name;
@property(nonatomic,copy)NSString* type;
@end

@interface HKObjClassInfo : NSObject

@property(nonatomic,assign)Class cls;

//HKObjClassPropertyInfo in dic
@property(nonatomic,strong)NSMutableDictionary* propertyInfoDic;

-(id)initWithClass:(Class)cls;
-(HKObjClassPropertyInfo*)objClassPropertyInfoWityName:(NSString*)propertyName;

@end

@interface HKJSONEx : NSObject
@property(nonatomic,strong)NSString* dateFormat;
@property(nonatomic,strong)NSTimeZone* timeZone;
//保存集合元素中对象类型的对应关系
@property(nonatomic,strong)NSMutableDictionary* listTypeDic;

/*
 创建一个 Cls类型的Object, 通过 info 对 Object 属性进行赋值
 */
-(id)objectForClass:(Class)cls values:(NSDictionary*)values;

/*
 对象的property进行赋值
 @param propertyName 属性名称
 @param obj 需要赋值的对象
 @param classInfo 类信息
 @param value 值
 */
-(void)setPropertyValue:(NSString *)propertyName
                 object:(id)obj
           objClassInfo:(HKObjClassInfo*)classInfo
                  value:(id)value;
/*
 对集合元素的属性限定元素类型
 */
-(void)property:(NSString*)propertyName cls:(Class)cls addTypeToken:(Class)typeToken;

-(Class)typeTokenForProperty:(NSString*)propertyName cls:(Class)cls;

@end
