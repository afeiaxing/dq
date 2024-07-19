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
@property (nonatomic, strong) NSDictionary *teamRankModel;
@property (nonatomic, strong) AXMatchAnalysisRivalryRecordModel *rivalryRecordModel;
@property (nonatomic, strong) AXMatchAnalysisTeamRecordModel *hostTeamRecordModel;
@property (nonatomic, strong) AXMatchAnalysisTeamRecordModel *awayTeamRecordModel;
// 是否请求10条数据，yes：10，no：6
@property (nonatomic, assign) BOOL isRequest10;
@property (nonatomic, assign) int matchRecordCellSelctIndex;

@end

@implementation AXMatchAnalysisTraditionalViewController

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
    int limit = self.isRequest10 ? 10 : 6;
    [self.request requestTeamRankWithMatchId:self.matchModel.matchId limit: limit completion:^(NSDictionary * _Nonnull teamRankModel) {
        strongSelf(self);
        if (teamRankModel.count) {
            [self.view ax_hideLoading];
            self.teamRankModel = teamRankModel;
            [self.tableview reloadData];
        }
    }];
    
    [self.request requestRivalryRecordWithMatchId:self.matchModel.matchId limit: limit completion:^(AXMatchAnalysisRivalryRecordModel * _Nonnull rivalryRecordModel) {
        strongSelf(self);
        [self.view ax_hideLoading];
        self.rivalryRecordModel = rivalryRecordModel;
        [self.tableview reloadData];
    }];
    
    [self.request requestTeamRecordWithMatchId:self.matchModel.matchId isHostTeam:true limit: limit completion:^(AXMatchAnalysisTeamRecordModel * _Nonnull teamRecordModel) {
        strongSelf(self);
        self.hostTeamRecordModel = teamRecordModel;
        [self.tableview reloadData];
    }];
    
    [self.request requestTeamRecordWithMatchId:self.matchModel.matchId isHostTeam:false limit: limit completion:^(AXMatchAnalysisTeamRecordModel * _Nonnull teamRecordModel) {
        strongSelf(self);
        self.awayTeamRecordModel = teamRecordModel;
        [self.tableview reloadData];
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
        // + 40
        CGFloat height;
        if (self.isRequest10) {
            height = self.matchRecordCellSelctIndex == 0 ? 933 : 1073;//733;  // 主客队交锋:933, 单队历史记录:1003
        } else {
            height = self.matchRecordCellSelctIndex == 0 ? 733 : 873;//733;  // 主客队交锋:733, 单队历史记录:803
        }
        
        NSInteger matchCount = 0;
        if (self.matchRecordCellSelctIndex == 1) {
            matchCount = self.hostTeamRecordModel.homeSchedule.count;
        } else if (self.matchRecordCellSelctIndex == 2) {
            matchCount = self.awayTeamRecordModel.awaySchedule.count;
        }
        height += matchCount * 40;
        return height;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        AXMatchAnalysisTraditionalRankCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(AXMatchAnalysisTraditionalRankCell.class) forIndexPath:indexPath];
        cell.teamRankModel = self.teamRankModel;
        weakSelf(self)
        cell.block = ^(BOOL isValue) {
            strongSelf(self)
            self.isRequest10 = isValue;
            [self requestData];
            [self.view ax_showLoading];
        };
        return cell;
    } else {
        AXMatchAnalysisTraditionalMatchCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(AXMatchAnalysisTraditionalMatchCell.class) forIndexPath:indexPath];
        cell.matchModel = self.matchModel;
        cell.rivalryRecordModel = self.rivalryRecordModel;
        cell.hostTeamRecordModel = self.hostTeamRecordModel;
        cell.awayTeamRecordModel = self.awayTeamRecordModel;
        cell.isRequest10 = self.isRequest10;
        weakSelf(self)
        cell.block = ^(int num) {
            strongSelf(self)
            self.matchRecordCellSelctIndex = num;
            [tableView reloadData];
        };
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
