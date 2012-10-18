##可以简化json对应的对象的赋值操作，例如json数据对应 User 对象，只要json中key与 User 对象的property对应就可以赋值
##目前支持类型为 NSString NSInteger double float BOOL  NSNumber long long 等数字类型，支持自定义对象类型 NSArray 需要定义好集合中的对象类型
    example:
    
``` objc
     HKJSONEx* ex = [[HKJSONEx alloc] init];//初始化
 
     //添加参数cls类中 集合属性foodcats中元素的类型为参数addTypeToken
     [ex property:@"foodcats" cls:[HKRestaurantMenu class] addTypeToken:[HKFoodCat class]];
 
     [ex property:@"foods" cls:[HKRestaurantMenu class] addTypeToken:[HKFood class]];
 
     [ex property:@"prices" cls:[HKFood class] addTypeToken:[HKFoodPrice class]];
 
     [ex property:@"food_ids" cls:[HKFoodCat class] addTypeToken:[NSNumber class]];
     
     HKRestaurantMenu* menu = [ex objectForClass:[HKRestaurantMenu class] values:[dic valueForKey:@"menu"]];
     
     HKRestaurant* info = [ex objectForClass:[HKRestaurant class] values:[dic valueForKey:@"info"]];
``` 