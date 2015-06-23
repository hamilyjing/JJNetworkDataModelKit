//
//  JJModelDelegate.h
//  JJNetworkDataModelKit
//
//  Created by hamilyjing on 6/17/15.
//  Copyright (c) 2015 JJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JJModelDelegate <NSObject>

@property (nonatomic, copy) NSString *identityID;

+ (id)modelByContent:(NSDictionary *)content error:(NSError **)error;

@end
