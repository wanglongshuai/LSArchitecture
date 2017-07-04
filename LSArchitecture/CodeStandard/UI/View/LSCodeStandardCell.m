//
//  LSCodeStandardCell.m
//  LSArchitecture
//
//  Created by 王隆帅 on 2017/3/24.
//  Copyright © 2017年 王隆帅. All rights reserved.
//

#import "LSCodeStandardCell.h"

@interface LSCodeStandardCell () <LSCodeStandardItemObserver>

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *mainImageView;

@end

@implementation LSCodeStandardCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - general
- (void)ls_addSubviews {
    
    [self.contentView addSubview:self.mainImageView];
    [self.contentView addSubview:self.titleLabel];
}

- (void)ls_layoutSubviews {

    WS(weakSelf);
    
    [self.mainImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(10);
        make.centerY.equalTo(weakSelf.contentView);
        make.size.equalTo(CGSizeMake(100, 100));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakSelf.mainImageView.mas_right).offset(20);
        make.centerY.equalTo(weakSelf.contentView);
        make.right.equalTo(-20);
        make.height.equalTo(30);
    }];
}

#pragma mark - updateData
- (void)setViewModel:(LSCodeStandardCellViewModel *)viewModel {
    
    _viewModel = viewModel;
    
    self.titleLabel.text = _viewModel.item.codeStandardInfo.title;
    [self.mainImageView sd_setImageWithURL:[NSURL URLWithString:_viewModel.item.codeStandardInfo.image]];
    [self updateUI:_viewModel.item];
}

- (void)updateUI:(LSCodeStandardItem *)item {
    
    [item removeObserver:self];
    [item addObserver:self];
    
    self.contentView.backgroundColor = item.codeStandardInfo.bgColor;
}

#pragma mark - LSCodeStandardItemObserver
- (void)codeStandardItemDataChange:(LSCodeStandardItem *)item {

    [self updateUI:item];
}

#pragma mark - lazyload
- (UILabel *)titleLabel {

    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
    }
    
    return _titleLabel;
}

- (UIImageView *)mainImageView {

    if (!_mainImageView) {
        
        _mainImageView = [[UIImageView alloc] init];
        _mainImageView.backgroundColor = [UIColor redColor];
    }
    
    return _mainImageView;
}

@end
