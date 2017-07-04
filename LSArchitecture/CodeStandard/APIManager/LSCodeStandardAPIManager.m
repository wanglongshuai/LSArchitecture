//
//  LSCodeStandardAPIManager.m
//  LSArchitecture
//
//  Created by 王隆帅 on 17/3/27.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "LSCodeStandardAPIManager.h"

@interface LSCodeStandardAPIManager () 

@end

@implementation LSCodeStandardAPIManager

- (instancetype)init {

    self = [super init];
    
    if (self) {
        
        self.checker = self;
    }
    
    return self;
}

#pragma mark - LSAPIManagerProtocol
- (NSString *)path {

    return @"CollectShopList.aspx/";
}

-(NSString *)serviceIdentifier {

    return kLSNetServiceGeneral;
}

- (LSAPIManagerRequestType)requestType {

    return LSAPIManagerRequestTypeGET;
}

- (NSDictionary *)requestParams:(NSDictionary *)params {

    return params;
}

- (BOOL)shouldCache {

    return YES;
}

#pragma mark - LSAPIManagerDataChecker
- (BOOL)manager:(LSAPIBaseManager *)manager isCorrectWithParamsData:(NSDictionary *)data {
    
    NSLog(@"验证成功 + isCorrectWithParamsData + %@", data);
    return YES;
}

- (BOOL)manager:(LSAPIBaseManager *)manager isCorrectWithCallBackData:(NSDictionary *)data {

    NSLog(@"验证成功 + isCorrectWithCallBackData + %@", data);

    return YES;
}

@end
