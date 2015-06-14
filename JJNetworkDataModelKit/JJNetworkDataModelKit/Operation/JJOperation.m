//
//  JJOperation.m
//  JJNetworkDataModelKit
//
//  Created by JJ on 6/14/15.
//  Copyright (c) 2015 JJ Inc. All rights reserved.
//

#import "JJOperation.h"

#import "JJModel.h"

@implementation JJOperation

- (JJModel *)model
{
    if (_model)
    {
        return _model;
    }
    
    _model = [self getObjectFromSavedFile];
    return _model;
}

- (void)setModel:(JJModel *)model_
{
    if (model_ == _model)
    {
        return;
    }
    
    _model = model_;
    
    [self saveObjectToSavedFile:_model];
}

- (id)operateWithNewObject:(id)newObject
{
    return newObject;
}

- (id)getObjectFromSavedFile
{
    id object;
    
    do {
        NSString *filePath = [self savedFilePath];
        object = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        if (object)
        {
            break;
        }
        
        filePath = [[NSBundle mainBundle] pathForResource:[self savedFileName] ofType:[self savedFileType]];
        object = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        
    } while (NO);
    
    return object;
}

- (BOOL)saveObjectToSavedFile:(id)object_
{
    NSString *filePath = [self savedFilePath];
    BOOL success = [NSKeyedArchiver archiveRootObject:object_ toFile:filePath];
    return success;
}

#pragma mark - file config

- (NSString *)savedFilePath
{
    static NSString *filePath = nil;
    if (filePath)
    {
        return filePath;
    }
    
    filePath = [NSString stringWithFormat:@"%@/%@.%@", [self savedFileDirectory], [self savedFileName], [self savedFileType]];
    return filePath;
}

- (NSString *)savedFileDirectory
{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

- (NSString *)savedFileName
{
    return @"savedFileName";
}

- (NSString *)savedFileType
{
    return @"archiver";
}

@end
