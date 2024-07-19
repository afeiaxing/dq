//
//  AXMatchListFilterCell.m
//  QYZY
//
//  Created by 22 on 2024/6/3.
//

#import "AXMatchListFilterCell.h"

@interface AXMatchListFilterCell()

@property (nonatomic, strong) UIButton *selectedBtn;
@property (nonatomic, strong) UILabel *leagueNameLabel;
@property (nonatomic, strong) UILabel *matchCountLabel;
@property (nonatomic, strong) UIView *line;

@end

@implementation AXMatchListFilterCell

// MARK: lifecycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupSubviews];
    }
    return self;
}

// MARK: delegate

// MARK: private
- (void)setupSubviews{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.selectedBtn];
    [self.selectedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(16);
        make.centerY.offset(0);
        make.size.mas_equalTo(CGSizeMake(16, 16));
    }];
    
    [self.contentView addSubview:self.leagueNameLabel];
    [self.leagueNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.selectedBtn.mas_right).offset(9);
        make.centerY.offset(0);
    }];
    
    [self.contentView addSubview:self.matchCountLabel];
    [self.matchCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-16);
        make.centerY.offset(0);
    }];
    
    [self.contentView addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.height.mas_equalTo(1);
    }];
}

- (void)handleBtnEvent: (UIButton *)btn{
    btn.selected = !btn.selected;
    self.model.isSelected = !self.model.isSelected;
    !self.block ? : self.block(btn.selected, self.model.items.intValue);
}

// MARK: setter & getter
- (void)setModel:(AXMatchFilterItenModel *)model{
    self.leagueNameLabel.text = model.shortName;
    self.matchCountLabel.text = model.items;
    self.selectedBtn.selected = model.isSelected;
    _model = model;
}

- (UIButton *)selectedBtn{
    if (!_selectedBtn) {
        _selectedBtn = [UIButton new];
        [_selectedBtn setImage:[UIImage imageNamed:@"matchlist_filter_icon3"] forState:UIControlStateNormal];
        [_selectedBtn setImage:[UIImage imageNamed:@"matchlist_filter_icon4"] forState:UIControlStateSelected];
        [_selectedBtn addTarget:self action:@selector(handleBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectedBtn;
}

- (UILabel *)leagueNameLabel{
    if (!_leagueNameLabel) {
        _leagueNameLabel = [UILabel new];
        _leagueNameLabel.font = AX_PingFangMedium_Font(14);
    }
    return _leagueNameLabel;
}

- (UILabel *)matchCountLabel{
    if (!_matchCountLabel) {
        _matchCountLabel = [UILabel new];
        _matchCountLabel.font = AX_PingFangMedium_Font(16);
        _matchCountLabel.textColor = rgb(130, 134, 163);
    }
    return _matchCountLabel;
}

- (UIView *)line{
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = rgb(234, 241, 245);
    }
    return _line;
}

@end
