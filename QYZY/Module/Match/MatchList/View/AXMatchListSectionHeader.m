//
//  AXMatchListSectionHeader.m
//  QYZY
//
//  Created by 22 on 2024/5/16.
//

#import "AXMatchListSectionHeader.h"

@interface AXMatchListSectionHeader()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation AXMatchListSectionHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]){
        self.contentView.backgroundColor = rgb(234, 241, 245);
        
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(16);
            make.centerY.offset(0);
        }];
    }
    return self;
}

- (void)setTitleString:(NSString *)titleString{
    self.titleLabel.text = titleString;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = rgb(153, 153, 153);
    }
    return _titleLabel;
}

@end
