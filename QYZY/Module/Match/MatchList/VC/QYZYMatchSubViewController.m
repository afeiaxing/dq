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

@interface QYZYMatchSubViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation QYZYMatchSubViewController

- (UIView *)listView {
    return self.view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    weakSelf(self);
    self.tableView.backgroundColor = rgb(248, 249, 254);
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        strongSelf(self);
        !self.requestBlock ? : self.requestBlock();
    }];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(AXMatchListTableViewCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(AXMatchListTableViewCell.class)];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(AXMatchListOddsCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(AXMatchListOddsCell.class)];
    [self.tableView registerClass:QYZYTableEmptyCell.class forCellReuseIdentifier:NSStringFromClass(QYZYTableEmptyCell.class)];
}

- (void)setMatches:(NSArray *)matches {
    _matches = matches;
    [self.tableView reloadData];
}

- (void)endRefresh {
    [self.tableView.mj_header endRefreshing];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BOOL isUpcoming = indexPath.row %2 == 0;
    if (isUpcoming) {
        AXMatchListOddsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(AXMatchListOddsCell.class) forIndexPath:indexPath];
        return cell;
    } else {
        AXMatchListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(AXMatchListTableViewCell.class) forIndexPath:indexPath];
        cell.indexrow = indexPath.row;
        return cell;
    }
    
//    QYZYMatchHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(QYZYMatchHomeCell.class) forIndexPath:indexPath];
//    QYZYMatchDetailModel *model = [QYZYMatchDetailModel new];
//    model.leagueName = @"西甲";
//    model.matchTime = @"12321213";
//    model.hostTeamName = @"皇马";
//    model.guestTeamName = @"巴萨";
//    model.hostTeamScore = @"1";
//    model.guestTeamScore = @"2";
//    model.statusLable = @"1";
//    cell.detailModel = model;
//    return cell;
//
//    if (self.matches.count) {
//        QYZYMatchHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(QYZYMatchHomeCell.class) forIndexPath:indexPath];
//        if (self.matches.count > indexPath.row) {
//            cell.detailModel = self.matches[indexPath.row];
//        }
//        return cell;
//    }
//    else {
//        QYZYTableEmptyCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(QYZYTableEmptyCell.class) forIndexPath:indexPath];
//        cell.contentView.backgroundColor = UIColor.whiteColor;
//        return cell;
//    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
    return self.matches.count ? self.matches.count : 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  150;
    return self.matches.count ? 82 : self.view.frame.size.height;
}

// TODO: 设置sectionView

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (self.matches.count) {
        QYZYMatchDetailViewController *vc = [[QYZYMatchDetailViewController alloc] init];
        vc.matchId = self.matches[indexPath.row].matchId;
        vc.hidesBottomBarWhenPushed = YES;
        [UIViewController.currentViewController.navigationController pushViewController:vc animated:YES];
//    }
}

@end
