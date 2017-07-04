//
//  LSURLResponse.h
//  LSArchitecture
//
//  Created by 王隆帅 on 2017/3/26.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSNetWorkingConfiguration.h"

@interface LSURLResponse : NSObject

/**
 返回数据的状态
 */
@property (nonatomic, assign, readonly) LSURLResponseStatus status;

/**
 获取到的数据
 */
@property (nonatomic, copy, readonly) NSData *responseData;

/**
 获取到的字符串数据
 */
@property (nonatomic, copy, readonly) NSString *contentString;

/**
 数据转化的Foundation对象（字典或数组）
 */
@property (nonatomic, copy, readonly) id content;

/**
 请求命令ID
 */
@property (nonatomic, assign, readonly) NSInteger requestId;

/**
 请求体
 */
@property (nonatomic, copy, readonly) NSURLRequest *request;

/**
 请求参数
 */
@property (nonatomic, copy) NSDictionary *requestParams;

/**
 是否缓存
 */
@property (nonatomic, assign, readonly) BOOL isCache;


/**
 生成一个URLResponse对象（返回正确的时候用此生成）

 @param responseString 字符串数据
 @param requestId 请求ID
 @param request 请求体
 @param responseData 数据
 @param status response状态
 @return URLResponse对象
 */
- (instancetype)initWithResponseString:(NSString *)responseString
                             requestId:(NSNumber *)requestId
                               request:(NSURLRequest *)request
                          responseData:(NSData *)responseData
                                status:(LSURLResponseStatus)status;


/**
 生成一个URLResponse对象（返回错误的时候用此生成）

 @param responseString 字符串数据
 @param requestId 请求ID
 @param request 请求体
 @param responseData 数据
 @param error 错误信息
 @return URLResponse对象
 */
- (instancetype)initWithResponseString:(NSString *)responseString
                             requestId:(NSNumber *)requestId
                               request:(NSURLRequest *)request
                          responseData:(NSData *)responseData
                                 error:(NSError *)error;

// 使用initWithData的response，它的isCache是YES，上面两个函数生成的response的isCache是NO

/**
 生成一个URLResponse对象（一般而言是取缓存的时候生成的）

 @param data 数据
 @return URLResponse对象
 */
- (instancetype)initWithData:(NSData *)data;

@end
