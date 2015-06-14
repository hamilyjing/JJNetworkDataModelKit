//
//  JJApplicationLayerManager.h
//  JJNetworkDataModelKit
//
//  Created by JJ on 6/13/15.
//  Copyright (c) 2015 JJ Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef unsigned long JJIndexType;

typedef void (^RequestResult)(JJIndexType index, BOOL success, id object);

@class JJTucaoSquareModel;

@interface JJApplicationLayerManager : NSObject

+ (instancetype)sharedInstance;

- (id)getModel:(Class)modelClass;

- (JJIndexType)httpRequest:(NSString *)urlString protocolClass:(Class)protocolClass resultBlock:(RequestResult)resultBlock;

- (void)httpResponse:(JJIndexType)index object:(id)object error:(NSError *)error;

@end
