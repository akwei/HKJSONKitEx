//
//  HKRestaurantMenu.h
//  HKJSONKitEx
//
//  Created by akwei on 12-10-17.
//  Copyright (c) 2012年 huoku. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HKRestaurantMenu : NSObject

@property(nonatomic,assign)NSUInteger restaurant_id;
@property(nonatomic,strong)NSArray* foodcats;//HKFoodCat in
@property(nonatomic,strong)NSArray* foods;//HKFood in

@end
