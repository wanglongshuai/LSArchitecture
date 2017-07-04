//
//  UIViewController+Standard.m
//  LSArchitecture
//
//  Created by 王隆帅 on 17/3/3.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "UIViewController+Standard.h"

@implementation UIViewController (Standard)

#pragma clang diagnostic ignored "-Wobjc-designated-initializers"

- (instancetype)initWithViewModel:(id<LSViewModelProtocol>)viewModel {
    
    self = [self init];
    
    if (self) {
        
        if ([self respondsToSelector:@selector(ls_getViewModel:)]) {
            
            [self ls_getViewModel:viewModel];
        } else {
            
            NSException *exception = [[NSException alloc] initWithName:@"ViewController并没有接收ViewModel" reason:[NSString stringWithFormat:@"%@要实现：ls_getViewModel方法",[NSString stringWithUTF8String:object_getClassName([self class])]] userInfo:nil];
            
            @throw exception;
        }
        
    }
    
    return self;
}

- (void)setIsExtendLayout:(BOOL)isExtendLayout {
    
    if (!isExtendLayout) {
        
        [self initializeSelfVCSetting];
    }
}

- (void)initializeSelfVCSetting {
    
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
    }
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
}

- (void)layoutNavigationBar:(UIImage*)backGroundImage
                 titleColor:(UIColor*)titleColor
                  titleFont:(UIFont*)titleFont
          leftBarButtonItem:(UIBarButtonItem*)leftItem
         rightBarButtonItem:(UIBarButtonItem*)rightItem {
    
    if (backGroundImage) {
        
        [self.navigationController.navigationBar setBackgroundImage:backGroundImage forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    }
    
    if (titleColor&&titleFont) {
        
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:titleColor,NSFontAttributeName:titleFont}];
    } else if (titleFont) {
        
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:titleFont}];
    } else if (titleColor){
        
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:titleColor}];
    }
    
    if (leftItem) {
        
        self.navigationItem.leftBarButtonItem=leftItem;
    }
    
    if (rightItem) {
        
        self.navigationItem.rightBarButtonItem=rightItem;
    }
}

- (void)removeNavgationBarLine {
    
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]){
        
        NSArray *list=self.navigationController.navigationBar.subviews;
        
        for (id obj in list) {
            
            if ([obj isKindOfClass:[UIImageView class]]) {
                
                UIImageView *imageView=(UIImageView *)obj;
                
                NSArray *list2=imageView.subviews;
                
                for (id obj2 in list2) {
                    
                    if ([obj2 isKindOfClass:[UIImageView class]]) {
                        
                        UIImageView *imageView2=(UIImageView *)obj2;
                        
                        imageView2.hidden=YES;
                    }
                }
                
            }
            
        }
    }
}


@end
