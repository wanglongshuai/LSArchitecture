//
//  LSDataItem.h
//  MaternalInfant
//
//  Created by 王隆帅 on 16/11/17.
//  Copyright © 2016年 王隆帅. All rights reserved.
//

/**
 dataInfo的一层逻辑封装，会在合适的时候与VM、M对接，主要是数据逻辑处理及封装。
 */

#import <Foundation/Foundation.h>
#import "LSDataItemProtocol.h"
#import "LSDataInfo.h"

@interface LSDataItem : NSObject <LSDataItemProtocol> {

    /**
     数据模型
     */
    LSDataInfo * _dataInfo;
    /**
     观察者数组
     */
    NSHashTable *_observers;
    /**
     代理者
     */
    __weak NSObject<LSDataItemDelegate> *_delegate;
}

/**
 初始化方法
 
 @param dataInfo 数据模型
 @param delegate 代理者
 
 @return VM实例
 */
- (id)initWithDataInfo:(LSDataInfo *)dataInfo delegate:(NSObject <LSDataItemDelegate> *)delegate;

@end
