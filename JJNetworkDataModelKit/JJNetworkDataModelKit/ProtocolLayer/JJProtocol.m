//
//  JJProtocol.m
//  JJNetworkDataModelKit
//
//  Created by JJ on 6/13/15.
//  Copyright (c) 2015 JJ Inc. All rights reserved.
//

#import "JJProtocol.h"

@implementation JJProtocol

- (id)decodeTemplate:(NSDictionary *)content_ error:(NSError **)error_
{
    NSInteger errorNo = [content_[@"errno"] integerValue];
    if (0 != errorNo)
    {
        NSError *error = [NSError errorWithDomain:NSOSStatusErrorDomain code:errorNo userInfo:@{NSLocalizedDescriptionKey: content_[@"error"]}];
        *error_ = error;
        return nil;
    }
    
    id object = [self decode:content_ error:error_];
    
    return object;
}

- (id)decode:(NSDictionary *)content error:(NSError **)error
{
    return nil;
}

@end
