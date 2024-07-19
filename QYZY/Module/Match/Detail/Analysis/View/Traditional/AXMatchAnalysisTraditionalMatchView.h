//
//  AXMatchAnalysisTraditionalMatchView.h
//  QYZY
//
//  Created by 22 on 2024/5/18.
//

#import <UIKit/UIKit.h>
#import "AXMatchAnalysisTraditionalMatchScheduleView.h"
#import "AXMatchAnalysisRivalryRecordModel.h"
#import "AXMatchAnalysisTeamRecordModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AXMatchAnalysisTraditionalMatchView : UIView<JXCategoryListContentViewDelegate>

@property (nonatomic, assign) AXMatchAnalysisTraditionalMatchViewType viewType;
@property (nonatomic, strong) AXMatchListItemModel *matchModel;
@property (nonatomic, strong) AXMatchAnalysisRivalryRecordModel *rivalryRecordModel;
@property (nonatomic, strong) AXMatchAnalysisTeamRecordModel *teamRecordModel;
@property (nonatomic, assign) BOOL isHost;
@property (nonatomic, assign) BOOL isRequest10;

@end

NS_ASSUME_NONNULL_END
