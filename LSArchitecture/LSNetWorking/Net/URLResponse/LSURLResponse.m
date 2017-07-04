//
//  LSURLResponse.m
//  LSArchitecture
//
//  Created by 王隆帅 on 2017/3/26.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "LSURLResponse.h"
#import "NSURLRequest+LSNetWork.h"
#import "NSObject+LSNetWork.h"

@interface LSURLResponse ()

@property (nonatomic, assign, readwrite) LSURLResponseStatus status;
@property (nonatomic, copy, readwrite) NSString *contentString;
@property (nonatomic, copy, readwrite) id content;
@property (nonatomic, copy, readwrite) NSURLRequest *request;
@property (nonatomic, assign, readwrite) NSInteger requestId;
@property (nonatomic, copy, readwrite) NSData *responseData;
@property (nonatomic, assign, readwrite) BOOL isCache;

@end

@implementation LSURLResponse

- (instancetype)initWithResponseString:(NSString *)responseString
                             requestId:(NSNumber *)requestId
                               request:(NSURLRequest *)request
                          responseData:(NSData *)responseData
                                status:(LSURLResponseStatus)status {
    self = [super init];
    
    if (self) {
        
        self.contentString = responseString;
        self.content = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:NULL];
        self.status = status;
        self.requestId = [requestId integerValue];
        self.request = request;
        self.responseData = responseData;
        self.requestParams = request.requestParams;
        self.isCache = NO;
    }
    
    return self;
}

- (instancetype)initWithResponseString:(NSString *)responseString
                             requestId:(NSNumber *)requestId
                               request:(NSURLRequest *)request
                          responseData:(NSData *)responseData
                                 error:(NSError *)error {
    
    self = [super init];

    if (self) {
    
        self.contentString = [responseString LS_defaultValue:@""];
        self.status = [self responseStatusWithError:error];
        self.requestId = [requestId integerValue];
        self.request = request;
        self.responseData = responseData;
        self.requestParams = request.requestParams;
        self.isCache = NO;
        
        if (responseData) {
           
            self.content = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:NULL];
        } else {
            
            self.content = nil;
        }
    }
    
    return self;

}

- (instancetype)initWithData:(NSData *)data {

    self = [super init];
   
    if (self) {
        
        self.contentString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        self.status = [self responseStatusWithError:nil];
        self.requestId = 0;
        self.request = nil;
        self.responseData = [data copy];
        self.content = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:NULL];
        self.isCache = YES;
    }
   
    return self;

}

#pragma mark - private methods
- (LSURLResponseStatus)responseStatusWithError:(NSError *)error{
    
    if (error) {
        
        LSURLResponseStatus result = LSURLResponseStatusNoNetwork;
        
        if (error.code == NSURLErrorTimedOut) {
            
            result = LSURLResponseStatusTimeout;
        }
        
        return result;
    } else {
        
        return LSURLResponseStatusSuccess;
    }
}

@end
