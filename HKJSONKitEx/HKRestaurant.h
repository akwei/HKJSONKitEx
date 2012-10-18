//
//  HKRestaurnat.h
//  HKJSONKitEx
//
//  Created by akwei on 12-10-17.
//  Copyright (c) 2012年 huoku. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HKRestaurantMenu.h"

@interface HKRestaurant : NSObject

@property(nonatomic,assign)NSUInteger restaurant_id;
@property(nonatomic,copy)NSString* name;
@property(nonatomic,copy)NSString* longitude;
@property(nonatomic,copy)NSString* latitude;
@property(nonatomic,assign)NSUInteger avgspend;
@property(nonatomic,copy)NSString* address;
@property(nonatomic,copy)NSString* phone;
@property(nonatomic,copy)NSString* traffic_info;
@property(nonatomic,copy)NSString* shop_hours;
@property(nonatomic,copy)NSString* atmosphere;
@property(nonatomic,copy)NSString* feature;
@property(nonatomic,copy)NSString* public_ip;
@property(nonatomic,copy)NSString* service_ip;
@property(nonatomic,strong)HKRestaurantMenu* menu;

@end
