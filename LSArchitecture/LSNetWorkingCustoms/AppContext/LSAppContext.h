//
//  LSAppContext.h
//  LSArchitecture
//
//  Created by 王隆帅 on 2017/3/26.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 App相关全局数据的信息中心(比如用户信息、环境信息、位置信息、设备信息、APP信息等)
 */
@interface LSAppContext : NSObject

/**
 运行环境相关
 */
@property (nonatomic, assign, readonly) BOOL isReachable;
@property (nonatomic, assign, readonly) BOOL isOnline;

/**
 用户token相关
 */
@property (nonatomic, copy, readonly) NSString *accessToken;

/**
 用户信息
 */
@property (nonatomic, copy) NSDictionary *userInfo;
@property (nonatomic, copy) NSString *userID;
@property (nonatomic, readonly) BOOL isLoggedIn;

/**
 app信息
 */
@property (nonatomic, readonly) NSString *appVersion;

#pragma mark - life cycle
+ (instancetype)sharedInstance;

@end
