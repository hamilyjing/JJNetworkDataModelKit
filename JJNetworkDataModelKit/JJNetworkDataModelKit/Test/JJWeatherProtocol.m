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
    JJWeatherModel *weatherModel = [JJWeatherModel modelByContent:content];
    return weatherModel;
}

@end
