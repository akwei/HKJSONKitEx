//
//  HKFoodCat.h
//  HKJSONKitEx
//
//  Created by akwei on 12-10-17.
//  Copyright (c) 2012年 huoku. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HKFoodCat : NSObject

@property(nonatomic,assign)NSUInteger foodcat_id;
@property(nonatomic,copy)NSString* name;
@property(nonatomic,assign)NSUInteger count;
@property(nonatomic,strong)NSArray* food_ids;//NSUInteger in

@end
