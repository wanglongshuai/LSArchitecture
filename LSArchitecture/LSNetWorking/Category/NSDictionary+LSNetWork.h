//
//  NSDictionary+LSNetWork.h
//  LSArchitecture
//
//  Created by 王隆帅 on 2017/3/26.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (LSNetWork)

/**
 参数字典转字符串

 @param isEncode 是否编码
 @return 参数字符串
 */
- (NSString *)LS_paramsStringWithEncode:(BOOL)isEncode;

/**
 字典转json字符串

 @return json字符串
 */
- (NSString *)LS_jsonString;

@end
