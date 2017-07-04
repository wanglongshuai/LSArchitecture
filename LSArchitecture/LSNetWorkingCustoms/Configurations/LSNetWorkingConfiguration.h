//
//  LSNetWorkingConfiguration.h
//  LSArchitecture
//
//  Created by 王隆帅 on 2017/3/26.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#ifndef LSNetWorkingConfiguration_h
#define LSNetWorkingConfiguration_h

#pragma request
typedef enum : NSUInteger {
    /**
     获取数据成功
     */
    LSURLResponseStatusSuccess,
    /**
     获取数据超时
     */
    LSURLResponseStatusTimeout,
    /**
     没有网络（除了超时默认都是没有网络）
     */
    LSURLResponseStatusNoNetwork,
} LSURLResponseStatus;

typedef enum : NSUInteger {
    /**
     默认状态，未产生过请求
     */
    LSAPIManagerStatusDefault,
    /**
     API请求成功并且返回数据正常
     */
    LSAPIManagerStatusSuccess,
    /**
     API请求成功并且返回数据不正确
     */
    LSAPIManagerStatusCallBackError,
    /**
     参数错误
     */
    LSAPIManagerStatusParamsError,
    /**
     请求超时
     */
    LSAPIManagerStatusTimeOut,
    /**
     网络不通
     */
    LSAPIManagerStatusNoNetWork,
    /** 
     请求失败
     */
    LSAPIManagerStatusRequestError,
} LSAPIManagerStatusType;

typedef enum : NSUInteger {
    /**
     GET类型请求
     */
    LSAPIManagerRequestTypeGET,
    /**
     POST类型请求
     */
    LSAPIManagerRequestTypePOST,
    /**
     PUT类型请求
     */
    LSAPIManagerRequestTypePUT,
    /**
     DELETE类型请求
     */
    LSAPIManagerRequestTypeDELETE
} LSAPIManagerRequestType;

/**
 默认的是需要缓存
 */
static BOOL kLSShouldCache = YES;

/**
 是否支持https（自签证证书）,单纯使用付费CA证书是不需要做任何处理的
 */
static BOOL kLSIsSupportSelfCertificate = NO;

static NSString * const kLSSelfCertificateName = @"XXXXXX";


/**
 请求超时时间
 */
static NSTimeInterval kLSNetworkingTimeoutSeconds = 20.0f;

/**
 在调用成功之后的params字典里面，用这个key可以取出requestID
 */
static NSString * const kLSAPIBaseManagerRequestID = @"kLSAPIBaseManagerRequestID";

#pragma mark - APPContext

/**
 默认的是否是线上环境（第一选则是plist，假如没有才会用这个判断）
 */
static BOOL kLSNetServiceIsOnline = NO;

#pragma mark - cache

/** 
 cache过期时间 
 */
static NSTimeInterval kLSCacheOutdateTimeSeconds = 300;

/** 
 cache最大数量 
 */
static NSUInteger kLSCacheCountLimit = 1000;

#pragma mark - service
extern NSString * const kLSNetServiceGeneral;


#endif
