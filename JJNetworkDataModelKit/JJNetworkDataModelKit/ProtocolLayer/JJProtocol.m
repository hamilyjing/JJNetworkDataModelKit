//
//  JJProtocol.m
//  JJNetworkDataModelKit
//
//  Created by JJ on 6/13/15.
//  Copyright (c) 2015 JJ Inc. All rights reserved.
//

#import "JJProtocol.h"

#import "JJMantleHeader.h"

@implementation JJProtocol

- (id)decodeTemplate:(NSDictionary *)content
{
    NSInteger errorNo = [content[@"errno"] integerValue];
    if (0 != errorNo)
    {
        NSError *error = [NSError errorWithDomain:NSOSStatusErrorDomain code:errorNo userInfo:@{NSLocalizedDescriptionKey: content[@"error"]}];
        return error;
    }
    
    id object = [self decode:content];
    
    if (!object)
    {
        NSString *message = [NSString stringWithFormat:@"Can not decode content: %@", content];
        NSError *error = [NSError errorWithDomain:NSOSStatusErrorDomain code:101 userInfo:@{NSLocalizedDescriptionKey: message}];
        return error;
    }
    
    return object;
}

- (id)decode:(NSDictionary *)content
{
    return nil;
}

@end
