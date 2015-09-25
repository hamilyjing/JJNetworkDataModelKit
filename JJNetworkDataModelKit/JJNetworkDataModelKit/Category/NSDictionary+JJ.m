//
//  NSDictionary+JJ.m
//  JJObjCTool
//
//  Created by hamilyjing on 5/12/15.
//  Copyright (c) 2015 gongjian. All rights reserved.
//

#import "NSDictionary+JJ.h"

@implementation NSDictionary (JJ)

#pragma mark - Safe method

- (BOOL)jj_hasKey:(NSString *)key
{
    return [self objectForKey:key] != nil;
}

- (NSString*)jj_stringForKey:(id)key
{
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null])
    {
        return nil;
    }
    if ([value isKindOfClass:[NSString class]]) {
        return (NSString*)value;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value stringValue];
    }
    
    NSAssert(NO, @"Value(%@) is not NSString class.", value);
    
    return nil;
}

- (NSNumber*)jj_numberForKey:(id)key
{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSNumber class]]) {
        return (NSNumber*)value;
    }
    if ([value isKindOfClass:[NSString class]]) {
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        return [f numberFromString:(NSString*)value];
    }
    
    NSAssert(NO, @"Value(%@) is not NSNumber class.", value);
    
    return nil;
}

- (NSArray*)jj_arrayForKey:(id)key
{
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null])
    {
        return nil;
    }
    if ([value isKindOfClass:[NSArray class]])
    {
        return value;
    }
    
    NSAssert(NO, @"Value(%@) is not NSArray class.", value);
    
    return nil;
}

- (NSDictionary*)jj_dictionaryForKey:(id)key
{
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null])
    {
        return nil;
    }
    if ([value isKindOfClass:[NSDictionary class]])
    {
        return value;
    }
    
    NSAssert(NO, @"Value(%@) is not NSDictionary class.", value);
    
    return nil;
}

- (NSInteger)jj_integerForKey:(id)key
{
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]])
    {
        return [value integerValue];
    }
    
    NSAssert(NO, @"Value(%@) can not convert to NSInteger.", value);
    
    return 0;
}
- (NSUInteger)jj_unsignedIntegerForKey:(id)key{
    id value = [self objectForKey:key];
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]])
    {
        return [value unsignedIntegerValue];
    }
    
    NSAssert(NO, @"Value(%@) can not convert to NSUInteger.", value);
    
    return 0;
}
- (BOOL)jj_boolForKey:(id)key
{
    id value = [self objectForKey:key];
    
    if (value == nil || value == [NSNull null])
    {
        return NO;
    }
    if ([value isKindOfClass:[NSNumber class]])
    {
        return [value boolValue];
    }
    if ([value isKindOfClass:[NSString class]])
    {
        return [value boolValue];
    }
    
    NSAssert(NO, @"Value(%@) can not convert to BOOL.", value);
    
    return NO;
}
- (int16_t)jj_int16ForKey:(id)key
{
    id value = [self objectForKey:key];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]])
    {
        return [value shortValue];
    }
    if ([value isKindOfClass:[NSString class]])
    {
        return [value intValue];
    }
    
    NSAssert(NO, @"Value(%@) can not convert to int16_t.", value);
    
    return 0;
}
- (int32_t)jj_int32ForKey:(id)key
{
    id value = [self objectForKey:key];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value intValue];
    }
    
    NSAssert(NO, @"Value(%@) can not convert to int32_t.", value);
    
    return 0;
}
- (int64_t)jj_int64ForKey:(id)key
{
    id value = [self objectForKey:key];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value longLongValue];
    }
    
    NSAssert(NO, @"Value(%@) can not convert to int64_t.", value);
    
    return 0;
}
- (char)jj_charForKey:(id)key{
    id value = [self objectForKey:key];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value charValue];
    }
    
    NSAssert(NO, @"Value(%@) can not convert to char.", value);
    
    return 0;
}
- (short)jj_shortForKey:(id)key
{
    id value = [self objectForKey:key];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]])
    {
        return [value shortValue];
    }
    if ([value isKindOfClass:[NSString class]])
    {
        return [value intValue];
    }
    
    NSAssert(NO, @"Value(%@) can not convert to short.", value);
    
    return 0;
}
- (float)jj_floatForKey:(id)key
{
    id value = [self objectForKey:key];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value floatValue];
    }
    
    NSAssert(NO, @"Value(%@) can not convert to float.", value);
    
    return 0;
}
- (double)jj_doubleForKey:(id)key
{
    id value = [self objectForKey:key];
    
    if (value == nil || value == [NSNull null])
    {
        return 0;
    }
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
    {
        return [value doubleValue];
    }
    
    NSAssert(NO, @"Value(%@) can not convert to double.", value);
    
    return 0;
}
- (long long)jj_longLongForKey:(id)key
{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
        return [value longLongValue];
    }
    
    NSAssert(NO, @"Value(%@) can not convert to long long.", value);
    
    return 0;
}

- (unsigned long long)jj_unsignedLongLongForKey:(id)key
{
    id value = [self objectForKey:key];
    if ([value isKindOfClass:[NSString class]]) {
        NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
        value = [nf numberFromString:value];
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value unsignedLongLongValue];
    }
    
    NSAssert(NO, @"Value(%@) can not convert to unsigned long long.", value);
    
    return 0;
}

#pragma mark - Get CG object

- (CGFloat)jj_CGFloatForKey:(id)key
{
    CGFloat f = [self[key] doubleValue];
    return f;
}

- (CGPoint)jj_pointForKey:(id)key
{
    CGPoint point = CGPointFromString(self[key]);
    return point;
}
- (CGSize)jj_sizeForKey:(id)key
{
    CGSize size = CGSizeFromString(self[key]);
    return size;
}
- (CGRect)jj_rectForKey:(id)key
{
    CGRect rect = CGRectFromString(self[key]);
    return rect;
}

#pragma mark - JSON

- (NSString *)jj_JSONString
{
    NSData *jsonData = [self jj_JSONSData];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

- (NSData *)jj_JSONSData
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if (error)
    {
        NSAssert(NO, @"From JSON object to data error: %@", error);
    }
    
    return jsonData;
}

#pragma mark - Merge

+ (NSDictionary *)jj_dictionaryByMerging:(NSDictionary *)dict1 with:(NSDictionary *)dict2 {
    NSMutableDictionary * result = [NSMutableDictionary dictionaryWithDictionary:dict1];
    [dict2 enumerateKeysAndObjectsUsingBlock: ^(id key, id obj, BOOL *stop)
    {
        if (![dict1 objectForKey:key])
        {
            if ([obj isKindOfClass:[NSDictionary class]])
            {
                NSDictionary * newVal = [[dict1 objectForKey: key] jj_dictionaryByMergingWith: (NSDictionary *) obj];
                [result setObject: newVal forKey: key];
            }
            else
            {
                [result setObject: obj forKey: key];
            }
        }
    }];
    return (NSDictionary *) [result mutableCopy];
}

- (NSDictionary *)jj_dictionaryByMergingWith:(NSDictionary *)dict {
    return [[self class] jj_dictionaryByMerging:self with: dict];
}

#pragma mark - Sort

- (NSDictionary *)jj_exchangeKeyAndValue
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop)
    {
        dic[obj] = key;
    }];
    
    return dic;
}

- (NSArray *)jj_valuesByKeys:(NSArray *)keys_
{
    NSMutableArray *valueList = [NSMutableArray array];
    [keys_ enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
    {
        id value = self[obj];
        if (value)
        {
            [valueList addObject:value];
        }
    }];
    
    return valueList;
}

- (NSArray *)jj_keyListBySortNSNumberLongKey:(BOOL)ascendingOrder_
{
    NSArray *sortKeys = [[self allKeys] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2)
                           {
                               if ([obj1 longValue] == [obj2 longValue])
                               {
                                   return (NSComparisonResult)NSOrderedSame;
                               }
                               
                               if ([obj1 longValue] > [obj2 longValue])
                               {
                                   if (ascendingOrder_)
                                   {
                                       return (NSComparisonResult)NSOrderedDescending;
                                   }
                                   else
                                   {
                                       return (NSComparisonResult)NSOrderedAscending;
                                   }
                               }
                               else
                               {
                                   if (ascendingOrder_)
                                   {
                                       return (NSComparisonResult)NSOrderedAscending;
                                   }
                                   else
                                   {
                                       return (NSComparisonResult)NSOrderedDescending;
                                   }
                               }
                           }];
    
    return sortKeys;
}

- (NSArray *)jj_keyListBySortNSStringLongKey:(BOOL)ascendingOrder_
{
    NSArray *sortKeys = [[self allKeys] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2)
                         {
                             if ([obj1 longLongValue] == [obj2 longLongValue])
                             {
                                 return (NSComparisonResult)NSOrderedSame;
                             }
                             
                             if ([obj1 longLongValue] > [obj2 longLongValue])
                             {
                                 if (ascendingOrder_)
                                 {
                                     return (NSComparisonResult)NSOrderedDescending;
                                 }
                                 else
                                 {
                                     return (NSComparisonResult)NSOrderedAscending;
                                 }
                             }
                             else
                             {
                                 if (ascendingOrder_)
                                 {
                                     return (NSComparisonResult)NSOrderedAscending;
                                 }
                                 else
                                 {
                                     return (NSComparisonResult)NSOrderedDescending;
                                 }
                             }
                         }];
    
    return sortKeys;
}

- (NSArray *)jj_valueListBySortNSNumberLongValue:(BOOL)ascendingOrder_
{
    NSArray *allValues = [self allValues];
    NSArray *sortValues = [allValues sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2)
    {
        if ([obj1 longValue] == [obj2 longValue])
        {
            return (NSComparisonResult)NSOrderedSame;
        }
        
        if ([obj1 longValue] > [obj2 longValue])
        {
            if (ascendingOrder_)
            {
                return (NSComparisonResult)NSOrderedDescending;
            }
            else
            {
                return (NSComparisonResult)NSOrderedAscending;
            }
        }
        else
        {
            if (ascendingOrder_)
            {
                return (NSComparisonResult)NSOrderedAscending;
            }
            else
            {
                return (NSComparisonResult)NSOrderedDescending;
            }
        }
    }];
    
    return sortValues;
}

- (NSArray *)jj_valueListBySortNSStringLongValue:(BOOL)ascendingOrder_
{
    NSArray *allValues = [self allValues];
    
    NSArray *sortValues = [allValues sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2)
    {
        if ([obj1 longLongValue] == [obj2 longLongValue])
        {
            return (NSComparisonResult)NSOrderedSame;
        }
        
        if ([obj1 longLongValue] > [obj2 longLongValue])
        {
            if (ascendingOrder_)
            {
                return (NSComparisonResult)NSOrderedDescending;
            }
            else
            {
                return (NSComparisonResult)NSOrderedAscending;
            }
        }
        else
        {
            if (ascendingOrder_)
            {
                return (NSComparisonResult)NSOrderedAscending;
            }
            else
            {
                return (NSComparisonResult)NSOrderedDescending;
            }
        }
    }];
    
    return sortValues;
}

@end
