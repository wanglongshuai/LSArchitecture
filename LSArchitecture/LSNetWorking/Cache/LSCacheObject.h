//
//  LSCacheObject.h
//  LSArchitecture
//
//  Created by 王隆帅 on 2017/3/26.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSCacheObject : NSObject

/**
 缓存数据
 */
@property (nonatomic, copy, readonly) NSData *content;

/**
 上次更新的时间
 */
@property (nonatomic, copy, readonly) NSDate *lastUpdateTime;

/**
 是否过期
 */
@property (nonatomic, assign, readonly) BOOL isOutdated;

/**
 缓存是否为空
 */
@property (nonatomic, assign, readonly) BOOL isEmpty;

#pragma mark - life cycle
/**
 初始化缓存对象

 @param content 缓存数据
 @return 缓存对象
 */
- (instancetype)initWithContent:(NSData *)content;

#pragma mark - public
/**
 更新缓存数据

 @param content 新的缓存数据
 */
- (void)updateContent:(NSData *)content;

@end
