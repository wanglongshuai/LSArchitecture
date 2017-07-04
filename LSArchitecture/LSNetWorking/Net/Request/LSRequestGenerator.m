//
//  LSRequestGenerator.m
//  LSArchitecture
//
//  Created by 王隆帅 on 2017/3/26.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "LSRequestGenerator.h"
#import <AFNetworking/AFNetworking.h>
#import "LSNetServiceManager.h"
#import "LSNetWorkingConfiguration.h"
#import "LSAppContext.h"
#import "NSURLRequest+LSNetWork.h"
#import "LSNetLogger.h"

@interface LSRequestGenerator ()

@property (nonatomic, strong) AFHTTPRequestSerializer *httpRequestSerializer;

@end

@implementation LSRequestGenerator

+ (instancetype)sharedInstance {
    
    static dispatch_once_t onceToken;
    static LSRequestGenerator *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[LSRequestGenerator alloc] init];
    });
    
    return sharedInstance;
}

- (NSURLRequest *)generateRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams path:(NSString *)path method:(NSString *)method {

    LSNetService *service = [[LSNetServiceManager sharedInstance] serviceWithIdentifier:serviceIdentifier];
    NSString *urlString = [NSString stringWithFormat:@"%@/%@", service.apiBaseUrl, path];
    
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:method URLString:urlString parameters:requestParams error:NULL];
    request.requestParams = requestParams;
    
    // 根据不同项目设置不同的头部参数(假如要httpRequestSerializer设置head参数 需要在创建request之前设置)
//    if ([LSAppContext sharedInstance].accessToken) {
//        
//        [request setValue:[LSAppContext sharedInstance].accessToken forHTTPHeaderField:@"accessToken"];
//    }
    
    // log
    [LSNetLogger logDebugInfoWithRequest:request apiName:urlString service:service requestParams:requestParams httpMethod:method];

    return request;
}

#pragma mark - lazyLoad
- (AFHTTPRequestSerializer *)httpRequestSerializer {

    if (!_httpRequestSerializer) {
        
        _httpRequestSerializer = [AFHTTPRequestSerializer serializer];
        _httpRequestSerializer.timeoutInterval = kLSNetworkingTimeoutSeconds;
        _httpRequestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    }
    
    return _httpRequestSerializer;
}

@end
