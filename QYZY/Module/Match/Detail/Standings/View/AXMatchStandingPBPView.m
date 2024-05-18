//
//  AXMatchStandingPBPView.m
//  QYZY
//
//  Created by 22 on 2024/5/18.
//

#import "AXMatchStandingPBPView.h"
#import "AXMatchStandingPBPSubCell.h"

@interface AXMatchStandingPBPView()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *quarters;
@property (nonatomic, strong) NSArray *quarterTitleBtns;
@property (nonatomic, strong) UIButton *lastSelectedBtn;

@property (nonatomic, strong) UITableView *tableview;

@end

#define AXMatchStandingPBPBtnNormalColor rgb(130, 134, 163)

@implementation AXMatchStandingPBPView

// MARK: lifecycle
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame: frame]) {
        [self setupSubviews];
    }
    return self;
}

// MARK: private
- (void)setupSubviews{
    NSMutableArray *btns = [NSMutableArray array];
    for (int i = 0; i < self.quarters.count; i++) {
        NSString *title = self.quarters[i];
        UIButton *btn = [UIButton new];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:i == 0 ? AXSelectColor : AXMatchStandingPBPBtnNormalColor forState:UIControlStateNormal];
        btn.backgroundColor = i == 0 ? rgb(255, 247, 239) : UIColor.whiteColor;
        btn.layer.cornerRadius = 15;
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.tag = i;
        [btn addTarget:self action:@selector(handleBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [btns addObject:btn];
    }
    self.lastSelectedBtn = btns.firstObject;

    [btns mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:48 leadSpacing:55 tailSpacing:55];
    [btns mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.height.mas_equalTo(30);
    }];
    
    [self addSubview:self.tableview];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.top.equalTo(self.lastSelectedBtn.mas_bottom).offset(24);
    }];
}

- (void)handleBtnEvent: (UIButton *)sender{
    [self.lastSelectedBtn setTitleColor:AXMatchStandingPBPBtnNormalColor forState:UIControlStateNormal];
    self.lastSelectedBtn.backgroundColor = UIColor.whiteColor;
    [sender setTitleColor:AXSelectColor forState:UIControlStateNormal];
    sender.backgroundColor = rgb(255, 247, 239);
    self.lastSelectedBtn = sender;
    // reload data
    NSLog(@"%ld", sender.tag);
}

// MARK: UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 53;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AXMatchStandingPBPSubCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(AXMatchStandingPBPSubCell.class) forIndexPath:indexPath];
    cell.index = indexPath.row;
    return cell;
}

// MARK: JXCategoryListContentViewDelegate
- (UIView *)listView {
    return self;
}

// MARK: setter & getter
- (NSArray *)quarters{
    return @[@"Q1", @"Q2", @"Q3", @"Q4", @"OT2", @"OT2"];
}

- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [UITableView new];
        [_tableview registerClass:AXMatchStandingPBPSubCell.class forCellReuseIdentifier:NSStringFromClass(AXMatchStandingPBPSubCell.class)];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.delegate = self;
        _tableview.dataSource = self;
        return _tableview;
    }
    return _tableview;
}

@end
