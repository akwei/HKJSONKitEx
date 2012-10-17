//
//  HKFood.h
//  HKJSONKitEx
//
//  Created by akwei on 12-10-17.
//  Copyright (c) 2012年 huoku. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HKFood : NSObject

@property(nonatomic,assign)NSUInteger food_id;
@property(nonatomic,assign)NSUInteger foodcat_id;
@property(nonatomic,copy)NSString* name;
@property(nonatomic,assign)NSUInteger price_count;
@property(nonatomic,strong)NSArray* prices;//HKFoodPrice in

@end
