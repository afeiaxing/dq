//
//  AXMatchListSettingCell.m
//  QYZY
//
//  Created by 22 on 2024/5/19.
//

#import "AXMatchListSettingCell.h"

@interface AXMatchListSettingCell()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation AXMatchListSettingCell

// MARK: lifecycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self setupSubviews];
    }
    return self;
}

// MARK: delegate

// MARK: private
- (void)setupSubviews{
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
            [self.contentView addSubview:_titleLabel];
    self.titleLabel.frame = CGRectMake(15, 0, self.contentView.bounds.size.width - 30, self.contentView.bounds.size.height);
}

// MARK: setter & getter
- (void)setTitle:(NSString *)title{
    self.titleLabel.text = title;
}

@end
