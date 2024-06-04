//
//  AXMatchListSettingCell.h
//  QYZY
//
//  Created by 22 on 2024/5/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, SettingType) {
    SettingTypeSwitch,
    SettingTypeArrow
};

@interface AXMatchListSettingCell : UITableViewCell

@property (nonatomic, strong) NSString *title;

@end

NS_ASSUME_NONNULL_END
