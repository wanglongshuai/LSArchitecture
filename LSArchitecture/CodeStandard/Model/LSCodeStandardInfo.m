//
//  LSCodeStandardInfo.m
//  LSArchitecture
//
//  Created by 王隆帅 on 17/3/27.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "LSCodeStandardInfo.h"

@implementation LSCodeStandardInfo

- (instancetype)initWithDict:(NSDictionary *)dict {
    
    self = [super init];
    
    if (self) {
        
        [self initWithDictionary:dict];
    }
    
    return self;
}

/*
 此处需要添加安全操作处理（后期添加）
 */
- (void)initWithDictionary:(NSDictionary *)dicionary {

    _jid = dicionary[@"id"];
    _title = dicionary[@"title"];
    _content = dicionary[@"score"];
    _image = dicionary[@"img"];
    _bgColor = [UIColor colorWithRed:random() % 255 / 255.0 green:random() % 255 / 255.0 blue:random() % 255 / 255.0 alpha:1.0];
}

- (void)updateDataInfo:(LSCodeStandardInfo *)dataInfo {

    if (dataInfo.title) {
        
        _title = dataInfo.title;
    }
    
    if (dataInfo.content) {
        
        _content = dataInfo.content;
    }
    
    if (dataInfo.image) {
        
        _content = dataInfo.image;
    }
    
    /**
     测试确定数据改变了
     */
    _bgColor = [UIColor colorWithRed:random() % 255 / 255.0 green:random() % 255 / 255.0 blue:random() % 255 / 255.0 alpha:1.0];
}

@end
