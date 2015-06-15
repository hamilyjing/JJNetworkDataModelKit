//
//  JJWeatherProtocol.m
//  JJNetworkDataModelKit
//
//  Created by gongjian03 on 6/15/15.
//  Copyright (c) 2015 JJ. All rights reserved.
//

#import "JJWeatherProtocol.h"

#import "JJWeatherModel.h"

@implementation JJWeatherProtocol

- (id)decode:(NSDictionary *)content
{
    NSError *error;
    JJWeatherModel *weatherModel = [MTLJSONAdapter modelOfClass:JJWeatherModel.class fromJSONDictionary:content[@"weatherinfo"] error:&error];
    if (nil == weatherModel)
    {
        return error;
    }
    
    return weatherModel;
}

@end
