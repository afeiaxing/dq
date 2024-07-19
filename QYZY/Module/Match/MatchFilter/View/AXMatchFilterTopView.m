//
//  AXMatchFilterTopView.m
//  QYZY
//
//  Created by 22 on 2024/6/3.
//

#import "AXMatchFilterTopView.h"

@interface AXMatchFilterTopView()<UITextFieldDelegate>

@property (nonatomic, strong) UIButton *lastSelectedBtn;
@property (nonatomic, strong) UITextField *textfield;

@end

@implementation AXMatchFilterTopView

// MARK: lifecycle
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
    }
    return self;
}

// MARK: UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.textfield resignFirstResponder];
    return true;
}

// MARK: Notification
- (void)handleTextDidChange{
    NSString *text = self.textfield.text;
    !self.searchBlock ? : self.searchBlock(text);
}

// MARK: private
- (void)setupSubviews{
//    UIView *line1 = [UIView new];
//    line1.backgroundColor = rgb(234, 241, 245);
//    [self addSubview:line1];
//    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.offset(0);
//        make.height.mas_equalTo(1);
//    }];
//
//    [self addSubview:self.textfield];
//    [self.textfield mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.offset(16);
//        make.right.offset(-10);
//        make.top.equalTo(line1.mas_bottom).offset(9);
//        make.height.mas_equalTo(30);
//    }];
//
//    UIView *line2 = [UIView new];
//    line2.backgroundColor = rgb(234, 241, 245);
//    [self addSubview:line2];
//    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.offset(0);
//        make.top.equalTo(self.textfield.mas_bottom).offset(9);
//        make.height.mas_equalTo(1);
//    }];
//    [self.textfield addTarget:self action:@selector(handleTextDidChange) forControlEvents:UIControlEventEditingChanged];

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
//        make.top.equalTo(line2.mas_bottom).offset(9);
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
- (UITextField *)textfield{
    if (!_textfield) {
        _textfield = [UITextField new];
        _textfield.placeholder = @"Search";
        _textfield.font = AX_PingFangMedium_Font(14);
        _textfield.layer.masksToBounds = true;
        _textfield.layer.cornerRadius = 15;
        _textfield.layer.borderColor = rgb(234, 241, 245).CGColor;
        _textfield.layer.borderWidth = 1;
        
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 34, 30)];
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(15, 8, 15, 15)];
        imageview.image = [UIImage imageNamed:@"match_list_filter_search"];
        [leftView addSubview:imageview];
        _textfield.leftView = leftView;
        _textfield.leftViewMode = UITextFieldViewModeAlways;
        
        _textfield.delegate = self;
    }
    return _textfield;
}

@end
