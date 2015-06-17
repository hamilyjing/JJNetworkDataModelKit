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

- (NSArray *)arrayData:(Class)modelClass_ fromArrayContent:(NSArray *)arrayContent_
{
    NSMutableArray *tempArray = [NSMutableArray array];
    
    [arrayContent_ enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
         NSError *error;
         id object = [MTLJSONAdapter modelOfClass:modelClass_ fromJSONDictionary:obj error:&error];
         if (object)
         {
             [tempArray addObject:object];
         }
         else
         {
             NSAssert(NO, @"%@", error);
         }
     }];
    
    return [tempArray count] > 0 ? tempArray : nil;
}

- (id)decode:(NSDictionary *)content
{
    return nil;
}

@end
