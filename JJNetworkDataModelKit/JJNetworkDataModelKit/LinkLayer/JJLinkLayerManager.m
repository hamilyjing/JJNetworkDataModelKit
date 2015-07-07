//
//  JJLinkLayerManager.m
//  JJNetworkDataModelKit
//
//  Created by JJ on 6/13/15.
//  Copyright (c) 2015 JJ Inc. All rights reserved.
//

#import "JJLinkLayerManager.h"

#import <libkern/OSAtomic.h>

#import "JJNetworkEngine.h"
#import "JJProtocol.h"
#import "JJModelDelegate.h"

@interface JJLinkLayerManager ()

@property (nonatomic, strong) NSMutableDictionary *engineDic;
@property (nonatomic, assign) OSSpinLock lock;

@end

@implementation JJLinkLayerManager

+ (instancetype)sharedInstance
{
    static dispatch_once_t token;
    static JJLinkLayerManager *manager;
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
        self.engineDic = [NSMutableDictionary dictionary];
        self.lock = OS_SPINLOCK_INIT;
    }
    
    return self;
}

- (JJIndexType)httpRequest:(NSString *)urlString_ index:(JJIndexType)index_ modelOrProtocolClass:(Class)modelOrProtocolClass_ identityID:(NSString *)identityID_ httpParams:(NSDictionary *)httpParams_
{
    JJNetworkEngine *engine = [[JJNetworkEngine alloc] initWithHostName:@"www.baidu.com"];
    engine.urlString = urlString_;
    engine.index = index_;
    engine.modelOrProtocolClass = modelOrProtocolClass_;
    engine.identityID = identityID_;
    engine.httpParams = httpParams_;
    
    [self saveEngine:index_ engine:engine];
    
    [engine httpRequest];
    
    return index_;
}

- (void)cancelHttpRequest:(JJIndexType)index_
{
    JJNetworkEngine *engine = [self getEngineAndRemove:index_];
    [engine cancelHttpRequest];
}

- (void)httpResponse:(JJNetworkEngine*)engine_ completedOperation:(MKNetworkOperation *)completedOperation_ error:(NSError *)error_
{
    do {
        if (error_)
        {
            [[JJApplicationLayerManager sharedInstance] httpResponse:engine_.index object:nil error:error_];
            break;
        }
        
        NSData *data = [completedOperation_ responseData];
        id content = [NSJSONSerialization JSONObjectWithData:data
                                                     options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves
                                                       error:nil];
        
        id object;
        NSError *error;
        
        JJDLog(@"[Link layer][Response] index:%lu, content:%@", engine_.index, content);
        
        Class modelOrProtocolClass = engine_.modelOrProtocolClass;
        if ([modelOrProtocolClass conformsToProtocol:NSProtocolFromString(@"JJModelDelegate")])
        {
            object = [(id<JJModelDelegate>)modelOrProtocolClass modelByContent:content error:&error];
        }
        else
        {
            JJProtocol *protocol = [[engine_.modelOrProtocolClass alloc] init];
            object = [protocol decodeTemplate:content error:&error];
        }
        
        if ([object conformsToProtocol:NSProtocolFromString(@"JJModelDelegate")])
        {
            id<JJModelDelegate> model = object;
            model.identityID = engine_.identityID;
            
            [[JJApplicationLayerManager sharedInstance] httpResponse:engine_.index object:model error:nil];
        }
        else if (error)
        {
            [[JJApplicationLayerManager sharedInstance] httpResponse:engine_.index object:nil error:error];
        }
        else
        {
            NSAssert(NO, @"Can not know object: %@", object);
        }
        
    } while (NO);
    
    [self removeEngine:engine_.index];
}

#pragma mark - Private

- (JJNetworkEngine *)getEngine:(JJIndexType)index_
{
    JJNetworkEngine *engine;
    
    OSSpinLockLock(&_lock);
    engine = _engineDic[@(index_)];
    OSSpinLockUnlock(&_lock);
    
    return engine;
}

- (JJNetworkEngine *)getEngineAndRemove:(JJIndexType)index_
{
    JJNetworkEngine *engine;
    
    OSSpinLockLock(&_lock);
    engine = _engineDic[@(index_)];
    [_engineDic removeObjectForKey:@(index_)];
    OSSpinLockUnlock(&_lock);
    
    return engine;
}

- (void)saveEngine:(JJIndexType)index_ engine:(JJNetworkEngine*)engine_
{
    OSSpinLockLock(&_lock);
    _engineDic[@(index_)] = engine_;
    OSSpinLockUnlock(&_lock);
}

- (void)removeEngine:(JJIndexType)index_
{
    OSSpinLockLock(&_lock);
    [_engineDic removeObjectForKey:@(index_)];
    OSSpinLockUnlock(&_lock);
}

@end
