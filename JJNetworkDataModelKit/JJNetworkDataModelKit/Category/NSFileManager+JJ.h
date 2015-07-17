//
//  NSFileManager+JJ.h
//  JJObjCTool
//
//  Created by gongjian03 on 7/15/15.
//  Copyright (c) 2015 gongjian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (JJ)

+ (NSArray *)jj_getFileNameOrPathList:(BOOL)needFullPath fromDirPath:(NSString *)dirPath needCheckSubDirectory:(BOOL)needCheckSubDirectory fileNameCompareBlock:(BOOL (^)(NSString *fileName))fileNameCompareBlock;

+ (NSArray *)jj_getFileListOfType:(NSString *)type needFullPath:(BOOL)needFullPath fromDirPath:(NSString *)dirPath;
+ (NSArray *)jj_getFileNameListOfType:(NSString *)type fromDirPath:(NSString *)dirPath;
+ (NSArray *)jj_getFilePathListOfType:(NSString *)type fromDirPath:(NSString *)dirPath;

+ (NSArray *)jj_getFileListOfPrefixName:(NSString *)prefixName needFullPath:(BOOL)needFullPath fromDirPath:(NSString *)dirPath;
+ (NSArray *)jj_getFileNameListOfPrefixName:(NSString *)prefixName fromDirPath:(NSString *)dirPath;
+ (NSArray *)jj_getFilePathListOfPrefixName:(NSString *)prefixName fromDirPath:(NSString *)dirPath;

+ (void)jj_removeExpiredCache:(NSString *)prefixName fromDirPath:(NSString *)dirPath secondOfExpiredTime:(NSInteger)secondOfExpiredTime;
+ (void)jj_removeExpiredCacheWithType:(NSString *)type fromDirPath:(NSString *)dirPath secondOfExpiredTime:(NSInteger)secondOfExpiredTime;

+ (void)jj_removeExpiredCache:(NSArray *)filePathList secondOfExpiredTime:(NSInteger)secondOfExpiredTime;

+ (BOOL)jj_isFileExistAtPath:(NSString*)fileFullPath isDirectory:(BOOL *)isDir;
+ (BOOL)jj_isFileExistAtPath:(NSString*)fileFullPath;

@end
