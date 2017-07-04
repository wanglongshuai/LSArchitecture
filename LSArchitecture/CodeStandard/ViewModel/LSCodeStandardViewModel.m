//
//  LSCodeStandardViewModel.m
//  LSArchitecture
//
//  Created by 王隆帅 on 17/3/27.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "LSCodeStandardViewModel.h"
#import "LSCodeStandardAPIManager.h"
#import "LSCodeStandardDataTranslator.h"

@interface LSCodeStandardViewModel () <LSAPIManagerCallBackDelegate,LSAPIManagerParamSource,LSAPIManagerInterceptor>

@property (nonatomic, strong) LSCodeStandardAPIManager *standardAPIManager;

@property (nonatomic, strong) LSCodeStandardDataTranslator *translator;

@end

@implementation LSCodeStandardViewModel

#pragma mark - public
- (void)loadData {

    [self.standardAPIManager loadData];
}

#pragma mark - LSAPIManagerParamSource
- (NSDictionary *)paramsDataForAPIManager:(LSAPIBaseManager *)manager {

    return [@{@"page": @"1",
              @"token":@"55c16d79a6854379a39628e43339115c",
              @"size":@"15"
              } mutableCopy];
}

#pragma mark - LSAPIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(LSAPIBaseManager *)manager {
    
    self.dataArray = [manager fetchDataWithTranslator:self.translator];
    [self.refreshSubject sendNext:nil];
}

- (void)managerCallAPIDidFailed:(LSAPIBaseManager *)manager {
    
    NSLog(@"获取数据失败啦!");
}

#pragma mark - LSAPIManagerInterceptor
- (BOOL)manager:(LSAPIBaseManager *)manager beforePerformSuccessWithResponse:(LSURLResponse *)response {
    
    NSLog(@"拦截到 + beforePerformSuccessWithResponse + %@", response);
    
    return YES;
}

- (void)manager:(LSAPIBaseManager *)manager afterPerformSuccessWithResponse:(LSURLResponse *)response {
    
    NSLog(@"拦截到 + afterPerformSuccessWithResponse + %@", response);
}

- (BOOL)manager:(LSAPIBaseManager *)manager beforePerformFailWithResponse:(LSURLResponse *)response {
    
    NSLog(@"拦截到 + beforePerformFailWithResponse + %@", response);
    
    return YES;
}
- (void)manager:(LSAPIBaseManager *)manager afterPerformFailWithResponse:(LSURLResponse *)response {
    
    NSLog(@"拦截到 + afterPerformFailWithResponse + %@", response);
}

- (BOOL)manager:(LSAPIBaseManager *)manager shouldCallAPIWithParams:(NSDictionary *)params {
    
    NSLog(@"拦截到 + shouldCallAPIWithParams + %@", params);
    return YES;
}
- (void)manager:(LSAPIBaseManager *)manager afterCallingAPIWithParams:(NSDictionary *)params {
    
    NSLog(@"拦截到 + afterCallingAPIWithParams + %@", params);
}

#pragma mark - lazyLoad
- (RACSubject *)refreshSubject {

    if (!_refreshSubject) {
        
        _refreshSubject = [RACSubject subject];
    }
    
    return _refreshSubject;
}

- (LSCodeStandardAPIManager *)standardAPIManager {
    
    if (!_standardAPIManager) {
        
        _standardAPIManager = [[LSCodeStandardAPIManager alloc] init];
        _standardAPIManager.delegate = self;
        _standardAPIManager.paramSource = self;
        _standardAPIManager.interceptor = self;
    }
    
    return _standardAPIManager;
}

- (LSCodeStandardDataTranslator *)translator {
    
    if (!_translator) {
        
        _translator = [[LSCodeStandardDataTranslator alloc] init];
    }
    
    return _translator;
}

- (NSArray *)dataArray {

    if (!_dataArray) {
        
        _dataArray = [NSArray array];
    }
    
    return _dataArray;
}

@end
