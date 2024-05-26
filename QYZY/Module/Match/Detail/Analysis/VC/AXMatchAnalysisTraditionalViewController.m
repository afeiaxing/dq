//
//  AXMatchAnalysisTraditionalViewController.m
//  QYZY
//
//  Created by 22 on 2024/5/18.
//

#import "AXMatchAnalysisTraditionalViewController.h"
#import "AXMatchAnalysisTraditionalRankCell.h"
#import "AXMatchAnalysisTraditionalMatchCell.h"

@interface AXMatchAnalysisTraditionalViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableview;

@end

@implementation AXMatchAnalysisTraditionalViewController

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
        return 181;
    } else {
        return 983; //713;  // 主客队交锋:713, 单队历史记录:983
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        AXMatchAnalysisTraditionalRankCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(AXMatchAnalysisTraditionalRankCell.class) forIndexPath:indexPath];

        return cell;
    } else {
        AXMatchAnalysisTraditionalMatchCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(AXMatchAnalysisTraditionalMatchCell.class) forIndexPath:indexPath];
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
        [_tableview registerClass:AXMatchAnalysisTraditionalRankCell.class forCellReuseIdentifier:NSStringFromClass(AXMatchAnalysisTraditionalRankCell.class)];
        [_tableview registerClass:AXMatchAnalysisTraditionalMatchCell.class forCellReuseIdentifier:NSStringFromClass(AXMatchAnalysisTraditionalMatchCell.class)];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableview;
}

@end
