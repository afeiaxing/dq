//
//  AXMatchAnalysisAdvancedModel.h
//  QYZY
//
//  Created by 22 on 2024/6/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AXMatchAnalysisAdvancedStatsModel : NSObject

@property (nonatomic, strong) NSString *awayScore;
@property (nonatomic, strong) NSString *homeScore;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *subtitle;

@end

@interface AXMatchAnalysisAdvancedAlAveModel : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *score;

@end

@interface AXMatchAnalysisAdvancedModel : NSObject

@property (nonatomic, strong)NSArray <AXMatchAnalysisAdvancedAlAveModel *> *awayAl;
@property (nonatomic, strong)NSArray <AXMatchAnalysisAdvancedAlAveModel *> *awayAve;
@property (nonatomic, strong)NSArray <AXMatchAnalysisAdvancedAlAveModel *> *homeAl;
@property (nonatomic, strong)NSArray <AXMatchAnalysisAdvancedAlAveModel *> *homeAve;
@property (nonatomic, strong)NSArray <AXMatchAnalysisAdvancedStatsModel *> *teamStatistics;

@end

NS_ASSUME_NONNULL_END
