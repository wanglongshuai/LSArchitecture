//
//  LSDataItem.m
//  MaternalInfant
//
//  Created by 王隆帅 on 16/11/17.
//  Copyright © 2016年 王隆帅. All rights reserved.
//

#import "LSDataItem.h"

@implementation LSDataItem

- (instancetype)init {
    
    return [self initWithDataInfo:nil delegate:nil];
}

- (id)initWithDataInfo:(LSDataInfo *)dataInfo delegate:(NSObject <LSDataItemDelegate> *)delegate {
    
    if (self = [super init]) {
        
        _dataInfo = dataInfo;
        _delegate = delegate;
        _observers = [NSHashTable weakObjectsHashTable];
    }
    
    return self;
}

- (BOOL)addObserver:(id<LSDataItemObserver>)observer {
    
    if ([_observers containsObject:observer]) {
        
        return NO;
    } else {
        
        [_observers addObject:observer];
        return YES;
    }
}

- (BOOL)removeObserver:(id<LSDataItemObserver>)observer {
    
    if (![_observers containsObject:observer]) {
        
        return NO;
    } else {
        
        [_observers removeObject:observer];
        return YES;
    }
}

@end
