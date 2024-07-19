//
//  AXMatchLineupModel.h
//  QYZY
//
//  Created by 22 on 2024/6/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AXMatchLineupTopPerformerModel : NSObject

@property (nonatomic, strong) NSString *playerName;
@property (nonatomic, strong) NSString *playerLogo;
@property (nonatomic, strong) NSString *shirtNumber;
@property (nonatomic, strong) NSString *score;

@end

@interface AXMatchLineupStatsModel : NSObject

@property (nonatomic, strong) NSString *playerName;
@property (nonatomic, strong) NSString *shirtNumber;
@property (nonatomic, strong) NSString *started;
@property (nonatomic, strong) NSString *min;
@property (nonatomic, strong) NSString *pts;
@property (nonatomic, strong) NSString *reb;
@property (nonatomic, strong) NSString *ast;
@property (nonatomic, strong) NSString *fg;
@property (nonatomic, strong) NSString *threePt;
@property (nonatomic, strong) NSString *ft;
@property (nonatomic, strong) NSString *oreb;
@property (nonatomic, strong) NSString *dreb;
@property (nonatomic, strong) NSString *stl;
@property (nonatomic, strong) NSString *blk;
@property (nonatomic, strong) NSString *tov;
@property (nonatomic, strong) NSString *pf;

@end

@interface AXMatchLineupModel : NSObject

@property (nonatomic, strong) AXMatchLineupTopPerformerModel *hostTop1Mpdel;
@property (nonatomic, strong) AXMatchLineupTopPerformerModel *hostTop2Mpdel;
@property (nonatomic, strong) AXMatchLineupTopPerformerModel *hostTop3Mpdel;
@property (nonatomic, strong) AXMatchLineupTopPerformerModel *awayTop1Mpdel;
@property (nonatomic, strong) AXMatchLineupTopPerformerModel *awayTop2Mpdel;
@property (nonatomic, strong) AXMatchLineupTopPerformerModel *awayTop3Mpdel;
@property (nonatomic, strong) NSArray <AXMatchLineupStatsModel *>*homePlayerStats;
@property (nonatomic, strong) NSArray <AXMatchLineupStatsModel *>*awayPlayerStats;

@end

NS_ASSUME_NONNULL_END
