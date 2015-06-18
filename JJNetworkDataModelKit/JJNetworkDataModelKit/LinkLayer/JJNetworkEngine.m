//
//  JJNetworkEngine.m
//  JJNetworkDataModelKit
//
//  Created by JJ on 6/13/15.
//  Copyright (c) 2015 JJ Inc. All rights reserved.
//

#import "JJNetworkEngine.h"

#import "JJLinkLayerManager.h"

@interface JJNetworkEngine ()

@property (nonatomic, strong) MKNetworkOperation *netWorkOperation;

@end

@implementation JJNetworkEngine

- (void)httpRequest
{
    NSMutableDictionary *body = [_httpParams[JJhttpBodyKey] mutableCopy];
    NSString *method = _httpParams[JJhttpMethodKey];
    method = method ? method : @"GET";
    
    self.netWorkOperation = [self operationWithURLString:_urlString params:body httpMethod:method];
    
    NSAssert(_netWorkOperation, @"Network operation can not be nil");
    
    if (!_netWorkOperation)
    {
        NSError *error = [NSError errorWithDomain:NSOSStatusErrorDomain code:100 userInfo:@{NSLocalizedDescriptionKey: @"Can not create network operation object!"}];
        [[JJLinkLayerManager sharedInstance] httpResponse:self completedOperation:nil error:error];
        return;
    }
    
    __weak JJNetworkEngine *weakSelf = self;
    
    [_netWorkOperation addCompletionHandler:^(MKNetworkOperation *completedOperation)
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [[JJLinkLayerManager sharedInstance] httpResponse:weakSelf completedOperation:completedOperation error:nil];
        });
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error)
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [[JJLinkLayerManager sharedInstance] httpResponse:weakSelf completedOperation:nil error:error];
        });
    }];
    
    [self enqueueOperation:_netWorkOperation];
}

- (void)cancelHttpRequest
{
    [_netWorkOperation cancel];
    self.netWorkOperation = nil;
}

@end
