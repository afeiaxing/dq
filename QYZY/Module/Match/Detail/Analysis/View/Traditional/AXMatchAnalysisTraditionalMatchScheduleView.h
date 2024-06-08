//
//  AXMatchAnalysisTraditionalMatchScheduleView.h
//  QYZY
//
//  Created by 22 on 2024/5/19.
//

#import <UIKit/UIKit.h>
#import "AXMatchAnalysisTeamRecordModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, AXMatchAnalysisTraditionalMatchViewType) {
    AXMatchAnalysisTraditionalMatchViewType_all,
    AXMatchAnalysisTraditionalMatchViewType_host,
    AXMatchAnalysisTraditionalMatchViewType_away
};

@interface AXMatchAnalysisTraditionalMatchScheduleView : UIView

@property (nonatomic, assign) AXMatchAnalysisTraditionalMatchViewType viewType;
@property (nonatomic, strong) NSArray <AXMatchAnalysisTeamRecordItemModel *>*scheduleMatchs;

@end

NS_ASSUME_NONNULL_END
