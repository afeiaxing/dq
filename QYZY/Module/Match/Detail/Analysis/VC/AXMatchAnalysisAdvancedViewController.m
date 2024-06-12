//
//  AXMatchAnalysisAdvancedViewController.m
//  QYZY
//
//  Created by 22 on 2024/5/18.
//

#import "AXMatchAnalysisAdvancedViewController.h"
#import "AXMatchAnalysisAdvancedQuaterCell.h"
#import "AXMatchAnalysisAdvancedTeamStatsCell.h"
#import "AXMatchAnalysisRequest.h"

@interface AXMatchAnalysisAdvancedViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) AXMatchAnalysisRequest *request;
@property (nonatomic, strong) AXMatchAnalysisAdvancedModel *advancedModel;

@end

@implementation AXMatchAnalysisAdvancedViewController

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
    [self.request requestTeamAdvancedWithMatchId:self.matchModel.matchId limit:6 completion:^(AXMatchAnalysisAdvancedModel * _Nonnull advancedModel) {
        strongSelf(self);
        [self.view ax_hideLoading];
        self.advancedModel = advancedModel;
        [self.tableview reloadData];
    }];
}

// MARK: UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 276;
    } else {
        return 544;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        AXMatchAnalysisAdvancedQuaterCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(AXMatchAnalysisAdvancedQuaterCell.class) forIndexPath:indexPath];
        cell.matchModel = self.matchModel;
        cell.advancedModel = self.advancedModel;
        return cell;
    } else {
        AXMatchAnalysisAdvancedTeamStatsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(AXMatchAnalysisAdvancedTeamStatsCell.class) forIndexPath:indexPath];
        cell.matchModel = self.matchModel;
        cell.teamStatistics = self.advancedModel.teamStatistics;
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

// MARK: setter & getter
- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [UITableView new];
        [_tableview registerClass:AXMatchAnalysisAdvancedQuaterCell.class forCellReuseIdentifier:NSStringFromClass(AXMatchAnalysisAdvancedQuaterCell.class)];
        [_tableview registerClass:AXMatchAnalysisAdvancedTeamStatsCell.class forCellReuseIdentifier:NSStringFromClass(AXMatchAnalysisAdvancedTeamStatsCell.class)];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableview;
}

- (AXMatchAnalysisRequest *)request{
    if (!_request) {
        _request = [AXMatchAnalysisRequest new];
    }
    return _request;
}

@end
