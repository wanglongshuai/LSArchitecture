//
//  LSBaseViewControllerProtocol.h
//  LSArchitecture
//
//  Created by 王隆帅 on 17/3/27.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LSBaseViewControllerProtocol <NSObject>

- (void)setIsExtendLayout:(BOOL)isExtendLayout;

- (void)initializeSelfVCSetting;

- (void)layoutNavigationBar:(UIImage*)backGroundImage
                 titleColor:(UIColor*)titleColor
                  titleFont:(UIFont*)titleFont
          leftBarButtonItem:(UIBarButtonItem*)leftItem
         rightBarButtonItem:(UIBarButtonItem*)rightItem;

- (void)removeNavgationBarLine;

@end
