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
#warning - you should write the model class name to operation class name.
        s_modelToOperationDic = @{@"JJWeatherModel": @"JJWeatherOperation",};
        
        self.requestResultDic = [NSMutableDictionary dictionary];
        self.lock = OS_SPINLOCK_INIT;
        
        self.operationDic = [NSMutableDictionary dictionary];
    }
    
    return self;
}

- (id)getModel:(Class)modelClass
{
    JJOperation *operation = [self getOperation:modelClass];
    JJModel *model = operation.model;
    return model;
}

- (JJIndexType)httpRequest:(NSString *)urlString_ protocolClass:(Class)protocolClass_ resultBlock:(RequestResult)resultBlock_
{
    JJIndexType index = [self getIndex];
    
    JJIndexType anotherIndex = [[JJLinkLayerManager sharedInstance] httpRequest:urlString_ index:index protocolClass:protocolClass_];
    
    if (index != anotherIndex)
    {
        return 0;
    }
    
    [self saveRequestResult:index resultBlock:resultBlock_];
    
    return index;
}

- (void)httpResponse:(JJIndexType)index object:(id)object error:(NSError *)error
{
    RequestResult block = [self getResultBlockAndRemove:index];
    if (!block)
    {
        return;
    }
    
    if (object)
    {
        JJOperation *operation = [self getOperation:[object class]];
        
        object = [operation operateWithNewObject:object];
        operation.model = object;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            block(index, YES, object);
        });
        
        return;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        block(index, NO, error);
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
