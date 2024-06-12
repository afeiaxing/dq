//
//  AXMatchAnalysisTraditionalViewController.m
//  QYZY
//
//  Created by 22 on 2024/5/18.
//

#import "AXMatchAnalysisTraditionalViewController.h"
#import "AXMatchAnalysisTraditionalRankCell.h"
#import "AXMatchAnalysisTraditionalMatchCell.h"
#import "AXMatchAnalysisRequest.h"

@interface AXMatchAnalysisTraditionalViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) AXMatchAnalysisRequest *request;
@property (nonatomic, strong) NSArray <AXMatchAnalysisTeamRankModel *>*teamRankModel;
@property (nonatomic, strong) AXMatchAnalysisRivalryRecordModel *rivalryRecordModel;
@property (nonatomic, strong) AXMatchAnalysisTeamRecordModel *hostTeamRecordModel;
@property (nonatomic, strong) AXMatchAnalysisTeamRecordModel *awayTeamRecordModel;

@end

@implementation AXMatchAnalysisTraditionalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubviews];
    
    [self requestData];
}

- (void)requestData{
    [self.view ax_showLoading];
    weakSelf(self);
    [self.request requestTeamRankWithMatchId:self.matchModel.matchId completion:^(NSArray<AXMatchAnalysisTeamRankModel *> * _Nonnull teamRankModel) {
        strongSelf(self);
        [self.view ax_hideLoading];
        self.teamRankModel = teamRankModel;
        [self.tableview reloadData];
    }];
    
    [self.request requestRivalryRecordWithMatchId:self.matchModel.matchId completion:^(AXMatchAnalysisRivalryRecordModel * _Nonnull rivalryRecordModel) {
        strongSelf(self);
        [self.view ax_hideLoading];
        self.rivalryRecordModel = rivalryRecordModel;
        [self.tableview reloadData];
    }];
    
    [self.request requestTeamRecordWithMatchId:self.matchModel.matchId isHostTeam:true completion:^(AXMatchAnalysisTeamRecordModel * _Nonnull teamRecordModel) {
        strongSelf(self);
        self.hostTeamRecordModel = teamRecordModel;
        [self.tableview reloadData];
    }];
    
    [self.request requestTeamRecordWithMatchId:self.matchModel.matchId isHostTeam:false completion:^(AXMatchAnalysisTeamRecordModel * _Nonnull teamRecordModel) {
        strongSelf(self);
        self.awayTeamRecordModel = teamRecordModel;
        [self.tableview reloadData];
    }];
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
        return 181;
    } else {
        return 983; //713;  // 主客队交锋:713, 单队历史记录:983
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        AXMatchAnalysisTraditionalRankCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(AXMatchAnalysisTraditionalRankCell.class) forIndexPath:indexPath];
        cell.teamRankModel = self.teamRankModel;
        return cell;
    } else {
        AXMatchAnalysisTraditionalMatchCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(AXMatchAnalysisTraditionalMatchCell.class) forIndexPath:indexPath];
        cell.matchModel = self.matchModel;
        cell.rivalryRecordModel = self.rivalryRecordModel;
        cell.hostTeamRecordModel = self.hostTeamRecordModel;
        cell.awayTeamRecordModel = self.awayTeamRecordModel;
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
        [_tableview registerClass:AXMatchAnalysisTraditionalRankCell.class forCellReuseIdentifier:NSStringFromClass(AXMatchAnalysisTraditionalRankCell.class)];
        [_tableview registerClass:AXMatchAnalysisTraditionalMatchCell.class forCellReuseIdentifier:NSStringFromClass(AXMatchAnalysisTraditionalMatchCell.class)];
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
