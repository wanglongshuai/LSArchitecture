//
//  LSCodeStandardViewModel.h
//  LSArchitecture
//
//  Created by 王隆帅 on 17/3/27.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "LSViewModel.h"

@interface LSCodeStandardViewModel : LSViewModel

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) RACSubject *refreshSubject;

- (void)loadData;

@end
