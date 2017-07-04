//
//  LSCodeStandardModel.m
//  LSArchitecture
//
//  Created by 王隆帅 on 17/3/27.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "LSCodeStandardModel.h"

@interface LSCodeStandardModel () <LSCodeStandardItemDelegate>

@property (nonatomic, strong) RACDisposable *timerDispose;

@property (nonatomic, strong) NSMutableDictionary *itemsDictionary;

@end

@implementation LSCodeStandardModel {

    NSHashTable *_itemList;
}

+ (instancetype)sharedInstance {
    
    static LSCodeStandardModel *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[LSCodeStandardModel alloc] init];
    });
    
    return sharedInstance;
}

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        _itemList = [NSHashTable weakObjectsHashTable];
    }
    
    return self;
}

#pragma mark - private

- (void)initTimer {
    
    @weakify(self);
    
    if (_timerDispose) {
        
        [_timerDispose dispose];
        _timerDispose = nil;
    }
    
    self.timerDispose = [[RACSignal interval:1.0 onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
       
        @strongify(self);
        [self fireTimerObservers];
    }];
}

- (void)clearTimer {
    
    if (_timerDispose) {
        
        [_timerDispose dispose];
        _timerDispose = nil;
    }
}

- (void)fireTimerObservers {
    
    NSHashTable *tmp = [_itemList copy];;
    
    for (LSCodeStandardItem *codeStandardItem in tmp) {
        
        if ( ![_itemList containsObject:codeStandardItem]) {
            
            continue;
        }
        
        [codeStandardItem updateTimeFireObserver:YES];
    }
}

#pragma mark - public
- (LSCodeStandardItem *)getCodeStandardItemWithInfo:(LSCodeStandardInfo *)info {
    
    if (!info) {
        
        return nil;
    }
    
    NSString *jid = info.jid;
    
    if (![self.itemsDictionary objectForKey:jid]) {
        
        LSCodeStandardItem *item = [[LSCodeStandardItem alloc] initWithDataInfo:info delegate:self];
        
        NSValue *value = [NSValue valueWithNonretainedObject:item];
        [self.itemsDictionary setObject:value forKey:jid];
        
        [_itemList addObject:item];
        
        if (_itemList.count > 0 && !_timerDispose) {
            
            [self initTimer];
        }
        
        return item;
    } else {
        
        LSCodeStandardItem *item = (LSCodeStandardItem *)((NSValue *)[self.itemsDictionary objectForKey:jid]).nonretainedObjectValue;
        [item updateDataInfo:info];
        
        return item;
    }
}

#pragma mark - lazyLoad
- (NSMutableDictionary *)itemsDictionary {
    
    if (!_itemsDictionary) {
        
        _itemsDictionary = [[NSMutableDictionary alloc] init];
    }
    
    return _itemsDictionary;
}

#pragma mark - LSCodeStandardItemDelegate
- (void)removeFromCodeStandardModel:(LSCodeStandardItem *)item {
    
    NSString *jid = item.codeStandardInfo.jid;
    
    if ([self.itemsDictionary.allKeys containsObject:jid]) {
        
        [self.itemsDictionary removeObjectForKey:jid];
    }
    
    if (self.itemsDictionary.allKeys.count == 0 && _timerDispose) {
        
        [self clearTimer];
    }
}


@end
