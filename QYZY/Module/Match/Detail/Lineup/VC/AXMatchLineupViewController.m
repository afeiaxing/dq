//
//  AXMatchLineupViewController.m
//  QYZY
//
//  Created by 22 on 2024/5/17.
//

#import "AXMatchLineupViewController.h"
#import "AXMatchLineupPerformersCell.h"
#import "AXMatchLineupPlayerStatsCell.h"
#import "AXMatchLineupRequest.h"

@interface AXMatchLineupViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) AXMatchLineupRequest *request;
@property (nonatomic, strong) AXMatchLineupModel *lineupModel;
@property (nonatomic, copy) void(^scrollCallback)(UIScrollView *scrollView);

@end

@implementation AXMatchLineupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubviews];
    [self requestData];
}

// MARK: private
- (void)setupSubviews{
    [self.view addSubview:self.tableview];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
}

- (void)requestData{
    [self.view ax_showLoading];
    weakSelf(self);
    [self.request requestMatchLineupWithMatchId:self.matchModel.matchId completion:^(AXMatchLineupModel * _Nonnull lineupModel) {
        strongSelf(self);
        [self.view ax_hideLoading];
        self.lineupModel = lineupModel;
        [self.tableview reloadData];
    }];
}

// MARK: UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (!self.lineupModel.homePlayerStats.count && !self.lineupModel.awayPlayerStats.count) {
        return 1;   // 如果没有主、客队球员数据，就隐藏第二组
    }
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 484;
    } else {
        NSInteger playerCount = self.lineupModel.homePlayerStats.count;
        return 175 + 38 * playerCount;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        AXMatchLineupPerformersCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(AXMatchLineupPerformersCell.class) forIndexPath:indexPath];
        cell.matchModel = self.matchModel;
        cell.lineupModel = self.lineupModel;
        return cell;
    } else {
        AXMatchLineupPlayerStatsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(AXMatchLineupPlayerStatsCell.class) forIndexPath:indexPath];
        cell.lineupModel = self.lineupModel;
        return cell;
    }
}

// MARK: JXCategoryListContentViewDelegate
- (UIView *)listView {
    return self.view;
}

- (UIScrollView *)listScrollView {
    return self.tableview;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    !self.scrollCallback ?: self.scrollCallback(scrollView);
}

- (void)listViewDidScrollCallback:(void (^)(UIScrollView *))callback {
    self.scrollCallback = callback;
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

- (AXMatchLineupRequest *)request{
    if (!_request) {
        _request = [AXMatchLineupRequest new];
    }
    return _request;
}

@end
