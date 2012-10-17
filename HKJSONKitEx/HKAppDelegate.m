//
//  HKAppDelegate.m
//  HKJSONKitEx
//
//  Created by akwei on 12-10-15.
//  Copyright (c) 2012年 huoku. All rights reserved.
//

#import "HKAppDelegate.h"
#import "HKViewController.h"
#import "HKJSONEx.h"
#import "HKFood.h"
#import "HKFoodCat.h"
#import "HKRestaurantMenu.h"
#import "HKFoodPrice.h"
#import "JSONKit.h"
#import "HKRestaurant.h"

@implementation HKAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.viewController = [[HKViewController alloc] initWithNibName:@"HKViewController" bundle:nil];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    
    
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
    
    //从NSDictionary 中获得对象数据
    HKRestaurantMenu* menu = [ex objectForClass:[HKRestaurantMenu class] values:[dic valueForKey:@"menu"]];
    
    HKRestaurant* info = [ex objectForClass:[HKRestaurant class] values:[dic valueForKey:@"info"]];
    
    
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

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
