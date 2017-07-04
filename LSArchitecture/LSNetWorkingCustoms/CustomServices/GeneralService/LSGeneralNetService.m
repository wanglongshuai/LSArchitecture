//
//  LSGeneralNetService.m
//  LSArchitecture
//
//  Created by 王隆帅 on 2017/3/26.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "LSGeneralNetService.h"
#import "LSAppContext.h"

@implementation LSGeneralNetService

- (BOOL)isOnline {
    
    return [[LSAppContext sharedInstance] isOnline];
}

- (NSString *)onlineApiBaseUrl {

    return @"http://115.29.103.17:8030";
}

- (NSString *)offlineApiBaseUrl {

    return @"http://115.29.103.17:8030";
}

@end
