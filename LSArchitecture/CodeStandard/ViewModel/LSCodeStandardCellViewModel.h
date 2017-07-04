//
//  LSCodeStandardCellViewModel.h
//  LSArchitecture
//
//  Created by 王隆帅 on 17/3/27.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "LSViewModel.h"
#import "LSCodeStandardItem.h"

@interface LSCodeStandardCellViewModel : LSViewModel

@property (nonatomic, strong, readonly) LSCodeStandardItem *item;

@end
