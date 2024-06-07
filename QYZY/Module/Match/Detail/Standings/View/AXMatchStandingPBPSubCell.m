//
//  AXMatchStandingPBPSubCell.m
//  QYZY
//
//  Created by 22 on 2024/5/18.
//

#import "AXMatchStandingPBPSubCell.h"

@interface AXMatchStandingPBPSubCell()

@property (nonatomic, strong) UIView *colorView;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *quarterLabel;
@property (nonatomic, strong) UILabel *teamLabel;
@property (nonatomic, strong) UILabel *currentScoreLabel;
@property (nonatomic, strong) UILabel *addScoreLabel;

@end

@implementation AXMatchStandingPBPSubCell

// MARK: lifecycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupSubviews];
    }
    return self;
}

// MARK: pravite
- (void)setupSubviews{
    [self.contentView addSubview:self.colorView];
    [self.colorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.offset(16);
        make.size.mas_equalTo(CGSizeMake(8, 37));
    }];
    
    [self.contentView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.colorView.mas_right).offset(8);
        make.top.equalTo(self.colorView).offset(2);
    }];
    
    [self.contentView addSubview:self.quarterLabel];
    [self.quarterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.timeLabel.mas_right).offset(16);
        make.centerY.equalTo(self.timeLabel);
    }];
    
    [self.contentView addSubview:self.teamLabel];
    [self.teamLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.timeLabel);
        make.bottom.equalTo(self.colorView).offset(-2);
    }];
    
    [self.contentView addSubview:self.currentScoreLabel];
    [self.currentScoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-16);
        make.centerY.equalTo(self.timeLabel);
    }];
    
    [self.contentView addSubview:self.addScoreLabel];
    [self.addScoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.currentScoreLabel);
        make.centerY.equalTo(self.teamLabel);
    }];
}

// MARK: setter & getter
- (void)setIndex:(NSInteger)index{
    self.colorView.backgroundColor = index %2 == 0 ? rgb(143, 0, 255) : rgb(0, 162, 36);
}

- (void)setModel:(AXMatchStandingTextLiveModel *)model{
    self.timeLabel.text = model.time;
    self.quarterLabel.text = model.stage;
    self.teamLabel.text = model.explain;
    self.currentScoreLabel.text = model.score;
    self.addScoreLabel.text = model.singleScore;
    _model = model;
}

- (UIView *)colorView{
    if (!_colorView) {
        _colorView = [UIView new];
        _colorView.layer.cornerRadius = 4;
        _colorView.layer.maskedCorners = kCALayerMinXMinYCorner | kCALayerMinXMaxYCorner;

    }
    return _colorView;
}

-(UILabel *)timeLabel {
   if (!_timeLabel) {
       _timeLabel = [[UILabel alloc] init];
       _timeLabel.font = [UIFont systemFontOfSize:14];
       _timeLabel.textColor = [UIColor blackColor];
   }
   return _timeLabel;
}

- (UILabel *)quarterLabel {
   if (!_quarterLabel) {
       _quarterLabel = [[UILabel alloc] init];
       _quarterLabel.font = [UIFont systemFontOfSize:14];
       _quarterLabel.textColor = AXUnSelectColor;
   }
   return _quarterLabel;
}

- (UILabel *)teamLabel {
   if (!_teamLabel) {
       _teamLabel = [[UILabel alloc] init];
       _teamLabel.font = [UIFont systemFontOfSize:14];
       _teamLabel.textColor = [UIColor blackColor];
   }
   return _teamLabel;
}

- (UILabel *)currentScoreLabel {
   if (!_currentScoreLabel) {
       _currentScoreLabel = [[UILabel alloc] init];
       _currentScoreLabel.font = [UIFont systemFontOfSize:14];
       _currentScoreLabel.textColor = [UIColor blackColor];
   }
   return _currentScoreLabel;
}

- (UILabel *)addScoreLabel {
   if (!_addScoreLabel) {
       _addScoreLabel = [[UILabel alloc] init];
       _addScoreLabel.font = [UIFont systemFontOfSize:14];
       _addScoreLabel.textColor = [UIColor blackColor];
   }
   return _addScoreLabel;
}


@end
