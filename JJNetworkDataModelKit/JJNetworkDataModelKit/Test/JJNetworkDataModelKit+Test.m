//
//  JJNetworkDataModelKit+Test.m
//  JJNetworkDataModelKit
//
//  Created by JJ on 6/14/15.
//  Copyright (c) 2015 JJ. All rights reserved.
//

#import "JJNetworkDataModelKit+Test.h"

#import "JJNetworkDataModelKit.h"

void jjNetworkDataModelKitTest()
{
    NSDictionary *dic = @{@"JJWeatherModel": @"JJWeatherOperation", @"JJWeatherJSONModel": @"JJWeatherJSONModelOperation",};
    [JJApplicationLayerManager setModelAndOperationNameDictionary:dic];
    
    NSString *key = @"jjKey";
    
    id object = [[JJApplicationLayerManager sharedInstance] getModel:NSClassFromString(@"JJWeatherModel")];
    NSLog(@"object = %@", object);
    
    id object1 = [[JJApplicationLayerManager sharedInstance] getModel:NSClassFromString(@"JJWeatherModel") identityID:key];
    NSLog(@"object1 = %@", object1);
    
    NSString *urlString = @"http://www.weather.com.cn/adat/sk/101010100.html";
    
    CFAbsoluteTime startTime = CFAbsoluteTimeGetCurrent();
    [[JJApplicationLayerManager sharedInstance] httpRequest:urlString protocolClass:NSClassFromString(@"JJWeatherProtocol") httpParams:nil resultBlock:^(JJIndexType index, BOOL success, id object, NSInteger updateCount, BOOL *needMemoryCache, BOOL *needLocalCache)
    {
        double executionTime = CFAbsoluteTimeGetCurrent() - startTime;
        NSLog(@"object3: %@, time: %f", object, executionTime);
    }];
    
    [[JJApplicationLayerManager sharedInstance] httpRequest:urlString protocolClass:NSClassFromString(@"JJWeatherProtocol") identityID:key httpParams:nil resultBlock:^(JJIndexType index, BOOL success, id object, NSInteger updateCount, BOOL *needMemoryCache, BOOL *needLocalCache)
     {
         NSLog(@"object4: %@", object);
     }];
    
    id object8 = [[JJApplicationLayerManager sharedInstance] getModel:NSClassFromString(@"JJWeatherJSONModel")];
    
    CFAbsoluteTime startTime1 = CFAbsoluteTimeGetCurrent();
    [[JJApplicationLayerManager sharedInstance] httpRequest:urlString protocolClass:NSClassFromString(@"JJWeatherJSONModelProtocol") httpParams:nil resultBlock:^(JJIndexType index, BOOL success, id object, NSInteger updateCount, BOOL *needMemoryCache, BOOL *needLocalCache)
     {
         double executionTime = CFAbsoluteTimeGetCurrent() - startTime1;
         NSLog(@"object5: %@, time: %f", object, executionTime);
     }];
    
    id object6 = [[JJApplicationLayerManager sharedInstance] getModel:NSClassFromString(@"JJWeatherJSONModel")];
    
    id object7 = [object6 copy];
}
