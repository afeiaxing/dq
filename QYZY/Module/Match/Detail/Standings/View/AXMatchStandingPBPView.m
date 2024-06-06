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
@property (nonatomic, strong) NSArray *textLives;
@property (nonatomic, assign) NSInteger selectIndex;

@property (nonatomic, strong) UITableView *tableview;

@end

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
        [btn setTitleColor:i == 0 ? AXSelectColor : AXUnSelectColor forState:UIControlStateNormal];
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
    [self.lastSelectedBtn setTitleColor:AXUnSelectColor forState:UIControlStateNormal];
    self.lastSelectedBtn.backgroundColor = UIColor.whiteColor;
    [sender setTitleColor:AXSelectColor forState:UIControlStateNormal];
    sender.backgroundColor = rgb(255, 247, 239);
    self.lastSelectedBtn = sender;
    NSLog(@"%ld", sender.tag);
    self.selectIndex = sender.tag;
    [self.tableview reloadData];
}

// MARK: UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.textLives.count;
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
- (void)setStandingModel:(AXMatchStandingModel *)standingModel{
    _standingModel = standingModel;
    
    NSMutableArray *q1 = [NSMutableArray array];
    NSMutableArray *q2 = [NSMutableArray array];
    NSMutableArray *q3 = [NSMutableArray array];
    NSMutableArray *q4 = [NSMutableArray array];
    NSMutableArray *ot = [NSMutableArray array];
    
    for (AXMatchStandingTextLiveModel *model in standingModel.tlive) {
        switch (model.stage.intValue) {
            case 1:
                [q1 addObject:model];
                break;
            case 2:
                [q2 addObject:model];
                break;
            case 3:
                [q3 addObject:model];
                break;
            case 4:
                [q4 addObject:model];
                break;
            case 5:
                [ot addObject:model];
                break;
                
            default:
                break;
        }
    }
    
    NSMutableArray *temp = [NSMutableArray array];
    
    if (q1.count) {
        [temp addObject:q1];
    }
    if (q2.count) {
        [temp addObject:q2];
    }
    if (q3.count) {
        [temp addObject:q3];
    }
    if (q4.count) {
        [temp addObject:q4];
    }
    if (ot.count) {
        [temp addObject:ot];
    }
    
    self.textLives = temp.copy;
    
    /// TODO: 设置header个数
    [self.tableview reloadData];
}

- (NSArray *)quarters{
    return @[@"Q1", @"Q2", @"Q3", @"Q4", @"OT"];
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
