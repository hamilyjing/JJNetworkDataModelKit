//
//  NSDictionary+JJ.h
//  JJObjCTool
//
//  Created by hamilyjing on 5/12/15.
//  Copyright (c) 2015 gongjian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSDictionary (JJ)

#pragma mark - Safe method

- (BOOL)jj_hasKey:(NSString *)key;
- (NSString*)jj_stringForKey:(id)key;
- (NSNumber*)jj_numberForKey:(id)key;
- (NSArray*)jj_arrayForKey:(id)key;
- (NSDictionary*)jj_dictionaryForKey:(id)key;
- (NSInteger)jj_integerForKey:(id)key;
- (NSUInteger)jj_unsignedIntegerForKey:(id)key;
- (BOOL)jj_boolForKey:(id)key;
- (int16_t)jj_int16ForKey:(id)key;
- (int32_t)jj_int32ForKey:(id)key;
- (int64_t)jj_int64ForKey:(id)key;
- (char)jj_charForKey:(id)key;
- (short)jj_shortForKey:(id)key;
- (float)jj_floatForKey:(id)key;
- (double)jj_doubleForKey:(id)key;
- (long long)jj_longLongForKey:(id)key;
- (unsigned long long)jj_unsignedLongLongForKey:(id)key;

#pragma mark - Get CG object

- (CGFloat)jj_CGFloatForKey:(id)key;
- (CGPoint)jj_pointForKey:(id)key;
- (CGSize)jj_sizeForKey:(id)key;
- (CGRect)jj_rectForKey:(id)key;

#pragma mark - JSON

- (NSString *)jj_JSONString;
- (NSData *)jj_JSONSData;

#pragma mark - Merge

+ (NSDictionary *)jj_dictionaryByMerging:(NSDictionary *)dict1 with:(NSDictionary *)dict2;
- (NSDictionary *)jj_dictionaryByMergingWith:(NSDictionary *)dict;

#pragma mark - Sort

- (NSDictionary *)jj_exchangeKeyAndValue;

- (NSArray *)jj_valuesByKeys:(NSArray *)keys;

- (NSArray *)jj_keyListBySortNSNumberLongKey:(BOOL)ascendingOrder;
- (NSArray *)jj_keyListBySortNSStringLongKey:(BOOL)ascendingOrder;

- (NSArray *)jj_valueListBySortNSNumberLongValue:(BOOL)ascendingOrder;
- (NSArray *)jj_valueListBySortNSStringLongValue:(BOOL)ascendingOrder;

@end
