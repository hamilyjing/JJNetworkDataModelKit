//
//  JJOperation.h
//  JJNetworkDataModelKit
//
//  Created by JJ on 6/14/15.
//  Copyright (c) 2015 JJ Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JJModelDelegate;

@interface JJOperation : NSObject

@property (nonatomic, strong) NSMutableDictionary *modelDic;

// Model

- (id)getModelByIdentityID:(NSString *)identityID;
- (void)setModel:(id)model identityID:(NSString *)identityID;

// Merge

- (id)operateWithNewObject:(id)newObject updateCount:(NSInteger *)updateCount;

- (id)operateWithNewObject:(id)newObject oldObject:(id)oldObject updateCount:(NSInteger *)updateCount;

// Remove cache

- (void)removeAllCache;
- (void)removeAllMemoryCache;
- (void)removeAllLocalCache;

- (void)removeCache:(NSString *)identityID; // include memory and local cache
- (void)removeMemoryCache:(NSString *)identityID;
- (void)removeLocalCache:(NSString *)identityID;

- (void)removeExpiredCache:(NSString *)prefixIdentityID secondOfexpiredTime:(NSInteger)secondOfexpiredTime;

// Clean resource

- (void)cleanResourceByModel:(id<JJModelDelegate>)model;

// default NSKeyedArchiver and NSKeyedUnarchiver
- (id)getObjectFromLocalCache:(NSString *)identityID;
- (BOOL)saveObjectToLocalCache:(id)object identityID:(NSString *)identityID;
- (BOOL)haveLocalCache:(NSString *)identityID;

// file config
- (NSString *)savedFilePathIncludeIdentityID:(NSString *)identityID;
- (NSString * )savedFileDirectory:(NSString *)identityID;
- (NSString *)savedFileName:(NSString *)identityID;
- (NSString *)savedFileType:(NSString *)identityID;

@end
