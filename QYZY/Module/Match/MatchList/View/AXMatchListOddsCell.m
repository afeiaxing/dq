//
//  AXMatchListOddsCell.m
//  QYZY
//
//  Created by Archer on 5/16/24.
//

#import "AXMatchListOddsCell.h"

@interface AXMatchListOddsCell()

@property (weak, nonatomic) IBOutlet UIImageView *leagueLogo;
@property (weak, nonatomic) IBOutlet UILabel *leagueName;
@property (weak, nonatomic) IBOutlet UIImageView *hostLogo;
@property (weak, nonatomic) IBOutlet UIImageView *awayLogo;
@property (weak, nonatomic) IBOutlet UILabel *hostName;
@property (weak, nonatomic) IBOutlet UILabel *awayName;

@property (weak, nonatomic) IBOutlet UILabel *matchTime;
@property (weak, nonatomic) IBOutlet UILabel *matchState;

@property (weak, nonatomic) IBOutlet UILabel *topHandicap;
@property (weak, nonatomic) IBOutlet UILabel *bottomHandicap;
//
//@property (weak, nonatomic) IBOutlet UIView *apLogo;
@property (weak, nonatomic) IBOutlet UILabel *handicapTitle;
@property (weak, nonatomic) IBOutlet UILabel *hostHandicap;
@property (weak, nonatomic) IBOutlet UILabel *awayHandicap;

@property (weak, nonatomic) IBOutlet UILabel *ouTitle;
@property (weak, nonatomic) IBOutlet UILabel *oLabel;
@property (weak, nonatomic) IBOutlet UILabel *uLabel;

@property (weak, nonatomic) IBOutlet UILabel *moneylineTitle;
@property (weak, nonatomic) IBOutlet UILabel *hostMoneyline;
@property (weak, nonatomic) IBOutlet UILabel *awayMoneyline;

@property (weak, nonatomic) IBOutlet UIView *apLogo;

@end

@implementation AXMatchListOddsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



@end
