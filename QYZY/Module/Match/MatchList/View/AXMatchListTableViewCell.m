//
//  AXMatchListTableViewCell.m
//  QYZY
//
//  Created by 22 on 2024/5/15.
//

#import "AXMatchListTableViewCell.h"

@interface AXMatchListTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *leagueLogo;
@property (weak, nonatomic) IBOutlet UILabel *leagueName;
@property (weak, nonatomic) IBOutlet UIImageView *hostLogo;
@property (weak, nonatomic) IBOutlet UIImageView *awayLogo;
@property (weak, nonatomic) IBOutlet UILabel *hostName;
@property (weak, nonatomic) IBOutlet UILabel *awayName;
@property (weak, nonatomic) IBOutlet UILabel *matchTime;
@property (weak, nonatomic) IBOutlet UILabel *matchState;

@property (weak, nonatomic) IBOutlet UILabel *q1Title;
@property (weak, nonatomic) IBOutlet UILabel *q2Title;
@property (weak, nonatomic) IBOutlet UILabel *q3Title;
@property (weak, nonatomic) IBOutlet UILabel *q4Title;
@property (weak, nonatomic) IBOutlet UILabel *ot1Title;
@property (weak, nonatomic) IBOutlet UILabel *ot2Title;
@property (weak, nonatomic) IBOutlet UILabel *totalScoreTitle;

@property (weak, nonatomic) IBOutlet UILabel *hostQ1Score;
@property (weak, nonatomic) IBOutlet UILabel *hostQ2Score;
@property (weak, nonatomic) IBOutlet UILabel *hostQ3Score;
@property (weak, nonatomic) IBOutlet UILabel *hostQ4Score;
@property (weak, nonatomic) IBOutlet UILabel *hostOT1Score;
@property (weak, nonatomic) IBOutlet UILabel *hostOT2Score;
@property (weak, nonatomic) IBOutlet UILabel *hostTotalScore;
@property (weak, nonatomic) IBOutlet UILabel *awayQ1Score;
@property (weak, nonatomic) IBOutlet UILabel *awayQ2Score;
@property (weak, nonatomic) IBOutlet UILabel *awayQ3Score;
@property (weak, nonatomic) IBOutlet UILabel *awayQ4Score;
@property (weak, nonatomic) IBOutlet UILabel *awayOT1Score;
@property (weak, nonatomic) IBOutlet UILabel *awayOT2Score;
@property (weak, nonatomic) IBOutlet UILabel *awayTotalScore;
@property (weak, nonatomic) IBOutlet UILabel *topHandicap;
@property (weak, nonatomic) IBOutlet UILabel *bottomHandicap;

@property (weak, nonatomic) IBOutlet UIView *apLogo;

@end

@implementation AXMatchListTableViewCell

// MARK: lifecycle
- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self setupSubviews];
}

// MARK: private
- (void)setupSubviews{
    
}

- (void)handleLabelHidden: (NSArray <UILabel *>*)labels hide: (BOOL)hide{
    for (UILabel *label in labels) {
        label.hidden = hide;
    }
}

- (void)handleLabelText:(NSArray <UILabel *>*)labels text: (NSString *)text{
    for (UILabel *label in labels) {
        label.text = text;
    }
}

- (void)handleLayoutWithLabels:(NSArray <UILabel *> *)labels{
    // TODO: 设置约束
    [labels mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:30 leadSpacing:12 tailSpacing:12];
    [labels mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
//        make.height.equalTo(80);
    }];
}

// MARK: setter & getter
- (void)setIndexrow:(NSInteger)indexrow{
    BOOL isQ1 = indexrow == 0;  // 0 -> 第一节
    BOOL isQ2 = indexrow == 1;  // 1 -> 第二节
    BOOL isQ3 = indexrow == 2;  // 2 -> 第三节
    BOOL isQ4 = indexrow == 3;  // 3 -> 第四节
    BOOL isOT1 = indexrow == 4;  // 4 -> 加时1
    BOOL isOT2 = indexrow == 5;  // 5 -> 加时2
    BOOL isOT3 = indexrow == 6;  // 6 -> 加时3
    BOOL isResult = indexrow == 7;  // 7 -> 结束
    BOOL isUpcoming = indexrow > 7;  // >7 -> 未开赛
    
    if (isQ1) {
        [self handleLabelHidden:@[self.ot1Title, self.ot2Title, self.hostOT1Score, self.hostOT2Score, self.awayOT1Score, self.awayOT2Score] hide:true];
        [self handleLabelText:@[self.hostQ1Score] text:@"22"];
        [self handleLabelText:@[self.awayQ1Score] text:@"33"];
        [self handleLabelText:@[self.hostQ2Score, self.hostQ3Score, self.hostQ4Score, self.awayQ2Score, self.awayQ3Score, self.awayQ4Score] text:@"-"];
    } else if (isQ2) {
        [self handleLabelHidden:@[self.ot1Title, self.ot2Title, self.hostOT1Score, self.hostOT2Score, self.awayOT1Score, self.awayOT2Score] hide:true];
        [self handleLabelText:@[self.hostQ1Score, self.hostQ2Score] text:@"22"];
        [self handleLabelText:@[self.awayQ1Score, self.awayQ2Score] text:@"33"];
        [self handleLabelText:@[self.hostQ3Score, self.awayQ4Score, self.awayQ3Score, self.awayQ4Score] text:@"-"];
    } else if (isQ3) {
        [self handleLabelHidden:@[self.ot1Title, self.ot2Title, self.hostOT1Score, self.hostOT2Score, self.awayOT1Score, self.awayOT2Score] hide:true];
        [self handleLabelText:@[self.hostQ1Score, self.hostQ2Score, self.hostQ3Score] text:@"22"];
        [self handleLabelText:@[self.awayQ1Score, self.awayQ2Score, self.awayQ3Score] text:@"33"];
        [self handleLabelText:@[self.awayQ4Score, self.awayQ4Score] text:@"-"];
    } else if (isQ4) {
        [self handleLabelHidden:@[self.ot1Title, self.ot2Title, self.hostOT1Score, self.hostOT2Score, self.awayOT1Score, self.awayOT2Score] hide:true];
        [self handleLabelText:@[self.hostQ1Score, self.hostQ2Score, self.hostQ3Score, self.hostQ4Score] text:@"22"];
        [self handleLabelText:@[self.awayQ1Score, self.awayQ2Score, self.awayQ3Score, self.awayQ4Score] text:@"33"];
    } else if (isOT1) {
        [self handleLabelHidden:@[self.ot2Title, self.hostOT2Score, self.awayOT2Score] hide:true];
        [self handleLabelHidden:@[self.ot1Title, self.hostOT1Score, self.awayOT1Score] hide:false];
        [self handleLabelText:@[self.hostQ1Score, self.hostQ2Score, self.hostQ3Score, self.hostQ4Score, self.hostOT1Score] text:@"22"];
        [self handleLabelText:@[self.awayQ1Score, self.awayQ2Score, self.awayQ3Score, self.awayQ4Score, self.awayOT1Score] text:@"33"];
    } else if (isOT2) {
        [self handleLabelHidden:@[self.ot2Title, self.hostOT2Score, self.awayOT2Score] hide:false];
        [self handleLabelHidden:@[self.ot1Title, self.hostOT1Score, self.awayOT1Score] hide:false];
        [self handleLabelText:@[self.hostQ1Score, self.hostQ2Score, self.hostQ3Score, self.hostQ4Score, self.hostOT1Score, self.hostOT2Score] text:@"22"];
        [self handleLabelText:@[self.awayQ1Score, self.awayQ2Score, self.awayQ3Score, self.awayQ4Score, self.awayOT1Score, self.awayOT2Score] text:@"33"];
    } else if (isOT3) {
        [self handleLabelHidden:@[self.ot2Title, self.hostOT2Score, self.awayOT2Score] hide:false];
        [self handleLabelHidden:@[self.ot1Title, self.hostOT1Score, self.awayOT1Score] hide:false];
        [self handleLabelText:@[self.hostQ1Score, self.hostQ2Score, self.hostQ3Score, self.hostQ4Score, self.hostOT1Score, self.hostOT2Score] text:@"44"];
        [self handleLabelText:@[self.awayQ1Score, self.awayQ2Score, self.awayQ3Score, self.awayQ4Score, self.awayOT1Score, self.awayOT2Score] text:@"55"];
    } else if (isResult) {
        [self handleLabelHidden:@[self.ot2Title, self.hostOT2Score, self.awayOT2Score] hide:false];
        [self handleLabelHidden:@[self.ot1Title, self.hostOT1Score, self.awayOT1Score] hide:false];
        [self handleLabelText:@[self.hostQ1Score, self.hostQ2Score, self.hostQ3Score, self.hostQ4Score, self.hostOT1Score, self.hostOT2Score] text:@"44"];
        [self handleLabelText:@[self.awayQ1Score, self.awayQ2Score, self.awayQ3Score, self.awayQ4Score, self.awayOT1Score, self.awayOT2Score] text:@"55"];
    } else  {
        [self handleLabelHidden:@[self.q4Title, self.hostQ4Score, self.awayQ4Score, self.ot1Title, self.hostOT1Score, self.awayQ1Score, self.ot2Title, self.hostOT2Score, self.awayOT2Score] hide:true];
        [self handleLabelText:@[self.q1Title] text:@"Handicap"];
        [self handleLabelText:@[self.hostQ1Score] text:@"6.5"];
        [self handleLabelText:@[self.awayQ1Score] text:@"-6.5"];
        
        [self handleLabelText:@[self.q2Title] text:@"O/U"];
        [self handleLabelText:@[self.hostQ2Score] text:@"O106.5"];
        [self handleLabelText:@[self.awayQ2Score] text:@"U106.5"];
        
        [self handleLabelText:@[self.q2Title] text:@"Moneyine"];
        [self handleLabelText:@[self.hostQ2Score] text:@"0.85"];
        [self handleLabelText:@[self.awayQ2Score] text:@"0.85"];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
