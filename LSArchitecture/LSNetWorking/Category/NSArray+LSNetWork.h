//
//  NSArray+LSNetWork.h
//  LSArchitecture
//
//  Created by 王隆帅 on 2017/3/26.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (LSNetWork)

/**
 数组转字符串

 @return 参数字符串
 */
- (NSString *)LS_paramsString;

/**
 数组转json

 @return json字符串
 */
- (NSString *)LS_jsonString;

@end
