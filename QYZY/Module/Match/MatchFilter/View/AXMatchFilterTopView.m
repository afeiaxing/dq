//
//  AXMatchFilterTopView.m
//  QYZY
//
//  Created by 22 on 2024/6/3.
//

#import "AXMatchFilterTopView.h"

@interface AXMatchFilterTopView()

@property (nonatomic, strong) UIButton *lastSelectedBtn;

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
//    NSArray *dataSource = @[@"ALL", @"HOT", @"NBA", @"PBA"];
    NSArray *dataSource = @[@"ALL", @"NBA", @"PBA"];
    CGFloat leftMargin = 16;
    
    NSMutableArray *btns = [NSMutableArray array];
    for (int i = 0; i < dataSource.count; i++) {
        UIButton *btn = [UIButton new];
        [self addSubview:btn];
        [btn setTitle:dataSource[i] forState:UIControlStateNormal];
        [btn setTitleColor:AXUnSelectColor forState:UIControlStateNormal];
        [btn setTitleColor:AXSelectColor forState:UIControlStateSelected];
        [btn setTitleColor:AXSelectColor forState:UIControlStateHighlighted];
        [btn setImage:[UIImage imageNamed:@"matchlist_filter_icon1"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"matchlist_filter_icon2"] forState:UIControlStateSelected];
        [btn setImage:[UIImage imageNamed:@"matchlist_filter_icon2"] forState:UIControlStateHighlighted];
        btn.titleLabel.font = AX_PingFangMedium_Font(14);
        btn.layer.borderColor = i == 0 ? AXSelectColor.CGColor : rgb(234, 241, 245).CGColor;
        btn.layer.borderWidth = 1;
        btn.layer.cornerRadius = 15;
        btn.selected = i == 0;
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5);
        btn.backgroundColor = i == 0 ? rgba(255, 88, 0, 0.05) : UIColor.whiteColor;
        [btn addTarget:self action:@selector(handleBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        [btns addObject:btn];
    }
    
    [btns mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:80 leadSpacing:leftMargin tailSpacing:leftMargin];
    [btns mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(30);
        make.centerY.offset(0);
    }];
    
    self.lastSelectedBtn = btns.firstObject;
}

- (void)handleBtnEvent: (UIButton *)btn{
    if (btn == self.lastSelectedBtn) {return;}
    
    btn.backgroundColor = rgba(255, 88, 0, 0.05);
    btn.layer.borderColor = AXSelectColor.CGColor;
    btn.selected = true;
    
    self.lastSelectedBtn.backgroundColor = UIColor.whiteColor;
    self.lastSelectedBtn.layer.borderColor = rgb(234, 241, 245).CGColor;
    self.lastSelectedBtn.selected = false;
    
    self.lastSelectedBtn = btn;
    
    !self.block ? : self.block((int)btn.tag);
}

// MARK: setter & getter

@end
