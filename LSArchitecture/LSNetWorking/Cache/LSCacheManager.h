//
//  LSCacheManager.h
//  LSArchitecture
//
//  Created by 王隆帅 on 2017/3/26.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSCacheManager : NSObject

#pragma mark - liftCycle
/**
 获取单例
 
 @return 单例对象
 */
+ (instancetype)sharedInstance;


#pragma mark - public
/**
 保存缓存数据

 @param cacheData 缓存数据
 @param key 缓存数据的key
 */
- (void)saveCacheDataWithData:(NSData *)cacheData
                          Key:(NSString *)key;


/**
 保存缓存数据

 @param cacheData 缓存数据
 @param serviceIdentifier 服务标识
 @param path 路径
 @param requestParams 请求参数
 */
- (void)saveCacheDataWithData:(NSData *)cacheData
            serviceIdentifier:(NSString *)serviceIdentifier
                         path:(NSString *)path
                requestParams:(NSDictionary *)requestParams;


/**
 获取缓存数据

 @param key 缓存数据对应的key
 @return 缓存数据
 */
- (NSData *)fetchCachedDataWithKey:(NSString *)key;


/**
 获取缓存数据

 @param serviceIdentifier 服务标识
 @param path 路径
 @param requestParams 请求参数
 @return 缓存数据
 */
- (NSData *)fetchCachedDataWithServiceIdentifier:(NSString *)serviceIdentifier
                                            path:(NSString *)path
                                   requestParams:(NSDictionary *)requestParams;

/**
 删除缓存

 @param key 缓存的key
 */
- (void)deleteCacheWithKey:(NSString *)key;


/**
 删除缓存

 @param serviceIdentifier 服务标识
 @param path 路径
 @param requestParams 请求参数
 */
- (void)deleteCacheWithServiceIdentifier:(NSString *)serviceIdentifier
                                    path:(NSString *)path
                           requestParams:(NSDictionary *)requestParams;


/**
 获取key

 @param serviceIdentifier 服务标识
 @param path 路径
 @param requestParams 请求参数
 @return 获得拼接后的key
 */
- (NSString *)keyWithServiceIdentifier:(NSString *)serviceIdentifier
                                  path:(NSString *)path
                         requestParams:(NSDictionary *)requestParams;


/**
 清除所有缓存
 */
- (void)clean;


@end
