//
//  LSAPIBaseManager.h
//  LSArchitecture
//
//  Created by 王隆帅 on 2017/3/27.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSNetWorkingConfiguration.h"
#import "LSURLResponse.h"

@class LSAPIBaseManager;

/**
 数据请求回调代理者
 */
@protocol LSAPIManagerCallBackDelegate <NSObject>

@required
- (void)managerCallAPIDidSuccess:(LSAPIBaseManager *)manager;
- (void)managerCallAPIDidFailed:(LSAPIBaseManager *)manager;

@end

/**
 数据转换者（直接提供UI可以使用的数据）
 */
@protocol LSAPIManagerDataTranslator <NSObject>

@required
- (id)manager:(LSAPIBaseManager *)manager translateData:(NSDictionary *)data;

@end

/**
 数据检查者
 */
@protocol LSAPIManagerDataChecker <NSObject>

@required
- (BOOL)manager:(LSAPIBaseManager *)manager isCorrectWithCallBackData:(NSDictionary *)data;
- (BOOL)manager:(LSAPIBaseManager *)manager isCorrectWithParamsData:(NSDictionary *)data;

@end

/**
 请求参数提供者
 */
@protocol LSAPIManagerParamSource <NSObject>

@required
- (NSDictionary *)paramsDataForAPIManager:(LSAPIBaseManager *)manager;

@end

/**
 事件拦截者
 */
@protocol LSAPIManagerInterceptor <NSObject>

@optional
- (BOOL)manager:(LSAPIBaseManager *)manager beforePerformSuccessWithResponse:(LSURLResponse *)response;
- (void)manager:(LSAPIBaseManager *)manager afterPerformSuccessWithResponse:(LSURLResponse *)response;

- (BOOL)manager:(LSAPIBaseManager *)manager beforePerformFailWithResponse:(LSURLResponse *)response;
- (void)manager:(LSAPIBaseManager *)manager afterPerformFailWithResponse:(LSURLResponse *)response;

- (BOOL)manager:(LSAPIBaseManager *)manager shouldCallAPIWithParams:(NSDictionary *)params;
- (void)manager:(LSAPIBaseManager *)manager afterCallingAPIWithParams:(NSDictionary *)params;

@end

/**
 子类继承者
 */
@protocol LSAPIManagerProtocol <NSObject>

@required
- (NSString *)path;
- (NSString *)serviceIdentifier;
- (LSAPIManagerRequestType)requestType;
- (BOOL)shouldCache;

@optional
- (NSDictionary *)requestParams:(NSDictionary *)params;

@end

@interface LSAPIBaseManager : NSObject

@property (nonatomic, weak) id<LSAPIManagerCallBackDelegate> delegate;
@property (nonatomic, weak) id<LSAPIManagerParamSource> paramSource;
@property (nonatomic, weak) id<LSAPIManagerDataChecker> checker;
@property (nonatomic, weak) NSObject<LSAPIManagerProtocol> *child;
@property (nonatomic, weak) id<LSAPIManagerInterceptor> interceptor;

@property (nonatomic, copy, readonly) NSString *errorMessage;
@property (nonatomic, readonly) LSAPIManagerStatusType statusType;
@property (nonatomic, strong) LSURLResponse *response;

@property (nonatomic, assign, readonly) BOOL isReachable;
@property (nonatomic, assign, readonly) BOOL isLoading;

- (NSInteger)loadData;

- (id)fetchDataWithTranslator:(id<LSAPIManagerDataTranslator>)translator;

- (void)cancelAllRequests;
- (void)cancelRequestWithRequestId:(NSInteger)requestID;

/**
 拦截器相关方法，继承之后需要调用一下super,否则不会转发给Interceptor
 */
- (BOOL)beforePerformSuccessWithResponse:(LSURLResponse *)response;
- (void)afterPerformSuccessWithResponse:(LSURLResponse *)response;

- (BOOL)beforePerformFailWithResponse:(LSURLResponse *)response;
- (void)afterPerformFailWithResponse:(LSURLResponse *)response;

- (BOOL)shouldCallAPIWithParams:(NSDictionary *)params;
- (void)afterCallingAPIWithParams:(NSDictionary *)params;

/**
 继承之后，不需要调用super，作用：manager子类额外添加请求参数eg：pageNum
 */
- (NSDictionary *)requestParams:(NSDictionary *)params;

- (void)cleanData;
- (BOOL)shouldCache;

- (void)successedOnCallingAPI:(LSURLResponse *)response;
- (void)failedOnCallingAPI:(LSURLResponse *)response withStatusType:(LSAPIManagerStatusType)statusType;

@end
