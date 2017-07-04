//
//  LSNetLogger.h
//  LSArchitecture
//
//  Created by 王隆帅 on 17/3/27.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSNetService.h"
#import "LSURLResponse.h"

@interface LSNetLogger : NSObject

+ (instancetype)sharedInstance;

+ (void)logDebugInfoWithRequest:(NSURLRequest *)request apiName:(NSString *)apiName service:(LSNetService *)service requestParams:(id)requestParams httpMethod:(NSString *)httpMethod;

+ (void)logDebugInfoWithResponse:(NSHTTPURLResponse *)response responseString:(NSString *)responseString request:(NSURLRequest *)request error:(NSError *)error;

+ (void)logDebugInfoWithCachedResponse:(LSURLResponse *)response path:(NSString *)path serviceIdentifier:(LSNetService *)service;

@end
