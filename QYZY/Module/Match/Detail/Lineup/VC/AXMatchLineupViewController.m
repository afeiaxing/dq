//
//  AXMatchLineupViewController.m
//  QYZY
//
//  Created by 22 on 2024/5/17.
//

#import "AXMatchLineupViewController.h"
#import "AXMatchLineupPerformersCell.h"
#import "AXMatchLineupPlayerStatsCell.h"

@interface AXMatchLineupViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableview;

@end

@implementation AXMatchLineupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubviews];
}

// MARK: private
- (void)setupSubviews{
    [self.view addSubview:self.tableview];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
}

// MARK: UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 484;
    } else {
        return 583;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        AXMatchLineupPerformersCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(AXMatchLineupPerformersCell.class) forIndexPath:indexPath];
        cell.matchModel = self.matchModel;
        return cell;
    } else {
        AXMatchLineupPlayerStatsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(AXMatchLineupPlayerStatsCell.class) forIndexPath:indexPath];

        return cell;
    }
}

// MARK: JXCategoryListContentViewDelegate
- (UIView *)listView {
    return self.view;
}

// MARK: setter & getter
- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [UITableView new];
        [_tableview registerClass:AXMatchLineupPerformersCell.class forCellReuseIdentifier:NSStringFromClass(AXMatchLineupPerformersCell.class)];
        [_tableview registerClass:AXMatchLineupPlayerStatsCell.class forCellReuseIdentifier:NSStringFromClass(AXMatchLineupPlayerStatsCell.class)];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableview;
}

@end
