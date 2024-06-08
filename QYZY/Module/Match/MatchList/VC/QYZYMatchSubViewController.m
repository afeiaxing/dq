//
//  QYZYMatchSubViewController.m
//  QYZY
//
//  Created by jspollo on 2022/10/12.
//

#import "QYZYMatchSubViewController.h"
#import "QYZYMatchDetailViewController.h"
#import "QYZYMatchHomeCell.h"
#import "QYZYTableEmptyCell.h"

#import "AXMatchListTableViewCell.h"
#import "AXMatchListOddsCell.h"
#import "AXMatchListSectionHeader.h"
#import "AXMatchListRequest.h"

@interface QYZYMatchSubViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) AXMatchListDateView *dateView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) int pageNo;
@property (nonatomic, strong) AXMatchListRequest *requestManager;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSString *dateString;

@end

#define kAXMatchListDateViewHeight 50
#define kMatchListRefreshDuration_live 1500
#define kMatchListRefreshDuration_Schedule 1500

@implementation QYZYMatchSubViewController

- (UIView *)listView {
    return self.view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageNo = 1;
    [self setupSubviews];
    if (self.status == AXMatchStatusResult) {
        [self requestData];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.timer invalidate];
    self.timer = nil;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (!self.timer && self.status != AXMatchStatusResult) {
        int duration = self.status == AXMatchStatusLive ? kMatchListRefreshDuration_live : kMatchListRefreshDuration_Schedule;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:duration target:self selector:@selector(requestData) userInfo:nil repeats:YES];
        [self.timer fire];
    }
}

- (void)setupSubviews{
    [self.view addSubview:self.tableView];
    if (self.status == AXMatchStatusSchedule || self.status == AXMatchStatusResult) {
        [self.view addSubview:self.dateView];
        [self.dateView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.offset(0);
            make.height.mas_equalTo(kAXMatchListDateViewHeight);
        }];
        
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.offset(0);
            make.top.equalTo(self.dateView.mas_bottom).offset(0);
        }];
    } else {
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.offset(0);
        }];
    }
}

- (void)requestData{
    NSArray *times = [self getDateTimestamp];
    NSString *startTime = times.firstObject;
    NSString *endTime = times.lastObject;
    [self.view ax_showLoading];
    weakSelf(self);
    [self.requestManager requestMatchListWithType:self.status pageNo:self.pageNo startTime:startTime endTime:endTime filter:@"" completion:^(AXMatchListModel * _Nonnull matchModel) {
        strongSelf(self);
        [self.view ax_hideLoading];
        [self endRefresh];
        NSMutableArray *allModel = [NSMutableArray array];
        if (matchModel.live && matchModel.live.count) {
            [allModel addObject:matchModel.live];
        }
        if (matchModel.schedule && matchModel.schedule.count) {
            [allModel addObject:matchModel.schedule];
        }
        if (matchModel.result && matchModel.result.count) {
            [allModel addObject:matchModel.result];
        }
        
        switch (self.status) {
            case AXMatchStatusAll:
                self.matches = allModel.copy;
                break;
            case AXMatchStatusSchedule:
                self.matches = @[matchModel.schedule];
                break;
            case AXMatchStatusLive:
                self.matches = @[matchModel.live];
                break;
            case AXMatchStatusResult:
                self.matches = @[matchModel.result];
                break;
                
            default:
                break;
        }
    }];
}

- (NSArray *)getDateTimestamp{
    if (!self.dateString) {return nil;}
    NSTimeInterval start = [NSDate getDayStartTimestampWithDateString:self.dateString];
    NSTimeInterval end = [NSDate getDayEndTimestampWithDateString:self.dateString];
    return @[[NSString stringWithFormat:@"%.0f", start], [NSString stringWithFormat:@"%.0f", end]];
}

- (void)setMatches:(NSArray *)matches {
    _matches = matches;
    [self.tableView reloadData];
}

- (void)endRefresh {
    [self.tableView.mj_header endRefreshing];
//    [self.view qyzy_hideLoading];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *array = self.matches[indexPath.section];
    AXMatchListItemModel *model = array[indexPath.row];
    if (self.status == AXMatchStatusSchedule) {
        AXMatchListOddsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(AXMatchListOddsCell.class) forIndexPath:indexPath];
        cell.model = model;
        return cell;
    } else {
        AXMatchListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(AXMatchListTableViewCell.class) forIndexPath:indexPath];
        cell.model = model;
        return cell;
    }
    
//        QYZYTableEmptyCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(QYZYTableEmptyCell.class) forIndexPath:indexPath];
//        cell.contentView.backgroundColor = UIColor.whiteColor;
//        return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.matches.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return self.status == AXMatchStatusAll ? 30 : 0.1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = self.matches[section];
    return array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  154;
//    return self.matches.count ? 82 : self.view.frame.size.height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.status != AXMatchStatusAll) {
        return nil;
    }
    
    AXMatchListSectionHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass(AXMatchListSectionHeader.class)];
    NSString *str;
    switch (section) {
        case 0:
            str = @"Live";
            break;
        case 1:
            str = @"Scheduled";
            break;
        case 2:
            str = @"Result";
            break;
            
        default:
            break;
    }
    header.titleString = str;
    return header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QYZYMatchDetailViewController *vc = [[QYZYMatchDetailViewController alloc] init];
    NSArray *array = self.matches[indexPath.section];
    AXMatchListItemModel *model = array[indexPath.row];
    vc.matchModel = model;
    vc.hidesBottomBarWhenPushed = YES;
    [UIViewController.currentViewController.navigationController pushViewController:vc animated:YES];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        weakSelf(self);
        _tableView.backgroundColor = rgb(248, 249, 254);
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            strongSelf(self);
            !self.requestBlock ? : self.requestBlock();
        }];
        [_tableView registerClass:AXMatchListTableViewCell.class forCellReuseIdentifier:NSStringFromClass(AXMatchListTableViewCell.class)];
        [_tableView registerClass:AXMatchListOddsCell.class forCellReuseIdentifier:NSStringFromClass(AXMatchListOddsCell.class)];
//        [_tableView registerClass:QYZYTableEmptyCell.class forCellReuseIdentifier:NSStringFromClass(QYZYTableEmptyCell.class)];
        [_tableView registerClass:AXMatchListSectionHeader.class forHeaderFooterViewReuseIdentifier:NSStringFromClass(AXMatchListSectionHeader.class)];
        _tableView.sectionFooterHeight = 0.1;
    }
    return _tableView;
}

- (AXMatchListDateView *)dateView{
    if (!_dateView) {
        _dateView = [[AXMatchListDateView alloc] initWithStatus:self.status];
        weakSelf(self);
        _dateView.block = ^(AXMatchStatus status, NSString * _Nonnull dateString) {
            strongSelf(self);
            self.dateString = dateString;
            [self requestData];
        };
    }
    return _dateView;
}

- (AXMatchListRequest *)requestManager{
    if (!_requestManager) {
        _requestManager = [AXMatchListRequest new];
    }
    return _requestManager;
}

@end
