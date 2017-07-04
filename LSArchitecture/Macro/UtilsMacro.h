//
//  UtilsMacro.h
//  LSArchitecture
//
//  Created by 王隆帅 on 2017/3/24.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

/**
 获取屏幕 宽度、高度 bounds就是屏幕的全部区域
 */
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

/**
 rgb颜色转换（16进制->10进制）
 */
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

/**
 rgba颜色转换（16进制->10进制）+ 透明值
 */
#define UIColorFromRGBA(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

/**
 弱引用
 */
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self
