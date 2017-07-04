//
//  LSCacheManager.m
//  LSArchitecture
//
//  Created by 王隆帅 on 2017/3/26.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "LSCacheManager.h"
#import "LSNetWorkingConfiguration.h"
#import "NSDictionary+LSNetWork.h"
#import "LSCacheObject.h"

@interface LSCacheManager ()

@property (nonatomic, strong) NSCache *cache;

@end

@implementation LSCacheManager

#pragma mark - lifeCycle
+ (instancetype)sharedInstance {

    static dispatch_once_t onceToken;
    static LSCacheManager *sharedInstance;
    
    dispatch_once(&onceToken, ^{
        
        sharedInstance = [[LSCacheManager alloc] init];
    });
    
    return sharedInstance;
}

#pragma mark - public

- (void)saveCacheDataWithData:(NSData *)cacheData
                          Key:(NSString *)key {
    
    LSCacheObject *cacheObject = [self.cache objectForKey:key];
    
    if (!cacheObject) {
        
        cacheObject = [[LSCacheObject alloc] initWithContent:cacheData];
    } else {
    
        [cacheObject updateContent:cacheData];
    }
    
    [self.cache setObject:cacheObject forKey:key];
}

- (void)saveCacheDataWithData:(NSData *)cacheData
            serviceIdentifier:(NSString *)serviceIdentifier
                         path:(NSString *)path
                requestParams:(NSDictionary *)requestParams {

    [self saveCacheDataWithData:cacheData Key:[self keyWithServiceIdentifier:serviceIdentifier path:path requestParams:requestParams]];
}

- (NSData *)fetchCachedDataWithKey:(NSString *)key {

    LSCacheObject *cachedObject = [self.cache objectForKey:key];
    
    if (cachedObject.isOutdated || cachedObject.isEmpty) {
        
        return nil;
    } else {
    
        return cachedObject.content;
    }
}

- (NSData *)fetchCachedDataWithServiceIdentifier:(NSString *)serviceIdentifier
                                            path:(NSString *)path
                                   requestParams:(NSDictionary *)requestParams {
    
    return [self fetchCachedDataWithKey:[self keyWithServiceIdentifier:serviceIdentifier path:path requestParams:requestParams]];
}

- (void)deleteCacheWithKey:(NSString *)key {

    [self.cache removeObjectForKey:key];
}

- (void)deleteCacheWithServiceIdentifier:(NSString *)serviceIdentifier
                                    path:(NSString *)path
                           requestParams:(NSDictionary *)requestParams {

    [self deleteCacheWithKey:[self keyWithServiceIdentifier:serviceIdentifier path:path requestParams:requestParams]];
}

- (NSString *)keyWithServiceIdentifier:(NSString *)serviceIdentifier
                                  path:(NSString *)path
                         requestParams:(NSDictionary *)requestParams {

    return [NSString stringWithFormat:@"%@%@%@", serviceIdentifier, path, [requestParams LS_paramsStringWithEncode:NO]];
}

- (void)clean {

    [self.cache removeAllObjects];
}

#pragma mark - lazyLoad
- (NSCache *)cache {

    if (!_cache) {
        
        _cache = [[NSCache alloc] init];
        _cache.countLimit = kLSCacheCountLimit;
    }
    
    return _cache;
}

@end
