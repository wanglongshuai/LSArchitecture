//
//  LSNetServiceManager.m
//  LSArchitecture
//
//  Created by 王隆帅 on 2017/3/26.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "LSNetServiceManager.h"
#import "LSGeneralNetService.h"

NSString * const kLSNetServiceGeneral = @"kLSNetServiceGeneral";

@interface LSNetServiceManager ()

@property (nonatomic, strong) NSMutableDictionary *serviceStorage;

@end

@implementation LSNetServiceManager

#pragma mark - life cycle
+ (instancetype)sharedInstance {
    
    static dispatch_once_t onceToken;
    static LSNetServiceManager *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[LSNetServiceManager alloc] init];
    });
    
    return sharedInstance;
}

#pragma mark - public
- (LSNetService<LSNetServiceProtocol> *)serviceWithIdentifier:(NSString *)identifier {

    if (!self.serviceStorage[identifier]) {
        
        self.serviceStorage[identifier] = [self newServiceWithIdentifier:identifier];
    }
    
    return  self.serviceStorage[identifier];
}

#pragma mark - private
- (LSNetService<LSNetServiceProtocol> *)newServiceWithIdentifier:(NSString *)identifier {

    if ([identifier isEqualToString:kLSNetServiceGeneral]) {
        
        return [[LSGeneralNetService alloc] init];
    }
    
    return nil;
}

#pragma mark - lazyLoad
- (NSMutableDictionary *)serviceStorage {

    if (!_serviceStorage) {
        
        _serviceStorage = [NSMutableDictionary dictionary];
    }
    
    return _serviceStorage;
}

@end
