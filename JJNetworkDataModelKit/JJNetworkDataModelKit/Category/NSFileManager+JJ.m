//
//  NSFileManager+JJ.m
//  JJObjCTool
//
//  Created by gongjian03 on 7/15/15.
//  Copyright (c) 2015 gongjian. All rights reserved.
//

#import "NSFileManager+JJ.h"

@implementation NSFileManager (JJ)

+ (NSArray *)jj_getFileNameOrPathList:(BOOL)needFullPath_
                          fromDirPath:(NSString *)dirPath_
                needCheckSubDirectory:(BOOL)needCheckSubDirectory_
                 fileNameCompareBlock:(BOOL (^)(NSString *fileName))fileNameCompareBlock_
{
    NSMutableArray *fileList = [NSMutableArray arrayWithCapacity:10];
    
    NSError *error;
    NSArray *tmplist = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:dirPath_ error:&error];
    NSAssert(!error, @"%@", error);
    
    for (NSString *fileName in tmplist)
    {
        NSString *fullpath = [dirPath_ stringByAppendingPathComponent:fileName];
        BOOL isDir;
        BOOL fileExist = [self jj_isFileExistAtPath:fullpath isDirectory:&isDir];
        
        if (isDir || !fileExist)
        {
            NSArray *subFileList = [self jj_getFileNameOrPathList:needFullPath_ fromDirPath:fullpath needCheckSubDirectory:needCheckSubDirectory_ fileNameCompareBlock:fileNameCompareBlock_];
            if ([subFileList count] > 0)
            {
                [fileList addObjectsFromArray:subFileList];
            }
            continue;
        }
        
        if (fileNameCompareBlock_)
        {
            if (!fileNameCompareBlock_(fileName))
            {
                continue;
            }
        }
        
        if (needFullPath_)
        {
            [fileList addObject:fullpath];
        }
        else
        {
            [fileList addObject:fileName];
        }
    }
    
    return fileList;
}

+ (NSArray *)jj_getFileListOfType:(NSString *)type_ needFullPath:(BOOL)needFullPath_ fromDirPath:(NSString *)dirPath_
{
    return [self jj_getFileNameOrPathList:needFullPath_ fromDirPath:dirPath_ needCheckSubDirectory:NO fileNameCompareBlock:^BOOL(NSString *fileName)
            {
                BOOL success = [[fileName pathExtension] isEqualToString:type_];
                return success;
            }];
}

+ (NSArray *)jj_getFileNameListOfType:(NSString *)type_ fromDirPath:(NSString *)dirPath_
{
    return [self jj_getFileListOfType:type_ needFullPath:NO fromDirPath:dirPath_];
}

+ (NSArray *)jj_getFilePathListOfType:(NSString *)type_ fromDirPath:(NSString *)dirPath_
{
    return [self jj_getFileListOfType:type_ needFullPath:YES fromDirPath:dirPath_];
}

+ (NSArray *)jj_getFileListOfPrefixName:(NSString *)prefixName_ needFullPath:(BOOL)needFullPath_ fromDirPath:(NSString *)dirPath_
{
    return [self jj_getFileNameOrPathList:needFullPath_ fromDirPath:dirPath_ needCheckSubDirectory:NO fileNameCompareBlock:^BOOL(NSString *fileName)
            {
                BOOL success = [fileName hasPrefix:prefixName_];
                return success;
            }];
}

+ (NSArray *)jj_getFileNameListOfPrefixName:(NSString *)prefixName_ fromDirPath:(NSString *)dirPath_
{
    return [self jj_getFileListOfPrefixName:prefixName_ needFullPath:NO fromDirPath:dirPath_];
}

+ (NSArray *)jj_getFilePathListOfPrefixName:(NSString *)prefixName_ fromDirPath:(NSString *)dirPath_
{
    return [self jj_getFileListOfPrefixName:prefixName_ needFullPath:YES fromDirPath:dirPath_];
}

+ (void)jj_removeExpiredCache:(NSString *)prefixName_ fromDirPath:(NSString *)dirPath_ secondOfExpiredTime:(NSInteger)secondOfExpiredTime_
{
    NSArray *filePathList = [self jj_getFilePathListOfPrefixName:prefixName_ fromDirPath:dirPath_];
    
    [self jj_removeExpiredCache:filePathList secondOfExpiredTime:secondOfExpiredTime_];
}

+ (void)jj_removeExpiredCacheWithType:(NSString *)type_ fromDirPath:(NSString *)dirPath_ secondOfExpiredTime:(NSInteger)secondOfExpiredTime_
{
    NSArray *filePathList = [self jj_getFilePathListOfType:type_ fromDirPath:dirPath_];
    
    [self jj_removeExpiredCache:filePathList secondOfExpiredTime:secondOfExpiredTime_];
}

+ (void)jj_removeExpiredCache:(NSArray *)filePathList_ secondOfExpiredTime:(NSInteger)secondOfExpiredTime_
{
    [filePathList_ enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
         NSError *error;
         NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:obj error:&error];
         NSAssert(!error, @"%@", error);
         if (error)
         {
             return;
         }
         
         NSDate *fileModifyDate = [fileAttributes objectForKey:NSFileModificationDate];
         NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:fileModifyDate];
         if (fabs(timeInterval) > secondOfExpiredTime_)
         {
             [[NSFileManager defaultManager] removeItemAtPath:obj error:&error];
             NSAssert(!error, @"%@", error);
         }
     }];
}

+ (BOOL)jj_isFileExistAtPath:(NSString*)fileFullPath isDirectory:(BOOL *)isDir
{
    BOOL isExist = NO;
    isExist = [[NSFileManager defaultManager] fileExistsAtPath:fileFullPath isDirectory:isDir];
    return isExist;
}

+ (BOOL)jj_isFileExistAtPath:(NSString*)fileFullPath
{
    BOOL isExist = NO;
    isExist = [[NSFileManager defaultManager] fileExistsAtPath:fileFullPath];
    return isExist;
}

@end
