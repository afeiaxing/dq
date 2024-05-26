//
//  AXMatchAnalysisAdvancedViewController.m
//  QYZY
//
//  Created by 22 on 2024/5/18.
//

#import "AXMatchAnalysisAdvancedViewController.h"
#import "AXMatchAnalysisAdvancedQuaterCell.h"
#import "AXMatchAnalysisAdvancedTeamStatsCell.h"

@interface AXMatchAnalysisAdvancedViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableview;

@end

@implementation AXMatchAnalysisAdvancedViewController

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
        return 276;
    } else {
        return 544;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        AXMatchAnalysisAdvancedQuaterCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(AXMatchAnalysisAdvancedQuaterCell.class) forIndexPath:indexPath];
        cell.matchModel = self.matchModel;
        return cell;
    } else {
        AXMatchAnalysisAdvancedTeamStatsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(AXMatchAnalysisAdvancedTeamStatsCell.class) forIndexPath:indexPath];
        cell.matchModel = self.matchModel;
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
        [_tableview registerClass:AXMatchAnalysisAdvancedQuaterCell.class forCellReuseIdentifier:NSStringFromClass(AXMatchAnalysisAdvancedQuaterCell.class)];
        [_tableview registerClass:AXMatchAnalysisAdvancedTeamStatsCell.class forCellReuseIdentifier:NSStringFromClass(AXMatchAnalysisAdvancedTeamStatsCell.class)];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableview;
}

@end
