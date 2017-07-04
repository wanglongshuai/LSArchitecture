//
//  LSNetService.h
//  LSArchitecture
//
//  Created by 王隆帅 on 2017/3/26.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 网络服务，区分不同的服务请求地址，区分测试环境or正式环境
 类似版本控制、加密的公钥、私钥都可以在此处理
 */
@protocol LSNetServiceProtocol <NSObject>

@required

@property (nonatomic, readonly) BOOL isOnline;

@property (nonatomic, readonly) NSString *offlineApiBaseUrl;
@property (nonatomic, readonly) NSString *onlineApiBaseUrl;

@end

@interface LSNetService : NSObject

@property (nonatomic, strong, readonly) NSString *apiBaseUrl;

@property (nonatomic, weak) id <LSNetServiceProtocol> child;

@end
