//
//  HKJsonTest.m
//  HKJSONKitEx
//
//  Created by akwei on 12-10-17.
//  Copyright (c) 2012年 huoku. All rights reserved.
//

#import "HKJsonTest.h"
#import "HKJSONEx.h"
#import "HKFood.h"
#import "HKFoodCat.h"
#import "HKRestaurantMenu.h"
#import "HKFoodPrice.h"
#import "JSONKit.h"
#import "HKRestaurant.h"
#import "HKObj.h"

@implementation HKJsonTest

-(void)test{
    NSString* path = [[NSBundle mainBundle] pathForResource:@"json" ofType:@"txt"];
    
    NSData* data = [[NSData alloc] initWithContentsOfFile:path];
    
    NSString* json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSDictionary* dic = [json objectFromJSONString];
    
    HKJSONEx* ex = [[HKJSONEx alloc] init];
    //添加参数cls类中 集合属性foodcats中元素的类型为参数addTypeToken
    [ex property:@"foodcats" cls:[HKRestaurantMenu class] addTypeToken:[HKFoodCat class]];
    [ex property:@"foods" cls:[HKRestaurantMenu class] addTypeToken:[HKFood class]];
    [ex property:@"prices" cls:[HKFood class] addTypeToken:[HKFoodPrice class]];
    [ex property:@"food_ids" cls:[HKFoodCat class] addTypeToken:[NSNumber class]];
    
//    //从NSDictionary 中获得对象数据
//    HKRestaurantMenu* menu = [ex objectForClass:[HKRestaurantMenu class] values:[dic valueForKey:@"menu"]];
//    
//    HKRestaurant* info = [ex objectForClass:[HKRestaurant class] values:[dic valueForKey:@"info"]];
    HKObj* obj = [ex objectForClass:[HKObj class] values:dic];
    
    HKRestaurantMenu* menu = obj.menu;
    HKRestaurant* info = obj.info;
    
    NSLog(@"menu ===========");
    NSLog(@"restaurant_id:%lu",(unsigned long)[menu restaurant_id]);
    for (HKFoodCat* cat in menu.foodcats) {
        NSLog(@"    cat cat_id:%lu",(unsigned long)cat.foodcat_id);
        NSLog(@"    cat cat_id:%@",cat.name);
        NSLog(@"    cat count:%i",cat.count);
    }
    
    for (HKFood* food in menu.foods) {
        NSLog(@"    food food_id:%lu",(unsigned long)food.food_id);
        NSLog(@"    food foodcat_id:%lu",(unsigned long)food.foodcat_id);
        NSLog(@"    food name:%@",food.name);
        for (HKFoodPrice* price in food.prices) {
            NSLog(@"        price foodprice_id:%lu",(unsigned long)price.foodprice_id);
            NSLog(@"        price foodprice_id:%@",price.name);
            NSLog(@"        price foodprice_id:%@",price.unit);
            NSLog(@"        price foodprice_id:%f",price.price);
        }
    }
    NSLog(@"menu =========== end");
    
    NSLog(@"info ===========");
    NSLog(@"info restaurant_id:%lu",(unsigned long)info.restaurant_id);
    NSLog(@"info name:%@",info.name);
    NSLog(@"info longitude:%@",info.longitude);
    NSLog(@"info latitude:%@",info.latitude);
    NSLog(@"info avgspend:%i",info.avgspend);
    NSLog(@"info address:%@",info.address);
    NSLog(@"info address:%@",info.phone);
    NSLog(@"info traffic_info:%@",info.traffic_info);
    NSLog(@"info shop_hours:%@",info.shop_hours);
    NSLog(@"info atmosphere:%@",info.atmosphere);
    NSLog(@"info feature:%@",info.feature);
    NSLog(@"info public_ip:%@",info.public_ip);
    NSLog(@"info service_ip:%@",info.service_ip);
    NSLog(@"info =========== end");
}

@end
