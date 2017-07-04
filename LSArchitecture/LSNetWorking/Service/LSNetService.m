//
//  LSNetService.m
//  LSArchitecture
//
//  Created by 王隆帅 on 2017/3/26.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "LSNetService.h"

@implementation LSNetService

- (instancetype)init {

    self = [super init];
    
    if (self) {
        
        if ([self conformsToProtocol:@protocol(LSNetServiceProtocol)]) {
            
            self.child = (id <LSNetServiceProtocol>)self;
        } else {
           
            NSException *exception = [[NSException alloc] initWithName:@"LSNetService继承错误" reason:[NSString stringWithFormat:@"子类%@要遵守协议：LSNetServiceProtocol",[NSString stringWithUTF8String:object_getClassName([self class])]] userInfo:nil];
            @throw exception;
        }
    }
    
    return self;
}

#pragma mark - getters and setters
- (NSString *)apiBaseUrl {
    
    return self.child.isOnline ? self.child.onlineApiBaseUrl : self.child.offlineApiBaseUrl;
}

@end
