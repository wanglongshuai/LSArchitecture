//
//  LSModel.h
//  MaternalInfant
//
//  Created by 王隆帅 on 16/11/17.
//  Copyright © 2016年 王隆帅. All rights reserved.
//

/**
 Model 管理dataItem，相同模块类型数据的管理者。 也可用于处理Requeset(网络层)、DataBase（包括本地数据库及文件处理)
 原则上所有Item都是在Model中生成的，Model负责管理同一类的Item，保持全局的独一份。item的更新都会通知所有使用到item的观察者。
 */

#import <Foundation/Foundation.h>
#import "LSModelProtocol.h"

@interface LSModel : NSObject <LSModelProtocol> {
    
    /**
     观察者数组
     */
    NSHashTable *_observers;
}

/**
 代理者
 */
@property (nonatomic, weak) id<LSModelDelegate> delegate;

@end
