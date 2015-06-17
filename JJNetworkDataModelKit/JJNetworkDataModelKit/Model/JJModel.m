//
//  JJModel.m
//  JJNetworkDataModelKit
//
//  Created by JJ on 6/13/15.
//  Copyright (c) 2015 JJ Inc. All rights reserved.
//

#import "JJModel.h"

@implementation JJModel

- (void)setNilValueForKey:(NSString *)key {
    [self setValue:@0 forKey:key]; // For NSInteger/CGFloat/BOOL
}

#pragma mark - MTLJSONSerializing

+ (NSValueTransformer *)JSONTransformerForKey:(NSString *)key
{
    return nil;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return nil;
}

+ (NSArray *)imagePropetyNames
{
    return nil;
}

+ (id)modelByContent:(NSDictionary *)content
{
    return nil;
}

+ (NSArray *)arrayData:(Class)modelClass_ fromArrayContent:(NSArray *)arrayContent_
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

@end
