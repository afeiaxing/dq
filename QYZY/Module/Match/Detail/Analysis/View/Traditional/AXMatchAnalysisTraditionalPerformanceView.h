//
//  AXMatchAnalysisTraditionalPerformanceView.h
//  QYZY
//
//  Created by 22 on 2024/5/19.
//

#import <UIKit/UIKit.h>
#import "AXMatchAnalysisRivalryRecordModel.h"
#import "AXMatchAnalysisTeamRecordModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AXMatchAnalysisTraditionalPerformanceView : UIView

// 两队历史交锋数据
@property (nonatomic, strong) AXMatchAnalysisRivalryRecordModel *rivalryRecordModel;

// 主队 / 客队 数据
@property (nonatomic, strong) AXMatchAnalysisTeamRecordModel *teamRecordModel;

@property (nonatomic, assign) BOOL isHost;
@property (nonatomic, assign) BOOL isRequest10;

@end

NS_ASSUME_NONNULL_END
