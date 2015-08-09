//
//  JJJSONDataModel.m
//  JJNetworkDataModelKit
//
//  Created by hamilyjing on 8/9/15.
//  Copyright (c) 2015 JJ. All rights reserved.
//

#import "JJJSONDataModel.h"

@implementation JJJSONDataModel

+ (id)modelByContent:(NSDictionary *)content_ error:(NSError **)error_
{
    JJJSONDataModel *model = [[JJJSONDataModel alloc] init];
    model.jsonData = content_;
    
    return model;
}

@end
