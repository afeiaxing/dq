//
//  AXMatchStandingPolylineView.h
//  QYZY
//
//  Created by 22 on 2024/5/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AXMatchStandingPolylineView : UIView

@property (nonatomic, strong) AXMatchListItemModel *matchModel;
@property (nonatomic, strong) NSArray *scoreDiffs;

@end

NS_ASSUME_NONNULL_END
