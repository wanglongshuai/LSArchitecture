//
//  LSCodeStandardModel.h
//  LSArchitecture
//
//  Created by 王隆帅 on 17/3/27.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "LSModel.h"
#import "LSCodeStandardItem.h"
#import "LSCodeStandardInfo.h"

@interface LSCodeStandardModel : LSModel

+ (instancetype)sharedInstance;

- (LSCodeStandardItem *)getCodeStandardItemWithInfo:(LSCodeStandardInfo *)info;

@end
