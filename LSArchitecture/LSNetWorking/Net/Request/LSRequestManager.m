//
//  LSRequestManager.m
//  LSArchitecture
//
//  Created by 王隆帅 on 2017/3/26.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "LSRequestManager.h"
#import <AFNetworking/AFNetworking.h>
#import "LSRequestGenerator.h"
#import "LSNetLogger.h"

@interface LSRequestManager ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@property (nonatomic, strong) NSMutableDictionary *dispatchTable;

@end

@implementation LSRequestManager

+ (instancetype)sharedInstance {
    
    static dispatch_once_t onceToken;
    static LSRequestManager *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[LSRequestManager alloc] init];
    });
    
    return sharedInstance;
}

#pragma mark - public
- (NSInteger)callWithMethod:(NSString *)method params:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier path:(NSString *)path success:(LSCallBack)success fail:(LSCallBack)fail {

    NSURLRequest *request = [[LSRequestGenerator sharedInstance] generateRequestWithServiceIdentifier:servieIdentifier requestParams:params path:path method:method];
    NSNumber *requestId = [self callApiWithRequest:request success:success fail:fail];
    return [requestId integerValue];
}

- (void)cancelRequestWithRequestID:(NSNumber *)requestID {
    
    NSURLSessionDataTask *requestOperation = self.dispatchTable[requestID];
    [requestOperation cancel];
    [self.dispatchTable removeObjectForKey:requestID];
}

- (void)cancelRequestWithRequestIDList:(NSArray *)requestIDList {
    
    for (NSNumber *requestId in requestIDList) {
        
        [self cancelRequestWithRequestID:requestId];
    }
}

#pragma mark - private
- (NSNumber *)callApiWithRequest:(NSURLRequest *)request success:(LSCallBack)success fail:(LSCallBack)fail {
    
    __block NSURLSessionDataTask *dataTask = nil;
    dataTask = [self.sessionManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        NSNumber *requestID = @([dataTask taskIdentifier]);
        [self.dispatchTable removeObjectForKey:requestID];
        
        NSData *responseData = responseObject;
        
        NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        
        // log
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        [LSNetLogger logDebugInfoWithResponse:httpResponse
                               responseString:responseString
                                      request:request
                                        error:error];
        if (error) {
            
            LSURLResponse *response = [[LSURLResponse alloc] initWithResponseString:responseString requestId:requestID request:request responseData:responseData error:error];
            fail?fail(response):nil;
        } else {
            
            LSURLResponse *response = [[LSURLResponse alloc] initWithResponseString:responseString requestId:requestID request:request responseData:responseData status:LSURLResponseStatusSuccess];
            success?success(response):nil;
        }
    }];
    
    NSNumber *requestId = @([dataTask taskIdentifier]);
    self.dispatchTable[requestId] = dataTask;
    [dataTask resume];
    
    return requestId;
}

- (AFSecurityPolicy *)customSecurityPolicy {

    NSString *cerPath = [[NSBundle mainBundle] pathForResource:kLSSelfCertificateName ofType:@"cer"];
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:[[NSSet alloc] initWithObjects:certData, nil]];
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesDomainName = NO;
        
    return securityPolicy;
}

#pragma mark - lazyLoad

- (AFHTTPSessionManager *)sessionManager {

    if (!_sessionManager) {
        
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        if (kLSIsSupportSelfCertificate) {
            
            [_sessionManager setSecurityPolicy:[self customSecurityPolicy]];
        }
    }
    
    return _sessionManager;
}

- (NSMutableDictionary *)dispatchTable {
    
    if (!_dispatchTable) {
        
        _dispatchTable = [[NSMutableDictionary alloc] init];
    }
    
    return _dispatchTable;
}

@end
