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
#import "AXMatchFilterRequest.h"

@interface AXMatchFilterViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) AXMatchFilterTopView *topFilterView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) AXMatchFilterBottomView *bottomView;
@property (nonatomic, strong) AXMatchFilterRequest *request;

@property (nonatomic, strong) NSArray *indexArray;
@property (nonatomic, strong) NSDictionary *dataSource;
@property (nonatomic, assign) int totalMatchCount;

@end

@implementation AXMatchFilterViewController

// MARK: lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubviews];
    [self requestData];
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

- (void)requestData{
    [self.view ax_showLoading];
    weakSelf(self);
    [self.request requestMatchListWithTitle:@"" sign:@"" completion:^(AXMatchFilterModel * _Nonnull filterModel) {
        strongSelf(self);
        [self.view ax_hideLoading];
        [self handleDataSourceWithModel: filterModel];
        [self.tableView reloadData];
    }];
}

- (void)handleDataSourceWithModel:(AXMatchFilterModel *)model{
    NSMutableArray *indexs = [NSMutableArray array];
    NSMutableDictionary *dataSource = [NSMutableDictionary dictionary];
    
    // 获取类的属性列表
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([model class], &count);
    
    // 遍历属性列表
    for (unsigned int i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        const char *propertyName = property_getName(property);
        NSString *propertyNameString = [NSString stringWithUTF8String:propertyName];
        
        // 获取属性值
        id value = [model valueForKey:propertyNameString];
        
        if ([value isKindOfClass:NSArray.class]) {
            [indexs addObject:propertyNameString];
            [dataSource setValue:value forKey:propertyNameString];
            [self handleTotalMatchCount:value];
        }
    }
    
    // 释放属性列表内存
    free(properties);
    
    self.indexArray = indexs;
    self.dataSource = dataSource;
    self.bottomView.totalMatchCount = self.totalMatchCount;
}

// 计算赛事总数
- (void)handleTotalMatchCount: (NSArray *)array{
    for (AXMatchFilterItenModel *model in array) {
        self.totalMatchCount += model.items.intValue;
    }
}

// MARK: UITableViewDelegate,UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AXMatchListFilterCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(AXMatchListFilterCell.class) forIndexPath:indexPath];
    NSString *indexString = self.indexArray[indexPath.section];
    NSArray *array = [self.dataSource valueForKey:indexString];
    cell.model = array[indexPath.row];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.indexArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *indexString = self.indexArray[section];
    NSArray *array = [self.dataSource valueForKey:indexString];
    return array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return  40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    AXMatchListSectionHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass(AXMatchListSectionHeader.class)];
    header.titleString = self.indexArray[section];
    return header;
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
            strongSelf(self)
            switch (eventType) {
                case AXMatchFilterBottomEvent_selectall:
                    AXLog(@"AXMatchFilterBottomEvent_selectall");
                    break;
                case AXMatchFilterBottomEvent_reverse:
                    AXLog(@"AXMatchFilterBottomEvent_reverse");
                    break;
                case AXMatchFilterBottomEvent_confirm:
                    [self.navigationController popViewControllerAnimated:true];
                    break;
                    
                default:
                    break;
            }
        };
    }
    return _bottomView;
}

- (AXMatchFilterRequest *)request{
    if (!_request) {
        _request = [AXMatchFilterRequest new];
    }
    return _request;
}

@end
