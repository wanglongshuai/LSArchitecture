//
//  LSDataItemProtocol.h
//  MaternalInfant
//
//  Created by 王隆帅 on 16/11/17.
//  Copyright © 2016年 王隆帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LSDataItemObserver;

// dataItem 方法
@protocol LSDataItemProtocol <NSObject>

// 添加LSDataItem的Observer，用于捕获LSDataItem状态变化
// 返回YES表示添加成功，返回NO表示已经存在
- (BOOL)addObserver:(id<LSDataItemObserver>)observer;

// 删除Observer
// 返回YES表示成功，返回NO表示Observer不存在
- (BOOL)removeObserver:(id<LSDataItemObserver>)observer;

@end

// 观察者
@protocol LSDataItemObserver <NSObject>

@end

// 代理者
@protocol LSDataItemDelegate <NSObject>

@end
