//
//  JJProtocol.h
//  JJNetworkDataModelKit
//
//  Created by JJ on 6/13/15.
//  Copyright (c) 2015 JJ Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JJProtocol : NSObject

- (id)decodeTemplate:(NSDictionary *)content;

// Overwrite by son
- (id)decode:(NSDictionary *)content;

@end
