//
//  AXMatchFilterViewController.m
//  QYZY
//
//  Created by 22 on 2024/5/16.
//

#import "AXMatchFilterViewController.h"
#import "AXMatchFilterTopView.h"
#import "AXMatchListSectionHeader.h"
#import "AXMatchListFilterCell.h"
#import "AXMatchFilterBottomView.h"

@interface AXMatchFilterViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) AXMatchFilterTopView *topFilterView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) AXMatchFilterBottomView *bottomView;


@end

@implementation AXMatchFilterViewController

// MARK: lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubviews];
}

// MARK: private
- (void)setupSubviews{
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self.view addSubview:self.topFilterView];
    [self.topFilterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.height.mas_offset(48);
    }];
    
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.height.mas_offset(94);
    }];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.bottom.equalTo(self.bottomView.mas_top);
        make.top.equalTo(self.topFilterView.mas_bottom);
    }];
}

// MARK: UITableViewDelegate,UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AXMatchListFilterCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(AXMatchListFilterCell.class) forIndexPath:indexPath];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    AXMatchListSectionHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass(AXMatchListSectionHeader.class)];
    header.titleString = @"A";
    return header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

// MARK: setter & getter
- (AXMatchFilterTopView *)topFilterView{
    if (!_topFilterView) {
        _topFilterView = [AXMatchFilterTopView new];
    }
    return _topFilterView;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        
        _tableView.backgroundColor = rgb(248, 249, 254);
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView registerClass:AXMatchListFilterCell.class forCellReuseIdentifier:NSStringFromClass(AXMatchListFilterCell.class)];
        [_tableView registerClass:AXMatchListSectionHeader.class forHeaderFooterViewReuseIdentifier:NSStringFromClass(AXMatchListSectionHeader.class)];
        _tableView.sectionFooterHeight = 0.1;
    }
    return _tableView;
}
/**
 _liveVC.requestBlock = ^{
     strongSelf(self);
     [self requestData];
 };
}
 */
- (AXMatchFilterBottomView *)bottomView{
    if (!_bottomView) {
        weakSelf(self);
        _bottomView = [AXMatchFilterBottomView new];
        _bottomView.block = ^(AXMatchFilterBottomEventType eventType) {
            
            
        };
    }
    return _bottomView;
}

@end
