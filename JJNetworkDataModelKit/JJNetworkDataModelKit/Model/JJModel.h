//
//  JJModel.h
//  JJNetworkDataModelKit
//
//  Created by JJ on 6/13/15.
//  Copyright (c) 2015 JJ Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JJMantleHeader.h"

@interface JJModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *identityID;

+ (NSArray *)imagePropetyNames;

@end
