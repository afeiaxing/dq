//
//  AXMatchStandingPBPView.m
//  QYZY
//
//  Created by 22 on 2024/5/18.
//

#import "AXMatchStandingPBPView.h"
#import "AXMatchStandingPBPSubCell.h"

@interface AXMatchStandingPBPView()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *quarterTitleBtns;
@property (nonatomic, strong) UIButton *lastSelectedBtn;
@property (nonatomic, strong) NSArray *dataSource;
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
    [self addSubview:self.tableview];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.top.offset(30 + 24);
    }];
}

- (void)handleBtnEvent: (UIButton *)sender{
    [self.lastSelectedBtn setTitleColor:AXUnSelectColor forState:UIControlStateNormal];
    self.lastSelectedBtn.backgroundColor = UIColor.whiteColor;
    [sender setTitleColor:AXSelectColor forState:UIControlStateNormal];
    sender.backgroundColor = rgb(255, 247, 239);
    self.lastSelectedBtn = sender;
    self.selectIndex = sender.tag;
    [self.tableview reloadData];
}

// MARK: UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array = self.dataSource[self.selectIndex];
    return array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 53;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AXMatchStandingPBPSubCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(AXMatchStandingPBPSubCell.class) forIndexPath:indexPath];
    NSArray *array = self.dataSource[self.selectIndex];
    cell.index = indexPath.row;
    cell.model = array[indexPath.row];
    return cell;
}

// MARK: JXCategoryListContentViewDelegate
- (UIView *)listView {
    return self;
}

// MARK: setter & getter
- (void)setMatchModel:(AXMatchListItemModel *)matchModel{

    _matchModel = matchModel;
}

- (void)setTextLives:(NSDictionary *)textLives{
    if (!textLives.allKeys.count || textLives.allKeys.count == 0) {return;}
    NSArray *q1 = [textLives valueForKey:@"Q1"];
    NSArray *q2 = [textLives valueForKey:@"Q2"];
    NSArray *q3 = [textLives valueForKey:@"Q3"];
    NSArray *q4 = [textLives valueForKey:@"Q4"];
    
    NSMutableArray *temp = [NSMutableArray array];
    
    if (q1.count) {
        [temp addObject:q1];
    } else {
        [temp addObject:@[]];
    }
    
    if (q2.count) {
        [temp addObject:q2];
    } else {
        [temp addObject:@[]];
    }
    
    if (q3.count) {
        [temp addObject:q3];
    } else {
        [temp addObject:@[]];
    }
    
    if (q4.count) {
        [temp addObject:q4];
    } else {
        [temp addObject:@[]];
    }
    
//    if (ot.count) {
//        [temp addObject:ot];
//    }
    
    self.dataSource = temp.copy;
    
    for (UIButton *btn in self.quarterTitleBtns) {
        [btn removeFromSuperview];
    }
    
    [self.quarterTitleBtns removeAllObjects];
    
    // 设置小节按钮
    NSMutableArray *btns = [NSMutableArray array];
    for (int i = 0; i < self.dataSource.count; i++) {
        NSString *title = i == 4 ? @"OT" : [NSString stringWithFormat:@"Q%d", i + 1];
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
    
    
    [self.tableview reloadData];
    
    _textLives = textLives;
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

- (NSMutableArray *)quarterTitleBtns{
    if (!_quarterTitleBtns) {
        _quarterTitleBtns = [NSMutableArray array];
    }
    return _quarterTitleBtns;
}

@end
