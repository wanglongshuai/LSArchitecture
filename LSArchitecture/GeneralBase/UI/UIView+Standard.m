//
//  UIView+Standard.m
//  LSArchitecture
//
//  Created by 王隆帅 on 17/3/3.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "UIView+Standard.h"

@implementation UIView (Standard)

#pragma clang diagnostic ignored "-Wobjc-designated-initializers"

- (instancetype)initWithViewModel:(id<LSViewModelProtocol>)viewModel {

    self = [self initWithFrame:CGRectZero];
    
    if (self) {
        
        if ([self respondsToSelector:@selector(ls_getViewModel:)]) {
            
            [self ls_getViewModel:viewModel];
        } else {
            
            NSException *exception = [[NSException alloc] initWithName:@"View并没有接收ViewModel" reason:[NSString stringWithFormat:@"%@要实现：ls_getViewModel方法",[NSString stringWithUTF8String:object_getClassName([self class])]] userInfo:nil];
            
            @throw exception;
        }
        
    }
    
    return self;
}

@end
