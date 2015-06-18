//
//  JJWeatherJSONModel.m
//  JJNetworkDataModelKit
//
//  Created by hamilyjing on 6/17/15.
//  Copyright (c) 2015 JJ. All rights reserved.
//

#import "JJWeatherJSONModel.h"

@implementation JJWeatherJSONModel

+ (id)modelByContent:(NSDictionary *)content
{
    NSError *error;
    JJWeatherJSONModel *model = [[JJWeatherJSONModel alloc] initWithDictionary:content error:&error];
    
    id object = error ? error : model;
    return object;
}

@end
