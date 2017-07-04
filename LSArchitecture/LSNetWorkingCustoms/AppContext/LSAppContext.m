//
//  LSAppContext.m
//  LSArchitecture
//
//  Created by 王隆帅 on 2017/3/26.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "LSAppContext.h"
#import <AFNetworking/AFNetworking.h>
#import "LSNetWorkingConfiguration.h"

@interface LSAppContext ()

@property (nonatomic, copy, readwrite) NSString *accessToken;

@end

@implementation LSAppContext

@synthesize userInfo = _userInfo;
@synthesize userID = _userID;

#pragma mark - life cycle
+ (instancetype)sharedInstance {
    
    static LSAppContext *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[LSAppContext alloc] init];
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    });
    
    return sharedInstance;
}

#pragma mark - public
- (void)cleanUserInfo {
    
    _accessToken = nil;
    _userInfo = nil;
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"accessToken"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userInfo"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - getters and setters
- (void)setUserID:(NSString *)userID {
    
    _userID = [userID copy];
    
    [[NSUserDefaults standardUserDefaults] setObject:_userID forKey:@"userId"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)userID {
    
    if (_userID == nil) {
        
        _userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    }
    
    return _userID;
}

- (void)setUserInfo:(NSDictionary *)userInfo {
    
    _userInfo = [userInfo copy];
    
    [[NSUserDefaults standardUserDefaults] setObject:_userInfo forKey:@"userInfo"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSDictionary *)userInfo {
    
    if (_userInfo == nil) {
        
        _userInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    }
    
    return _userInfo;
}

- (NSString *)accessToken {
    
    if (_accessToken == nil) {
        
        _accessToken = [[NSUserDefaults standardUserDefaults] stringForKey:@"accessToken"];
    }
    
    return _accessToken;
}

- (BOOL)isReachable {
    
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusUnknown) {
        
        return YES;
    } else {
        
        return [[AFNetworkReachabilityManager sharedManager] isReachable];
    }
}

- (NSString *)appVersion {
    
    return [[NSBundle mainBundle] infoDictionary][@"CFBundleVersion"];
}

- (BOOL)isLoggedIn {
    
    BOOL result = (self.userID.length != 0);
    return result;
}

- (BOOL)isOnline {
    
    BOOL isOnline = NO;
    
    NSString *filepath = [[NSBundle mainBundle] pathForResource:@"LSNetWokingConfiguration" ofType:@"plist"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filepath]) {
        
        NSDictionary *settings = [[NSDictionary alloc] initWithContentsOfFile:filepath];
        isOnline = [settings[@"isOnline"] boolValue];
    } else {
       
        isOnline = kLSNetServiceIsOnline;
    }
    
    return isOnline;
}


@end
