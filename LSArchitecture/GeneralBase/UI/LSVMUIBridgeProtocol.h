//
//  LSVMUIBridgeProtocol.h
//  LSArchitecture
//
//  Created by 王隆帅 on 2017/3/24.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSViewModelProtocol.h"

@protocol LSVMUIBridgeProtocol <NSObject>

@optional

/**
 使用VM初始化数据(并不建议重载，在分类里已经处理了)
 */
- (instancetype)initWithViewModel:(id <LSViewModelProtocol>)viewModel;


/**
 获取初始化的ViewModel

 @param viewModel 初始化传过来的ViewModel
 */
- (void)ls_getViewModel:(id<LSViewModelProtocol>)viewModel;

@end
