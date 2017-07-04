//
//  LSViewModel.m
//  MaternalInfant
//
//  Created by 王隆帅 on 16/11/17.
//  Copyright © 2016年 王隆帅. All rights reserved.
//

#import "LSViewModel.h"

@implementation LSViewModel

- (instancetype)init {

    return [self initWithDataItem:nil delegate:nil];
}

- (id)initWithDataItem:(LSDataItem *)dataItem delegate:(NSObject<LSViewModelDelegate> *)delegate {

    if (self = [super init]) {
        
        _dataItem = dataItem;
        _delegate = delegate;
        _observers = [NSHashTable weakObjectsHashTable];
    }
    
    return self;
}

- (BOOL)addObserver:(id<LSViewModelObserver>)observer {
    
    if ([_observers containsObject:observer]) {
        
        return NO;
    } else {
        
        [_observers addObject:observer];
        return YES;
    }
}

- (BOOL)removeObserver:(id<LSViewModelObserver>)observer {
    
    if (![_observers containsObject:observer]) {
        
        return NO;
    } else {
        
        [_observers removeObject:observer];
        return YES;
    }
}

- (void)dealloc {
    
    NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));
}

@end
