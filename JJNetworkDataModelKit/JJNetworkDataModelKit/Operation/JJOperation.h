//
//  JJOperation.h
//  JJNetworkDataModelKit
//
//  Created by JJ on 6/14/15.
//  Copyright (c) 2015 JJ Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JJOperation : NSObject

@property (nonatomic, strong) NSMutableDictionary *modelDic;

- (id)getModelByIdentityID:(NSString *)identityID;
- (void)setModel:(id)model identityID:(NSString *)identityID;

- (id)operateWithNewObject:(id)newObject updateCount:(NSInteger *)updateCount;

- (void)removeAllCache;
- (void)removeAllMemoryCache;
- (void)removeAllLocalCache;

- (void)removeCache:(NSString *)identityID; // include memory and local cache
- (void)removeMemoryCache:(NSString *)identityID;
- (void)removeLocalCache:(NSString *)identityID;

// default NSKeyedArchiver and NSKeyedUnarchiver
- (id)getObjectFromLocalCache:(NSString *)identityID;
- (BOOL)saveObjectToLocalCache:(id)object identityID:(NSString *)identityID;

// file config
- (NSString *)savedFilePathIncludeIdentityID:(NSString *)identityID;
- (NSString *)savedFileDirectory;
- (NSString *)savedFileName;
- (NSString *)savedFileType;

@end
