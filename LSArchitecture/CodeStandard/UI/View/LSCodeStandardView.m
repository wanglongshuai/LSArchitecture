//
//  LSCodeStandardView.m
//  LSArchitecture
//
//  Created by 王隆帅 on 17/3/2.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "LSCodeStandardView.h"
#import "LSCodeStandardCell.h"
#import "LSCodeStandardViewModel.h"

@interface LSCodeStandardView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) LSCodeStandardViewModel *viewModel;

@end

@implementation LSCodeStandardView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - general
- (void)ls_initData {
    
}

- (void)ls_addSubviews {
    
    [self addSubview:self.mainTableView];
}

- (void)ls_layoutSubviews {
    
    WS(weakSelf);
    
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.right.bottom.equalTo(weakSelf);
    }];
}

- (void)ls_bindViewModel {
    
    @weakify(self);
    
    [self.viewModel.refreshSubject subscribeNext:^(id x) {
        
        @strongify(self);
        [self.mainTableView reloadData];
    }];
}

#pragma mark - delegate

#pragma mark - LSVMUIBridgeProtocol
- (void)ls_getViewModel:(id<LSViewModelProtocol>)viewModel {
    
    _viewModel = (LSCodeStandardViewModel *)viewModel;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.viewModel.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    LSCodeStandardCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([LSCodeStandardCell class])] forIndexPath:indexPath];
    cell.viewModel = self.viewModel.dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 120;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

#pragma mark - lazyLoad
- (UITableView *)mainTableView {

    if (!_mainTableView) {
        
        _mainTableView = [[UITableView alloc] init];
        _mainTableView.dataSource = self;
        _mainTableView.delegate = self;
        [_mainTableView registerClass:[LSCodeStandardCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([LSCodeStandardCell class])]];
    }
    
    return _mainTableView;
}

@end
