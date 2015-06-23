//
//  JJJSONModel.m
//  JJNetworkDataModelKit
//
//  Created by hamilyjing on 6/18/15.
//  Copyright (c) 2015 JJ. All rights reserved.
//

#import "JJJSONModel.h"

@implementation JJJSONModel

+ (id)modelByContent:(NSDictionary *)content_ error:(NSError **)error_
{
    id object;
    NSError *error;
    
    do {
        NSInteger errorNo = [content_[@"errno"] integerValue];
        if (0 != errorNo)
        {
            error = [NSError errorWithDomain:NSOSStatusErrorDomain code:errorNo userInfo:@{NSLocalizedDescriptionKey: content_[@"error"]}];
            break;
        }
        
        id dataValue = content_[@"data"];
        if ([dataValue isKindOfClass:[NSArray class]])
        {
            object = [[self alloc] init];
        }
        else
        {
            object = [[self alloc] initWithDictionary:dataValue error:&error];
        }
        
    } while (NO);
    
    *error_ = error;
    
    return object;
}

@end
