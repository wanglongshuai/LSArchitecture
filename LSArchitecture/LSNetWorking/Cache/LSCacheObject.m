//
//  LSCacheObject.m
//  LSArchitecture
//
//  Created by 王隆帅 on 2017/3/26.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "LSCacheObject.h"
#import "LSNetWorkingConfiguration.h"

@implementation LSCacheObject

#pragma mark - getters and setters
- (BOOL)isEmpty {

    return _content == nil;
}

- (BOOL)isOutdated {
    
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:_lastUpdateTime];
    return timeInterval > kLSCacheOutdateTimeSeconds;
}

#pragma mark - life cycle
- (instancetype)initWithContent:(NSData *)content {

    self = [super init];
    if (self) {
        
        _content = content;
        _lastUpdateTime = [NSDate date];
    }
    
    return self;
}

#pragma mark - public
- (void)updateContent:(NSData *)content {

    _content = [content copy];
    _lastUpdateTime = [NSDate date];
}

@end
