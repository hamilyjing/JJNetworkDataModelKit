//
//  JJApplicationLayerManager.h
//  JJNetworkDataModelKit
//
//  Created by JJ on 6/13/15.
//  Copyright (c) 2015 JJ Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef unsigned long JJIndexType;

typedef void (^RequestResult)(JJIndexType index, BOOL success, id object, NSInteger updateCount, BOOL *needMemoryCache, BOOL *needLocalCache);

@class JJTucaoSquareModel;

@interface JJApplicationLayerManager : NSObject

+ (instancetype)sharedInstance;

- (id)getModel:(Class)modelClass;

- (id)getModel:(Class)modelClass identityID:(NSString *)identityID;

- (JJIndexType)httpRequest:(NSString *)urlString protocolClass:(Class)protocolClass resultBlock:(RequestResult)resultBlock;

- (JJIndexType)httpRequest:(NSString *)urlString protocolClass:(Class)protocolClass identityID:(NSString *)identityID resultBlock:(RequestResult)resultBlock;

- (void)removeAllCache:(Class)modelClass;
- (void)removeAllMemoryCache:(Class)modelClass;
- (void)removeAllLocalCache:(Class)modelClass;

- (void)removeCache:(Class)modelClass identityID:(NSString *)identityID; // include memory and local cache
- (void)removeMemoryCache:(Class)modelClass identityID:(NSString *)identityID;
- (void)removeLocalCache:(Class)modelClass identityID:(NSString *)identityID;

- (void)httpResponse:(JJIndexType)index object:(id)object error:(NSError *)error;

@end
