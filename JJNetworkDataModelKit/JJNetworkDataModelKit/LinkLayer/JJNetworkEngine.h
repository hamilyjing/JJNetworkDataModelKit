//
//  JJNetworkEngine.h
//  JJNetworkDataModelKit
//
//  Created by JJ on 6/13/15.
//  Copyright (c) 2015 JJ Inc. All rights reserved.
//

#import "MKNetworkEngine.h"

#import "JJApplicationLayerManager.h"

@interface JJNetworkEngine : MKNetworkEngine

@property (nonatomic, assign) JJIndexType index;
@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, assign) Class modelOrProtocolClass;
@property (nonatomic, copy) NSString *identityID;
@property (nonatomic, strong) NSDictionary *httpParams;

- (void)httpRequest;
- (void)cancelHttpRequest;

@end
