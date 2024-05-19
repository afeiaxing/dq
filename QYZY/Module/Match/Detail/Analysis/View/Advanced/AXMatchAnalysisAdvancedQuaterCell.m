//
//  AXMatchAnalysisAdvancedQuaterCell.m
//  QYZY
//
//  Created by 22 on 2024/5/19.
//

#import "AXMatchAnalysisAdvancedQuaterCell.h"

@interface AXMatchAnalysisAdvancedQuaterCell()

@property (nonatomic, strong) UIView *BgView;

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation AXMatchAnalysisAdvancedQuaterCell

// MARK: lifecycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setupSubviews];
    }
    return self;
}

// MARK: delegate

// MARK: private
- (void)setupSubviews{
    self.contentView.backgroundColor = rgb(247, 247, 247);
    
    [self.contentView addSubview:self.BgView];
    [self.BgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset(0);
        make.bottom.offset(-4);
    }];
    
    [self.BgView addSubview:self.titleLabel];
    [self.BgView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(22);
        make.left.offset(15);
    }];
    
}

// MARK: setter & getter
- (UIView *)BgView{
    if (!_BgView) {
        _BgView = [UIView new];
        _BgView.backgroundColor = UIColor.whiteColor;
    }
    return _BgView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = rgb(17, 17, 17);
        _titleLabel.text = @"Single Quarter";
    }
    return _titleLabel;
}

@end
