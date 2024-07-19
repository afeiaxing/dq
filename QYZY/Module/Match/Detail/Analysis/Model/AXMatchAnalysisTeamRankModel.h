//
//  AXMatchAnalysisTeamRankModel.h
//  QYZY
//
//  Created by 22 on 2024/6/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AXMatchAnalysisTeamRankModel : NSObject

@property (nonatomic, strong) NSString *ranking;
@property (nonatomic, strong) NSString *teamName;
@property (nonatomic, strong) NSString *wl;
@property (nonatomic, strong) NSString *wp;
@property (nonatomic, strong) NSNumber *ave;
@property (nonatomic, strong) NSNumber *al;
@property (nonatomic, strong) NSString *status;

@end

NS_ASSUME_NONNULL_END
