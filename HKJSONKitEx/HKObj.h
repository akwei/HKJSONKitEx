//
//  HKObj.h
//  HKJSONKitEx
//
//  Created by akwei on 12-10-18.
//  Copyright (c) 2012年 huoku. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HKRestaurant;
@class HKRestaurantMenu;

@interface HKObj : NSObject
@property(nonatomic,strong)HKRestaurant* info;
@property(nonatomic,strong)HKRestaurantMenu* menu;
@end
