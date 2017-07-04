//
//  NSURLRequest+LSNetWork.m
//  LSArchitecture
//
//  Created by 王隆帅 on 2017/3/26.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "NSURLRequest+LSNetWork.h"
#import <objc/runtime.h>

static void *LSNetworkingRequestParams;

@implementation NSURLRequest (LSNetWork)

- (void)setRequestParams:(NSDictionary *)requestParams {
    
    objc_setAssociatedObject(self, &LSNetworkingRequestParams, requestParams, OBJC_ASSOCIATION_COPY);
}

- (NSDictionary *)requestParams {
    
    return objc_getAssociatedObject(self, &LSNetworkingRequestParams);
}


@end
