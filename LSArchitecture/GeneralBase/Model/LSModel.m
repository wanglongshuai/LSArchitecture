//
//  LSModel.m
//  MaternalInfant
//
//  Created by 王隆帅 on 16/11/17.
//  Copyright © 2016年 王隆帅. All rights reserved.
//

#import "LSModel.h"

@implementation LSModel

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    LSModel *model = [super allocWithZone:zone];
    
    if (model) {
        
        [model model_initData];
    }
    return model;
}

- (void)model_initData {

    _observers = [NSHashTable weakObjectsHashTable];
}

- (BOOL)addObserver:(id<LSModelObserver>)observer {

    if ([_observers containsObject:observer]) {
        
        return NO;
    } else {
    
        [_observers addObject:observer];
        return YES;
    }
}

- (BOOL)removeObserver:(id<LSModelObserver>)observer {

    if (![_observers containsObject:observer]) {
        
        return NO;
    } else {
        
        [_observers removeObject:observer];
        return YES;
    }
}


@end
