//
//  LSCodeStandardInfo.h
//  LSArchitecture
//
//  Created by 王隆帅 on 17/3/27.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "LSDataInfo.h"

@interface LSCodeStandardInfo : LSDataInfo

@property (nonatomic, strong, readonly) NSString *jid;

@property (nonatomic, strong, readonly) NSString *title;

@property (nonatomic, strong, readonly) NSString *content;

@property (nonatomic, strong, readonly) NSString *image;

@property (nonatomic, strong, readonly) UIColor *bgColor;

- (instancetype)initWithDict:(NSDictionary *)dict;

- (void)updateDataInfo:(LSCodeStandardInfo *)dataInfo;

@end
