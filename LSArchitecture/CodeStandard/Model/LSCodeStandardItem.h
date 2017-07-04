//
//  LSCodeStandardItem.h
//  LSArchitecture
//
//  Created by 王隆帅 on 17/3/27.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "LSDataItem.h"
#import "LSCodeStandardInfo.h"

@class LSCodeStandardItem;
@protocol LSCodeStandardItemObserver <LSDataItemObserver>

@optional

- (void)codeStandardItemDataChange:(LSCodeStandardItem *)item;

@end

@protocol LSCodeStandardItemDelegate <LSDataItemDelegate>

- (void)removeFromCodeStandardModel:(LSCodeStandardItem *)item;

@end

@interface LSCodeStandardItem : LSDataItem

@property (nonatomic, strong, readonly) LSCodeStandardInfo *codeStandardInfo;

#pragma mark - logic
- (void)updateTimeFireObserver:(BOOL)fireObserver;

#pragma mark - data
- (void)updateDataInfo:(LSCodeStandardInfo *)dataInfo;

@end
