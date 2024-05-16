//
//  QYZYDataTools.h
//  QYZY
//
//  Created by 11 on 5/14/24.
//

#import <Foundation/Foundation.h>
#import "QYZYMatchModel.h"
#import "QYZYMatchAnalyzeRankModel.h"
#import "QYZYMatchMainModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface QYZYDataTools : NSObject

+ (QYZYSubMatchModel *)getQYZYSubMatchModel;

+ (QYZYMatchAnalyzeRankModel *)getQYZYMatchAnalyzeRankModel;

+ (NSArray <QYZYMatchMainModel *>*)getQYZYMatchMainModels;

@end

NS_ASSUME_NONNULL_END
