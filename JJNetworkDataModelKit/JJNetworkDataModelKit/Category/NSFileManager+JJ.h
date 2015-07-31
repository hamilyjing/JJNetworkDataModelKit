//
//  NSFileManager+JJ.h
//  JJObjCTool
//
//  Created by hamilyjing on 7/15/15.
//  Copyright (c) 2015 gongjian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (JJ)

#pragma mark - File exist

+ (BOOL)jj_isFileExistAtPath:(NSString*)fileFullPath isDirectory:(BOOL *)isDir;
+ (BOOL)jj_isFileExistAtPath:(NSString*)fileFullPath;

#pragma mark - File path

+ (NSURL *)jj_URLForDirectory:(NSSearchPathDirectory)directory;
+ (NSString *)jj_pathForDirectory:(NSSearchPathDirectory)directory;

+ (NSString *)jj_documentsDirectory;
+ (NSString *)jj_cachesDirectory;
+ (NSString *)jj_tempDirectory;

+ (BOOL)jj_createDirectoryAtPath:(NSString *)path;

#pragma mark - Get file list

+ (NSArray *)jj_getFileNameOrPathList:(BOOL)needFullPath fromDirPath:(NSString *)dirPath needCheckSubDirectory:(BOOL)needCheckSubDirectory fileNameCompareBlock:(BOOL (^)(NSString *fileName))fileNameCompareBlock;

#pragma mark - Get file list by file type

+ (NSArray *)jj_getFileListOfType:(NSString *)type needFullPath:(BOOL)needFullPath fromDirPath:(NSString *)dirPath;
+ (NSArray *)jj_getFileNameListOfType:(NSString *)type fromDirPath:(NSString *)dirPath;
+ (NSArray *)jj_getFilePathListOfType:(NSString *)type fromDirPath:(NSString *)dirPath;

#pragma mark - Get file list by file name

+ (NSArray *)jj_getFileListOfPrefixName:(NSString *)prefixName needFullPath:(BOOL)needFullPath fromDirPath:(NSString *)dirPath;
+ (NSArray *)jj_getFileNameListOfPrefixName:(NSString *)prefixName fromDirPath:(NSString *)dirPath;
+ (NSArray *)jj_getFilePathListOfPrefixName:(NSString *)prefixName fromDirPath:(NSString *)dirPath;

#pragma mark - Remove expired file

+ (void)jj_removeExpiredCache:(NSString *)prefixName fromDirPath:(NSString *)dirPath secondOfExpiredTime:(NSInteger)secondOfExpiredTime;
+ (void)jj_removeExpiredCacheWithType:(NSString *)type fromDirPath:(NSString *)dirPath secondOfExpiredTime:(NSInteger)secondOfExpiredTime;

+ (void)jj_removeExpiredCache:(NSArray *)filePathList secondOfExpiredTime:(NSInteger)secondOfExpiredTime;

@end
