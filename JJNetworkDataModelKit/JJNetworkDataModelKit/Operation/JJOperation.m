//
//  JJOperation.m
//  JJNetworkDataModelKit
//
//  Created by JJ on 6/14/15.
//  Copyright (c) 2015 JJ Inc. All rights reserved.
//

#import "JJOperation.h"

#import "JJModelDelegate.h"

static NSString *ModelDictionaryEmptyKey = @"JJModel";

@implementation JJOperation

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.modelDic = [NSMutableDictionary dictionary];
    }
    return self;
}

- (id)getModelByIdentityID:(NSString *)identityID_
{
    NSString *key = [self getTrueIdentityID:identityID_];
    id model = _modelDic[key];
    if (model)
    {
        return model;
    }
    
    model = [self getObjectFromLocalCache:key];
    return model;
}

- (void)setModel:(id)model_ identityID:(NSString *)identityID_
{
    if (!model_)
    {
        return;
    }
    
    NSString *key = [self getTrueIdentityID:identityID_];
    _modelDic[key] = model_;
}

- (id)operateWithNewObject:(id)newObject_ updateCount:(NSInteger *)updateCount_
{
    id oldObject;
    if ([newObject_ conformsToProtocol:NSProtocolFromString(@"JJModelDelegate")])
    {
        oldObject = [self getModelByIdentityID:((id<JJModelDelegate>)newObject_).identityID];
    }
    
    return [self operateWithNewObject:newObject_ oldObject:oldObject updateCount:updateCount_];
}

- (id)operateWithNewObject:(id)newObject_ oldObject:(id)oldObject_ updateCount:(NSInteger *)updateCount_
{
    *updateCount_ = 1;
    return newObject_;
}

- (void)removeAllCache
{
    [self removeAllLocalCache];
    [self removeAllMemoryCache];
}

- (void)removeAllMemoryCache
{
    [_modelDic removeAllObjects];
}

- (void)removeAllLocalCache
{
    [_modelDic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop)
    {
        [self removeLocalCache:key];
    }];
}

- (void)removeCache:(NSString *)identityID_
{
    [self removeCache:identityID_];
    [self removeMemoryCache:identityID_];
}

- (void)removeMemoryCache:(NSString *)identityID_
{
    NSString *key = [self getTrueIdentityID:identityID_];
    [_modelDic removeObjectForKey:key];
}

- (void)removeLocalCache:(NSString *)identityID_
{
    NSError *error;
    [[NSFileManager defaultManager] removeItemAtPath:[self savedFilePathIncludeIdentityID:identityID_] error:&error];
}

- (id)getObjectFromLocalCache:(NSString *)identityID_
{
    id object;
    
    do {
        NSString *filePath = [self savedFilePathIncludeIdentityID:identityID_];
        object = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        if (object)
        {
            break;
        }
        
        NSString *fileName = [NSString stringWithFormat:@"%@_%@", [self savedFileName], identityID_];
        filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:[self savedFileType]];
        object = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        
    } while (NO);
    
    return object;
}

- (BOOL)saveObjectToLocalCache:(id)object_ identityID:(NSString *)identityID_
{
    NSString *filePath = [self savedFilePathIncludeIdentityID:identityID_];
    BOOL success = [NSKeyedArchiver archiveRootObject:object_ toFile:filePath];
    return success;
}

#pragma mark - file config

- (NSString *)savedFilePathIncludeIdentityID:(NSString *)identityID_
{
    NSString *identityID = [self getTrueIdentityID:identityID_];
    
    NSString *filePath = [NSString stringWithFormat:@"%@/%@_%@.%@", [self savedFileDirectory], [self savedFileName], identityID, [self savedFileType]];
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

#pragma mark - Private

- (NSString *)getTrueIdentityID:(NSString *)identityID_
{
    return identityID_ ? identityID_ : ModelDictionaryEmptyKey;
}

@end
