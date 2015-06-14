//
//  JJOperation.h
//  JJNetworkDataModelKit
//
//  Created by JJ on 6/14/15.
//  Copyright (c) 2015 JJ Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JJModel;

@interface JJOperation : NSObject
{
    JJModel *_model;
}

@property (nonatomic, strong) JJModel *model;

- (id)operateWithNewObject:(id)newObject;

// default NSKeyedArchiver and NSKeyedUnarchiver
- (id)getObjectFromSavedFile;
- (BOOL)saveObjectToSavedFile:(id)object;

// file config
- (NSString *)savedFilePath; // combine directory, name and type
- (NSString *)savedFileDirectory;
- (NSString *)savedFileName;
- (NSString *)savedFileType;

@end
