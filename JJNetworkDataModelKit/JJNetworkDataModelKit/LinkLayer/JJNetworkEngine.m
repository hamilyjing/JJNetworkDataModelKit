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

@property (nonatomic ,strong) MKNetworkOperation *netWorkOperation;

@end

@implementation JJNetworkEngine

- (void)httpRequest
{
    [self cancelHttpRequest];
    
    self.netWorkOperation = [self operationWithURLString:_urlString];
    
    NSDictionary *body = _httpParams[JJhttpBodyKey];
    NSString *method = _httpParams[JJhttpMethodKey];
    method = method ? method : @"GET";
    
    [self operationWithURLString:_urlString params:body httpMethod:method];
    
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
        [[JJLinkLayerManager sharedInstance] httpResponse:weakSelf completedOperation:completedOperation error:nil];
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error)
    {
        [[JJLinkLayerManager sharedInstance] httpResponse:weakSelf completedOperation:nil error:error];
    }];
    
    [self enqueueOperation:_netWorkOperation];
}

- (void)cancelHttpRequest
{
    [_netWorkOperation cancel];
    self.netWorkOperation = nil;
}

@end
