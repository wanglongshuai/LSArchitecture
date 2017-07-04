//
//  LSAPIBaseManager.m
//  LSArchitecture
//
//  Created by 王隆帅 on 2017/3/27.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "LSAPIBaseManager.h"
#import "LSCacheManager.h"
#import "LSRequestManager.h"
#import "LSAppContext.h"

@interface LSAPIBaseManager () <LSAPIManagerInterceptor>

@property (nonatomic, strong, readwrite) id fetchedRawData;
@property (nonatomic, assign, readwrite) BOOL isLoading;

@property (nonatomic, copy, readwrite) NSString *errorMessage;
@property (nonatomic, readwrite) LSAPIManagerStatusType statusType;
@property (nonatomic, strong) NSMutableArray *requestIdList;
@property (nonatomic, strong) LSCacheManager *cacheManager;

@end

@implementation LSAPIBaseManager

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        if ([self conformsToProtocol:@protocol(LSAPIManagerProtocol)]) {
            
            self.child = (NSObject <LSAPIManagerProtocol> *)self;
        } else {
            
            NSException *exception = [[NSException alloc] initWithName:@"LSAPIBaseManager继承错误" reason:[NSString stringWithFormat:@"子类%@要遵守协议：LSAPIManagerProtocol",[NSString stringWithUTF8String:object_getClassName([self class])]] userInfo:nil];
            @throw exception;
        }
        
        [self initData];
    }
    
    return self;
}

- (void)initData {

    _delegate = nil;
    _checker = nil;
    _paramSource = nil;
    
    _fetchedRawData = nil;
    _errorMessage = nil;
    _statusType = LSAPIManagerStatusDefault;
}

- (void)dealloc {
    
    [self cancelAllRequests];
    self.requestIdList = nil;
}

#pragma mark - public
- (void)cancelAllRequests {
    
    [[LSRequestManager sharedInstance] cancelRequestWithRequestIDList:self.requestIdList];
    [self.requestIdList removeAllObjects];
}

- (void)cancelRequestWithRequestId:(NSInteger)requestID {
    
    [self removeRequestIdWithRequestID:requestID];
    [[LSRequestManager sharedInstance] cancelRequestWithRequestID:@(requestID)];
}

- (id)fetchDataWithTranslator:(id<LSAPIManagerDataTranslator>)translator {
    
    id resultData = nil;
    
    if ([translator respondsToSelector:@selector(manager:translateData:)]) {
        
        resultData = [translator manager:self translateData:self.fetchedRawData];
    } else {
        
        resultData = [self.fetchedRawData mutableCopy];
    }
    
    return resultData;
}

#pragma mark - real request
- (NSInteger)loadData {
    
    NSDictionary *params = [self.paramSource paramsDataForAPIManager:self];
    NSInteger requestId = [self loadDataWithParams:params];
    return requestId;
}

- (NSInteger)loadDataWithParams:(NSDictionary *)params
{
    NSInteger requestId = 0;
    NSDictionary *apiParams = [self requestParams:params];
    
    if ([self shouldCallAPIWithParams:apiParams]) {
        
        if ([self.checker manager:self isCorrectWithParamsData:apiParams]) {
            
            if ([self shouldCache] && [self hasCacheWithParams:apiParams]) {
                
                return 0;
            }
            
            if ([self isReachable]) {
                
                self.isLoading = YES;
                
                switch (self.child.requestType) {
                        
                    case LSAPIManagerRequestTypeGET: {
                        
                        requestId = [self startRequestWithMethod:@"GET" apiParams:apiParams];
                    }
                        break;
                    case LSAPIManagerRequestTypePOST: {
                        
                        requestId = [self startRequestWithMethod:@"POST" apiParams:apiParams];
                    }
                        break;
                    case LSAPIManagerRequestTypePUT: {
                        
                        requestId = [self startRequestWithMethod:@"PUT" apiParams:apiParams];
                    }
                        break;
                    case LSAPIManagerRequestTypeDELETE: {
                        
                        requestId = [self startRequestWithMethod:@"DELETE" apiParams:apiParams];
                    }
                        break;
                    default:
                        break;
                }
                
                NSMutableDictionary *params = [apiParams mutableCopy];
                params[kLSAPIBaseManagerRequestID] = @(requestId);
                
                [self afterCallingAPIWithParams:params];
                
                return requestId;
            } else {
                
                [self failedOnCallingAPI:nil withStatusType:LSAPIManagerStatusNoNetWork];
                return requestId;
            }
            
        } else {
            
            [self failedOnCallingAPI:nil withStatusType:LSAPIManagerStatusParamsError];
            return requestId;
        }
    }
    return requestId;
}

- (NSInteger)startRequestWithMethod:(NSString *)method apiParams:(NSDictionary *)apiParams {
    
    NSInteger requestId = 0;
    __weak typeof(self) weakSelf = self;
    requestId = [[LSRequestManager sharedInstance] callWithMethod:method params:apiParams serviceIdentifier:self.child.serviceIdentifier path:self.child.path success:^(LSURLResponse *response) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf successedOnCallingAPI:response];
    } fail:^(LSURLResponse *response) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf failedOnCallingAPI:response withStatusType:LSAPIManagerStatusRequestError];
    }];
    
    return requestId;
}

#pragma mark - api callbacks
- (void)successedOnCallingAPI:(LSURLResponse *)response {
    
    self.isLoading = NO;
    self.response = response;
    
    
    if (response.content) {
        
        self.fetchedRawData = [response.content copy];
    } else {
        
        self.fetchedRawData = [response.responseData copy];
    }
    
    [self removeRequestIdWithRequestID:response.requestId];
    
    if ([self.checker manager:self isCorrectWithCallBackData:response.content]) {
        
        if ([self shouldCache] && !response.isCache) {
            
            [self.cacheManager saveCacheDataWithData:response.responseData serviceIdentifier:self.child.serviceIdentifier path:self.child.path requestParams:response.requestParams];
        }
        
        if ([self beforePerformSuccessWithResponse:response]) {
            
            [self.delegate managerCallAPIDidSuccess:self];
        }
        
        [self afterPerformSuccessWithResponse:response];
    } else {
        
        [self failedOnCallingAPI:response withStatusType:LSAPIManagerStatusCallBackError];
    }
}

- (void)failedOnCallingAPI:(LSURLResponse *)response withStatusType:(LSAPIManagerStatusType)statusType {
    
    self.isLoading = NO;
    self.response = response;
    
    /**
     跟局response的错误参数做统一处理，比如token过期，比如无网络等，可以通过通知到统一接受的地方做弹框处理。
     */
    
    self.statusType = statusType;
    [self removeRequestIdWithRequestID:response.requestId];
    
    if ([self beforePerformFailWithResponse:response]) {
        
        [self.delegate managerCallAPIDidFailed:self];
    }
    
    [self afterPerformFailWithResponse:response];
}


#pragma mark - method for interceptor

- (BOOL)beforePerformSuccessWithResponse:(LSURLResponse *)response {
    
    BOOL result = YES;
    
    self.statusType = LSAPIManagerStatusSuccess;
    
    if (self != self.interceptor && [self.interceptor respondsToSelector:@selector(manager: beforePerformSuccessWithResponse:)]) {
        
        result = [self.interceptor manager:self beforePerformSuccessWithResponse:response];
    }
    
    return result;
}

- (void)afterPerformSuccessWithResponse:(LSURLResponse *)response {
    
    if (self != self.interceptor && [self.interceptor respondsToSelector:@selector(manager:afterPerformSuccessWithResponse:)]) {
        
        [self.interceptor manager:self afterPerformSuccessWithResponse:response];
    }
}

- (BOOL)beforePerformFailWithResponse:(LSURLResponse *)response {
    
    BOOL result = YES;
    
    if (self != self.interceptor && [self.interceptor respondsToSelector:@selector(manager:beforePerformFailWithResponse:)]) {
        
        result = [self.interceptor manager:self beforePerformFailWithResponse:response];
    }
    return result;
}

- (void)afterPerformFailWithResponse:(LSURLResponse *)response {
    
    if (self != self.interceptor && [self.interceptor respondsToSelector:@selector(manager:afterPerformFailWithResponse:)]) {
        
        [self.interceptor manager:self afterPerformFailWithResponse:response];
    }
}

- (BOOL)shouldCallAPIWithParams:(NSDictionary *)params {
    
    if (self != self.interceptor && [self.interceptor respondsToSelector:@selector(manager:shouldCallAPIWithParams:)]) {
        
        return [self.interceptor manager:self shouldCallAPIWithParams:params];
    } else {
        
        return YES;
    }
}

- (void)afterCallingAPIWithParams:(NSDictionary *)params {
    
    if (self != self.interceptor && [self.interceptor respondsToSelector:@selector(manager:afterCallingAPIWithParams:)]) {
        
        [self.interceptor manager:self afterCallingAPIWithParams:params];
    }
}

#pragma mark - method for child
- (void)cleanData {
    
    [self.cacheManager clean];
    self.fetchedRawData = nil;
    self.errorMessage = nil;
    self.statusType = LSAPIManagerStatusDefault;
}

- (NSDictionary *)requestParams:(NSDictionary *)params {
    
    IMP childIMP = [self.child methodForSelector:@selector(requestParams:)];
    IMP selfIMP = [self methodForSelector:@selector(requestParams:)];
    
    if (childIMP == selfIMP) {
        
        return params;
    } else {
        /**
         如果child是继承得来的，那么这里就不会跑到，会直接跑子类中的IMP。
         如果child是另一个对象，就会跑到这里
         */
        NSDictionary *result = nil;
        result = [self.child requestParams:params];
        
        if (result) {
            
            return result;
        } else {
            
            return params;
        }
    }
}

- (BOOL)shouldCache {
    
    return kLSShouldCache;
}

# pragma mark - private methods
- (void)removeRequestIdWithRequestID:(NSInteger)requestId {
    
    NSNumber *requestIDToRemove = nil;
    
    for (NSNumber *storedRequestId in self.requestIdList) {
        
        if ([storedRequestId integerValue] == requestId) {
            
            requestIDToRemove = storedRequestId;
        }
    }
    
    if (requestIDToRemove) {
        
        [self.requestIdList removeObject:requestIDToRemove];
    }
}

- (BOOL)hasCacheWithParams:(NSDictionary *)params {
    
    NSString *serviceIdentifier = self.child.serviceIdentifier;
    NSString *path = self.child.path;
    NSData *result = [self.cacheManager fetchCachedDataWithServiceIdentifier:serviceIdentifier path:path requestParams:params];
    
    if (result == nil) {
        
        return NO;
    }
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        
        __strong typeof (weakSelf) strongSelf = weakSelf;
        LSURLResponse *response = [[LSURLResponse alloc] initWithData:result];
        response.requestParams = params;
        [strongSelf successedOnCallingAPI:response];
    });
    
    return YES;
}

#pragma mark - getters and setters
- (LSCacheManager *)cacheManager {
    
    if (_cacheManager == nil) {
        
        _cacheManager = [LSCacheManager sharedInstance];
    }
    return _cacheManager;
}

- (NSMutableArray *)requestIdList {
    
    if (_requestIdList == nil) {
        
        _requestIdList = [[NSMutableArray alloc] init];
    }
    return _requestIdList;
}

- (BOOL)isReachable {
    
    BOOL isReachability = [LSAppContext sharedInstance].isReachable;
    
    if (!isReachability) {
        
        self.statusType = LSAPIManagerStatusNoNetWork;
    }
    
    return isReachability;
}

- (BOOL)isLoading {
    
    if (self.requestIdList.count == 0) {
        
        _isLoading = NO;
    }
    
    return _isLoading;
}

- (BOOL)shouldLoadFromNative {
    
    return NO;
}


@end
