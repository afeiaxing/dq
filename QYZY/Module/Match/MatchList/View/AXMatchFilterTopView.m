//
//  AXMatchFilterTopView.m
//  QYZY
//
//  Created by 22 on 2024/6/3.
//

#import "AXMatchFilterTopView.h"

@interface AXMatchFilterTopView()



@end

@implementation AXMatchFilterTopView

// MARK: lifecycle
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
    }
    return self;
}

// MARK: delegate

// MARK: private
- (void)setupSubviews{
    NSArray *dataSource = @[@"ALL", @"HOT", @"NBA", @"PBA"];
    CGFloat leftMargin = 16;
    
    NSMutableArray *btns = [NSMutableArray array];
    for (int i = 0; i < dataSource.count; i++) {
        UIButton *btn = [UIButton new];
        [self addSubview:btn];
        btn.backgroundColor = UIColor.purpleColor;
        [btns addObject:btn];
    }
    
    [btns mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:80 leadSpacing:leftMargin tailSpacing:leftMargin];
    [btns mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(30);
        make.centerY.offset(0);
    }];
}

// MARK: setter & getter

@end
