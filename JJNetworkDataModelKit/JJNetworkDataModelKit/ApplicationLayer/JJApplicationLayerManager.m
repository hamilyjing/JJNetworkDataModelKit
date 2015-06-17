//
//  JJApplicationLayerManager.m
//  JJNetworkDataModelKit
//
//  Created by JJ on 6/13/15.
//  Copyright (c) 2015 JJ Inc. All rights reserved.
//

#import "JJApplicationLayerManager.h"

#import <libkern/OSAtomic.h>

#import "JJLinkLayerManager.h"
#import "JJOperation.h"
#import "JJModel.h"

NSString *JJhttpBodyKey = @"JJhttpBodyKey";
NSString *JJhttpMethodKey = @"JJhttpMethodKey";

static NSDictionary *s_modelToOperationDic;

@interface JJApplicationLayerManager ()

@end

@interface JJApplicationLayerManager ()

@property (nonatomic, strong) NSMutableDictionary *requestResultDic;
@property (nonatomic, assign) OSSpinLock lock;

@property (nonatomic, strong) NSMutableDictionary *operationDic;

@end

@implementation JJApplicationLayerManager

+ (instancetype)sharedInstance
{
    static dispatch_once_t token;
    static JJApplicationLayerManager *manager;
    dispatch_once(&token, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {        
        self.requestResultDic = [NSMutableDictionary dictionary];
        self.lock = OS_SPINLOCK_INIT;
        
        self.operationDic = [NSMutableDictionary dictionary];
    }
    
    return self;
}

+ (void)setModelAndOperationNameDictionary:(NSDictionary *)dic
{
    s_modelToOperationDic = dic;
}

- (id)getModel:(Class)modelClass_
{
    id model = [self getModel:modelClass_ identityID:nil];
    return model;
}

- (id)getModel:(Class)modelClass_ identityID:(NSString *)identityID_
{
    JJOperation *operation = [self getOperation:modelClass_];
    id model = [operation getModelByIdentityID:identityID_];
    return model;
}

- (JJIndexType)httpRequest:(NSString *)urlString_ protocolClass:(Class)protocolClass_ httpParams:(NSDictionary *)httpParams_ resultBlock:(RequestResult)resultBlock_
{
    JJIndexType index = [self httpRequest:urlString_ protocolClass:protocolClass_ identityID:nil httpParams:httpParams_ resultBlock:resultBlock_];
    
    return index;
}

- (void)cancelHttpRequest:(JJIndexType)index_
{
    [self removeResultBlock:index_];
    
    [[JJLinkLayerManager sharedInstance] cancelHttpRequest:index_];
}

- (JJIndexType)httpRequest:(NSString *)urlString_ protocolClass:(Class)protocolClass_ identityID:(NSString *)identityID_ httpParams:(NSDictionary *)httpParams_ resultBlock:(RequestResult)resultBlock_
{
    JJIndexType index = [self getIndex];
    
    [self saveRequestResult:index resultBlock:resultBlock_];
    
    [[JJLinkLayerManager sharedInstance] httpRequest:urlString_ index:index protocolClass:protocolClass_ identityID:identityID_ httpParams:httpParams_];
    
    return index;
}

- (void)removeAllCache:(Class)modelClass_
{
    JJOperation *operation = [self getOperation:modelClass_];
    [operation removeAllCache];
}

- (void)removeAllMemoryCache:(Class)modelClass_
{
    JJOperation *operation = [self getOperation:modelClass_];
    [operation removeAllMemoryCache];
}

- (void)removeAllLocalCache:(Class)modelClass_
{
    JJOperation *operation = [self getOperation:modelClass_];
    [operation removeAllLocalCache];
}

- (void)removeCache:(Class)modelClass_ identityID:(NSString *)identityID_
{
    JJOperation *operation = [self getOperation:modelClass_];
    [operation removeCache:identityID_];
}

- (void)removeMemoryCache:(Class)modelClass_ identityID:(NSString *)identityID_
{
    JJOperation *operation = [self getOperation:modelClass_];
    [operation removeMemoryCache:identityID_];
}

- (void)removeLocalCache:(Class)modelClass_ identityID:(NSString *)identityID_
{
    JJOperation *operation = [self getOperation:modelClass_];
    [operation removeLocalCache:identityID_];
}

- (void)httpResponse:(JJIndexType)index object:(id)object error:(NSError *)error
{
    RequestResult block = [self getResultBlockAndRemove:index];
    if (!block)
    {
        return;
    }
    
    if (error || ![object isKindOfClass:[JJModel class]])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            BOOL needMemoryCache = YES;
            BOOL needLocalCache = YES;
            block(index, NO, error, 0, &needMemoryCache, &needLocalCache);
        });
        
        return;
    }
    
    JJModel *model = (JJModel *)object;
    JJOperation *operation = [self getOperation:[model class]];
    
    NSInteger updateCount = 0;
    model = [operation operateWithNewObject:model updateCount:&updateCount];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        BOOL needMemoryCache = YES;
        BOOL needLocalCache = YES;
        block(index, YES, model, updateCount, &needMemoryCache, &needLocalCache);
        
        if (0 == updateCount)
        {
            return;
        }
        
        if (needMemoryCache)
        {
            [operation setModel:model identityID:model.identityID];
        }
        
        if (needLocalCache)
        {
            [operation saveObjectToLocalCache:model identityID:model.identityID];
        }
    });
}

#pragma mark - Private

- (JJOperation *)getOperation:(Class)modelClass
{
    NSString *modelName = NSStringFromClass(modelClass);
    JJOperation *operation = _operationDic[modelName];
    if (operation)
    {
        return operation;
    }
    
    NSString *operationName = s_modelToOperationDic[modelName];
    if ([operationName length] <= 0)
    {
        NSAssert(NO, @"Can not find operation from model %@", modelName);
    }
    
    operation = [[NSClassFromString(operationName) alloc] init];
    _operationDic[modelName] = operation;
    
    return operation;
}

- (JJIndexType)getIndex
{
    static JJIndexType index = 0;
    static OSSpinLock indexLock = OS_SPINLOCK_INIT;
    
    OSSpinLockLock(&indexLock);
    ++index;
    OSSpinLockUnlock(&indexLock);
    
    return index;
}

- (void)saveRequestResult:(JJIndexType)index_ resultBlock:(RequestResult)resultBlock_
{
    if (!resultBlock_)
    {
        return;
    }
    
    OSSpinLockLock(&_lock);
    _requestResultDic[@(index_)] = [resultBlock_ copy];
    OSSpinLockUnlock(&_lock);
}

- (RequestResult)getResultBlock:(JJIndexType)index_
{
    RequestResult block;
    
    OSSpinLockLock(&_lock);
    block = _requestResultDic[@(index_)];
    OSSpinLockUnlock(&_lock);
    
    return block;
}

- (void)removeResultBlock:(JJIndexType)index_
{
    OSSpinLockLock(&_lock);
    [_requestResultDic removeObjectForKey:@(index_)];
    OSSpinLockUnlock(&_lock);
}

- (RequestResult)getResultBlockAndRemove:(JJIndexType)index_
{
    RequestResult block;
    
    OSSpinLockLock(&_lock);
    block = _requestResultDic[@(index_)];
    [_requestResultDic removeObjectForKey:@(index_)];
    OSSpinLockUnlock(&_lock);
    
    return block;
}

@end
