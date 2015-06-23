//
//  JJWeatherJSONModel.m
//  JJNetworkDataModelKit
//
//  Created by hamilyjing on 6/17/15.
//  Copyright (c) 2015 JJ. All rights reserved.
//

#import "JJWeatherJSONModel.h"

@implementation JJWeatherJSONModel

+ (id)modelByContent:(NSDictionary *)content_ error:(NSError **)error_
{
    JJWeatherJSONModel *model = [[JJWeatherJSONModel alloc] initWithDictionary:content_ error:error_];
    
    return model;
}

@end
