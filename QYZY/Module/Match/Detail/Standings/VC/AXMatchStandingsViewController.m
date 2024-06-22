//
//  AXMatchStandingsViewController.m
//  QYZY
//
//  Created by 22 on 2024/5/17.
//

#import "AXMatchStandingsViewController.h"
#import "AXMatchStandingChartCell.h"
#import "AXMatchStandingTeamStatsCell.h"
#import "AXMatchStandingPBPCell.h"
#import "AXMatchStandingRequest.h"

@interface AXMatchStandingsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) AXMatchStandingRequest *request;
@property (nonatomic, strong) AXMatchStandingModel *standingModel;
@property (nonatomic, strong) NSDictionary *textLives;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, copy) void(^scrollCallback)(UIScrollView *scrollView);

@end

#define kAXMatchStandingRefreshDuration 30

@implementation AXMatchStandingsViewController

// MARK: lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubviews];
    [self requestData];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.timer invalidate];
    self.timer = nil;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (!self.timer) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:kAXMatchStandingRefreshDuration target:self selector:@selector(requestData) userInfo:nil repeats:YES];
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (!self.textLives.count && !self.standingModel.statistics.count) {
        return 2;  // 如果没有 文字直播 和 技术统计，就隐藏第三组
    }
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 278;
    } else if (indexPath.row == 1) {
        return 311;
    } else {
        return 426;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        AXMatchStandingChartCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(AXMatchStandingChartCell.class) forIndexPath:indexPath];
        cell.matchModel = self.matchModel;
        cell.standingModel = self.standingModel;
        return cell;
    } else if (indexPath.row == 1) {
        AXMatchStandingTeamStatsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(AXMatchStandingTeamStatsCell.class) forIndexPath:indexPath];
        cell.matchModel = self.matchModel;
        cell.standingModel = self.standingModel;
        return cell;
    } else {
        AXMatchStandingPBPCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(AXMatchStandingPBPCell.class) forIndexPath:indexPath];
        cell.matchModel = self.matchModel;
        cell.standingModel = self.standingModel;
        cell.textLives = self.textLives;
        return cell;
    }
}

// MARK: private
- (void)setupSubviews{
    [self.view addSubview:self.tableview];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
}

- (void)requestData{
    [self.request requestMatchStandingWithMatchId:self.matchModel.matchId completion:^(AXMatchStandingModel * _Nonnull matchModel) {
        self.standingModel = matchModel;
        [self.tableview reloadData];
    }];
    
    [self.request requestMatchTextLiveWithMatchId:self.matchModel.matchId completion:^(NSDictionary * _Nonnull textLives) {
        self.textLives = textLives;
        [self.tableview reloadData];
    }];
    
    AXLog(@"~~~赛事详情：Standing接口调用");
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
        [_tableview registerClass:AXMatchStandingChartCell.class forCellReuseIdentifier:NSStringFromClass(AXMatchStandingChartCell.class)];
        [_tableview registerClass:AXMatchStandingTeamStatsCell.class forCellReuseIdentifier:NSStringFromClass(AXMatchStandingTeamStatsCell.class)];
        [_tableview registerClass:AXMatchStandingPBPCell.class forCellReuseIdentifier:NSStringFromClass(AXMatchStandingPBPCell.class)];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableview;
}

- (AXMatchStandingRequest *)request{
    if (!_request) {
        _request = [AXMatchStandingRequest new];
    }
    return _request;
}

@end
