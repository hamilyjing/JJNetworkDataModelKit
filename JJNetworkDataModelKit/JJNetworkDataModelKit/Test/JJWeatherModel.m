//
//  JJWeatherModel.m
//  JJNetworkDataModelKit
//
//  Created by gongjian03 on 6/15/15.
//  Copyright (c) 2015 JJ. All rights reserved.
//

#import "JJWeatherModel.h"

@implementation JJWeatherModel

+ (id)modelByContent:(NSDictionary *)content
{
    NSError *error;
    JJWeatherModel *weatherModel = [MTLJSONAdapter modelOfClass:JJWeatherModel.class fromJSONDictionary:content[@"weatherinfo"] error:&error];
    if (nil == weatherModel)
    {
        return error;
    }
    
    return weatherModel;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"city": @"city",
             @"cityid": @"cityid",
             @"temp": @"temp",
             @"WD": @"WD",
             @"WS": @"WS",
             @"SD": @"SD",
             @"WSE": @"WSE",
             @"time": @"time",
             @"isRadar": @"isRadar",
             @"Radar": @"Radar",
             @"njd": @"njd",
             @"qy": @"qy",
             };
}

@end
