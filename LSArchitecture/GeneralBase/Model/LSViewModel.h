//
//  LSViewModel.h
//  MaternalInfant
//
//  Created by 王隆帅 on 16/11/17.
//  Copyright © 2016年 王隆帅. All rights reserved.
//

/**
 ViewModel 处理V相关逻辑部分与Model对接，可以持有DataItem数据管理Item
 */

#import <Foundation/Foundation.h>
#import "LSViewModelProtocol.h"
#import "LSDataItem.h"

@interface LSViewModel : NSObject <LSViewModelProtocol> {

    LSDataItem *_dataItem;
    NSHashTable *_observers;
      __weak NSObject<LSViewModelDelegate> *_delegate;
}

/**
 初始化方法

 @param dataItem 数据模型
 @param delegate 代理者

 @return VM实例
 */
- (id)initWithDataItem:(LSDataItem *)dataItem delegate:(NSObject<LSViewModelDelegate> *)delegate;

@end
