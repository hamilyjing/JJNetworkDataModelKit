//
//  JJModel.h
//  JJNetworkDataModelKit
//
//  Created by JJ on 6/13/15.
//  Copyright (c) 2015 JJ Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "JJMantleHeader.h"
#import "JJModelDelegate.h"

@interface JJModel : MTLModel <MTLJSONSerializing, JJModelDelegate>

@property (nonatomic, copy) NSString *identityID;

+ (NSArray *)imagePropetyNames;

+ (NSArray *)arrayData:(Class)modelClass fromArrayContent:(NSArray *)arrayContent;

@end
