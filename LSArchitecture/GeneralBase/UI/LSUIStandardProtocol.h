//
//  LSUIStandardProtocol.h
//  LSArchitecture
//
//  Created by 王隆帅 on 2017/3/24.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LSUIStandardProtocol <NSObject>

@optional

/**
 设置初始化数据
 */
- (void)ls_initData;

/**
 添加子视图
 */
- (void)ls_addSubviews;

/**
 子视图布局
 */
- (void)ls_layoutSubviews;

/**
 绑定VM
 */
- (void)ls_bindViewModel;

@end
