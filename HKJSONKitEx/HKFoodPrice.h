//
//  HKFoodPrice.h
//  HKJSONKitEx
//
//  Created by akwei on 12-10-17.
//  Copyright (c) 2012年 huoku. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HKFoodPrice : NSObject

@property(nonatomic,assign)NSUInteger foodprice_id;
@property(nonatomic,copy)NSString* name;
@property(nonatomic,copy)NSString* unit;
@property(nonatomic,assign)double price;

@end
