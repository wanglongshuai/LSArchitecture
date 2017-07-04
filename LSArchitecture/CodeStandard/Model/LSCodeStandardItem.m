//
//  LSCodeStandardItem.m
//  LSArchitecture
//
//  Created by 王隆帅 on 17/3/27.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "LSCodeStandardItem.h"

@implementation LSCodeStandardItem

- (LSCodeStandardInfo *)codeStandardInfo {

    return (LSCodeStandardInfo *)_dataInfo;
}

#pragma mark - system

- (void)dealloc {
    
    if (_delegate && [(id<LSCodeStandardItemDelegate>)_delegate respondsToSelector:@selector(removeFromCodeStandardModel:)] ) {
        
        [(id<LSCodeStandardItemDelegate>)_delegate removeFromCodeStandardModel:self];
    }
}

#pragma mark - public
- (void)updateTimeFireObserver:(BOOL)fireObserver {
    
    if (fireObserver) {
        
        // undo 测试observer 并没有什么卵用
        [self.codeStandardInfo updateDataInfo:nil];
        
        [self fireUpdateTimeObservers];
    }
}

#pragma mark - update data
- (void)updateDataInfo:(LSCodeStandardInfo *)dataInfo {

    [self.codeStandardInfo updateDataInfo:dataInfo];
    [self fireUpdateTimeObservers];
}

#pragma mark - private
- (void)fireUpdateTimeObservers {
    
    NSHashTable *tmp = [_observers copy];;
    
    for (id<LSCodeStandardItemObserver> observer in tmp) {
        
        if ( ![_observers containsObject:observer]) {
            continue;
        }
        
        if ([observer respondsToSelector:@selector(codeStandardItemDataChange:)]) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [observer codeStandardItemDataChange:self];
            });
        }
    }
}



@end
