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
    NSString *key = @"jjKey";
    
    id object = [[JJApplicationLayerManager sharedInstance] getModel:NSClassFromString(@"JJWeatherModel")];
    NSLog(@"object = %@", object);
    
    id object1 = [[JJApplicationLayerManager sharedInstance] getModel:NSClassFromString(@"JJWeatherModel") identityID:key];
    NSLog(@"object1 = %@", object1);
    
    NSString *urlString = @"http://www.weather.com.cn/adat/sk/101010100.html";
    
    [[JJApplicationLayerManager sharedInstance] httpRequest:urlString protocolClass:NSClassFromString(@"JJWeatherProtocol") resultBlock:^(JJIndexType index, BOOL success, id object, NSInteger updateCount, BOOL *needMemoryCache, BOOL *needLocalCache)
    {
        NSLog(@"object3: %@", object);
    }];
    
    [[JJApplicationLayerManager sharedInstance] httpRequest:urlString protocolClass:NSClassFromString(@"JJWeatherProtocol") identityID:key resultBlock:^(JJIndexType index, BOOL success, id object, NSInteger updateCount, BOOL *needMemoryCache, BOOL *needLocalCache)
     {
         NSLog(@"object4: %@", object);
     }];
}
