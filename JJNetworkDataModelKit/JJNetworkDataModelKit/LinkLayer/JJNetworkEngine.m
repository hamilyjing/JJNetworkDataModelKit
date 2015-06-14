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
