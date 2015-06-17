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
#import "JJModel.h"

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

- (JJIndexType)httpRequest:(NSString *)urlString_ index:(JJIndexType)index_ protocolClass:(Class)protocolClass_ identityID:(NSString *)identityID_ httpParams:(NSDictionary *)httpParams_
{
    JJNetworkEngine *engine = [[JJNetworkEngine alloc] initWithHostName:@"www.baidu.com"];
    engine.urlString = urlString_;
    engine.index = index_;
    engine.protocolClass = protocolClass_;
    engine.identityID = identityID_;
    engine.httpParams = httpParams_;
    
    [self saveEngine:index_ engine:engine];
    
    [engine httpRequest];
    
    return index_;
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
        
        JJProtocol *protocol = [[engine_.protocolClass alloc] init];
        id object = [protocol decodeTemplate:content];
        
        if ([object isKindOfClass:JJModel.class])
        {
            JJModel *model = (JJModel *)object;
            model.identityID = engine_.identityID;
            
            [[JJApplicationLayerManager sharedInstance] httpResponse:engine_.index object:model error:nil];
        }
        else if ([object isKindOfClass:NSError.class])
        {
            [[JJApplicationLayerManager sharedInstance] httpResponse:engine_.index object:nil error:object];
        }
        else
        {
            NSAssert(NO, @"Can not know object: %@", object);
        }
        
    } while (NO);
    
    [self removeEngine:engine_.index];
}

#pragma mark - Private

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
