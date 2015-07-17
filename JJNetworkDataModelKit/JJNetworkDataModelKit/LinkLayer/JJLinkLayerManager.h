//
//  JJLinkLayerManager.h
//  JJNetworkDataModelKit
//
//  Created by JJ on 6/13/15.
//  Copyright (c) 2015 JJ Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JJApplicationLayerManager.h"

@class MKNetworkOperation;
@class JJNetworkEngine;

@interface JJLinkLayerManager : NSObject

+ (instancetype)sharedInstance;

- (JJIndexType)httpRequest:(NSString *)urlString index:(JJIndexType)index modelOrProtocolClass:(Class)modelOrProtocolClass identityID:(NSString *)identityID httpParams:(NSDictionary *)httpParams;

- (void)cancelHttpRequest:(JJIndexType)index;
- (void)cancelAllHttpRequest;

- (void)httpResponse:(JJNetworkEngine*)engine completedOperation:(MKNetworkOperation *)completedOperation error:(NSError *)error;

@end
