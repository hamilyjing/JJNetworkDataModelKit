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

@end
