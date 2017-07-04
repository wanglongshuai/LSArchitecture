//
//  LSCodeStandardViewController.m
//  LSArchitecture
//
//  Created by 王隆帅 on 17/3/2.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "LSCodeStandardViewController.h"
#import "LSCodeStandardView.h"
#import "LSCodeStandardViewModel.h"

#import "LSGeneralNetService.h"

@interface LSCodeStandardViewController ()

@property (nonatomic, strong) LSCodeStandardView *codeStandardView;

@property (nonatomic, strong) LSCodeStandardViewModel *viewModel;

@end

@implementation LSCodeStandardViewController


#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - general
- (void)ls_initData {
    
    self.title = @"框架测试列表";
    [self.viewModel loadData];
}

- (void)ls_addSubviews {
    
    [self.view addSubview:self.codeStandardView];
}

- (void)ls_layoutSubviews {
    
    WS(weakSelf);
    
    [self.codeStandardView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.top.equalTo(weakSelf.view);
    }];
}

- (void)ls_bindViewModel {

}

#pragma mark - lazyLoad
- (LSCodeStandardView *)codeStandardView {

    if (!_codeStandardView) {
        
        _codeStandardView = [[LSCodeStandardView alloc] initWithViewModel:self.viewModel];
    }
    
    return _codeStandardView;
}

- (LSCodeStandardViewModel *)viewModel {

    if (!_viewModel) {
        
        _viewModel = [[LSCodeStandardViewModel alloc] init];
    }
    
    return _viewModel;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
