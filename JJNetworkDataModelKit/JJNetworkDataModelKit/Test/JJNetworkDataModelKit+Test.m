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
    id object = [[JJApplicationLayerManager sharedInstance] getModel:NSClassFromString(@"JJWeatherModel")];
    NSLog(@"%@", object);
    
    NSString *urlString = @"http://www.weather.com.cn/adat/sk/101010100.html";
    
    [[JJApplicationLayerManager sharedInstance] httpRequest:urlString protocolClass:NSClassFromString(@"JJWeatherProtocol") resultBlock:^(JJIndexType index, BOOL success, id object)
    {
        NSLog(@"object: %@", object);
    }];
}
