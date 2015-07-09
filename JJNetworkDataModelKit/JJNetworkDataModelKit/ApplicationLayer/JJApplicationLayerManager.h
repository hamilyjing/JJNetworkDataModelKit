//
//  JJApplicationLayerManager.h
//  JJNetworkDataModelKit
//
//  Created by JJ on 6/13/15.
//  Copyright (c) 2015 JJ Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef DEBUG
#define JJDLog(fmt, ...) NSLog((@"[line:%d] " fmt), __LINE__, ##__VA_ARGS__);
#else
#define JJDLog(...)
#endif

typedef unsigned long JJIndexType;

extern NSString *JJhttpBodyKey;
extern NSString *JJhttpMethodKey;

typedef void (^RequestResult)(JJIndexType index, BOOL success, id object, NSInteger updateCount, BOOL *needMemoryCache, BOOL *needLocalCache);

@class JJTucaoSquareModel;

@interface JJApplicationLayerManager : NSObject

+ (instancetype)sharedInstance;

+ (void)setModelAndOperationNameDictionary:(NSDictionary *)dic;

- (id)getModel:(Class)modelClass;

- (id)getModel:(Class)modelClass identityID:(NSString *)identityID;

- (JJIndexType)httpRequest:(NSString *)urlString modelOrProtocolClass:(Class)modelOrProtocolClass httpParams:(NSDictionary *)httpParams resultBlock:(RequestResult)resultBlock;

- (void)cancelHttpRequest:(JJIndexType)index;

- (JJIndexType)httpRequest:(NSString *)urlString modelOrProtocolClass:(Class)modelOrProtocolClass identityID:(NSString *)identityID httpParams:(NSDictionary *)httpParams resultBlock:(RequestResult)resultBlock;

// Save model

- (void)saveModel:(id)model identityID:(NSString *)identityID; // include memory and local
- (void)saveModelToMemory:(id)model identityID:(NSString *)identityID;
- (void)saveModelToLocal:(id)model identityID:(NSString *)identityID;

// Remove cache

- (void)removeAllCache:(Class)modelClass;
- (void)removeAllMemoryCache:(Class)modelClass;
- (void)removeAllLocalCache:(Class)modelClass;

- (void)removeCache:(Class)modelClass identityID:(NSString *)identityID; // include memory and local cache
- (void)removeMemoryCache:(Class)modelClass identityID:(NSString *)identityID;
- (void)removeLocalCache:(Class)modelClass identityID:(NSString *)identityID;

// Http response

- (void)httpResponse:(JJIndexType)index object:(id)object error:(NSError *)error;

@end
