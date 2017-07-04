//
//  LSIntercepter.m
//  LSArchitecture
//
//  Created by 王隆帅 on 2017/3/24.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "LSIntercepter.h"
#import <Aspects/Aspects.h>
#import <UIKit/UIKit.h>
#import "UIViewController+Standard.h"
#import "UIView+Standard.h"

@implementation LSIntercepter

+ (void)load {
    
    [super load];
    [LSIntercepter shareInstance];
}

+ (instancetype)shareInstance {
    
    static dispatch_once_t onceToken;
    static LSIntercepter *shareInstance;
    dispatch_once(&onceToken, ^{
        
        shareInstance = [[LSIntercepter alloc] init];
    });
    
    return shareInstance;
}

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        [UIViewController aspect_hookSelector:@selector(viewDidLoad) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo>aspectInfo){
            
            [self viewDidLoad:[aspectInfo instance]];
            
        } error:NULL];
        
        [UIView aspect_hookSelector:@selector(initWithViewModel:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo>aspectInfo){
            
            [self viewInitWithViewModel:[aspectInfo instance]];
            
        } error:NULL];
        
        [UIView aspect_hookSelector:@selector(initWithFrame:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo>aspectInfo){
            
            [self viewInit:[aspectInfo instance]];
            
        } error:NULL];
        
        [UITableViewCell aspect_hookSelector:@selector(initWithStyle:reuseIdentifier:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo>aspectInfo){
            
            [self tableViewCellInit:[aspectInfo instance]];
            
        } error:NULL];
        
    }
    
    return self;
}

#pragma mark - fake methods
- (void)viewDidLoad:(UIViewController *)viewController {
    
    if ([viewController respondsToSelector:@selector(setIsExtendLayout:)]) {
        
        [viewController setIsExtendLayout:NO];
    }
    
    if ([viewController respondsToSelector:@selector(removeNavgationBarLine)]) {
        
        [viewController removeNavgationBarLine];
    }
    
    if ([viewController respondsToSelector:@selector(layoutNavigationBar:titleColor:titleFont:leftBarButtonItem:rightBarButtonItem:)]) {
        
        [viewController layoutNavigationBar:nil titleColor:[UIColor redColor] titleFont:[UIFont boldSystemFontOfSize:18] leftBarButtonItem:nil rightBarButtonItem:nil];
    }
    
    if ([viewController respondsToSelector:@selector(ls_initData)]) {
        
        [viewController ls_initData];
    }
    
    if ([viewController respondsToSelector:@selector(ls_addSubviews)]) {
        
        [viewController ls_addSubviews];
    }
    
    if ([viewController respondsToSelector:@selector(ls_layoutSubviews)]) {
        
        [viewController ls_layoutSubviews];
    }
    
    if ([viewController respondsToSelector:@selector(ls_bindViewModel)]) {
        
        [viewController ls_bindViewModel];
    }
}

- (void)viewInitWithViewModel:(UIView *)view {
    
    if (![view respondsToSelector:@selector(ls_getViewModel:)]) {
        
        return;
    }

    if (view && [view respondsToSelector:@selector(ls_initData)] && ![view isKindOfClass:[UITableViewCell class]]) {
        
        [view ls_initData];
    }
    
    if (view && [view respondsToSelector:@selector(ls_addSubviews)] && ![view isKindOfClass:[UITableViewCell class]]) {
        
        [view ls_addSubviews];
    }
    
    if (view && [view respondsToSelector:@selector(ls_layoutSubviews)] && ![view isKindOfClass:[UITableViewCell class]]) {
        
        [view ls_layoutSubviews];
    }
    
    if (view && [view respondsToSelector:@selector(ls_bindViewModel)] && ![view isKindOfClass:[UITableViewCell class]]) {
        
        [view ls_bindViewModel];
    }
}

- (void)viewInit:(UIView *)view {
    
    if ([view respondsToSelector:@selector(ls_getViewModel:)]) {
        
        return;
    }
    
    if (view && [view respondsToSelector:@selector(ls_initData)] && ![view isKindOfClass:[UITableViewCell class]]) {
        
        [view ls_initData];
    }
    
    if (view && [view respondsToSelector:@selector(ls_addSubviews)] && ![view isKindOfClass:[UITableViewCell class]]) {
        
        [view ls_addSubviews];
    }
    
    if (view && [view respondsToSelector:@selector(ls_layoutSubviews)] && ![view isKindOfClass:[UITableViewCell class]]) {
        
        [view ls_layoutSubviews];
    }
    
    if (view && [view respondsToSelector:@selector(ls_bindViewModel)] && ![view isKindOfClass:[UITableViewCell class]]) {
        
        [view ls_bindViewModel];
    }
}

- (void)tableViewCellInit:(UITableViewCell *)view {
    
    view.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (view && [view respondsToSelector:@selector(ls_initData)] && [view isKindOfClass:[UITableViewCell class]]) {
        
        [view ls_initData];
    }
    
    if (view && [view respondsToSelector:@selector(ls_addSubviews)] && [view isKindOfClass:[UITableViewCell class]]) {
        
        [view ls_addSubviews];
    }
    
    if (view && [view respondsToSelector:@selector(ls_layoutSubviews)] && [view isKindOfClass:[UITableViewCell class]]) {
        
        [view ls_layoutSubviews];
    }
    
    if (view && [view respondsToSelector:@selector(ls_bindViewModel)] && [view isKindOfClass:[UITableViewCell class]]) {
        
        [view ls_bindViewModel];
    }
}


@end
