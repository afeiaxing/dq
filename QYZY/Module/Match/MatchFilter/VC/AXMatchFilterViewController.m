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

typedef enum : NSUInteger {
    AXMatchListFilterTypeAll,
    AXMatchListFilterTypeNBA,
    AXMatchListFilterTypePBA,
    AXMatchListFilterTypeSearch,
} AXMatchListFilterType;

@interface AXMatchFilterViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) AXMatchFilterTopView *topFilterView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) AXMatchFilterBottomView *bottomView;
@property (nonatomic, strong) AXMatchFilterRequest *request;

@property (nonatomic, strong) NSArray *indexArray;
@property (nonatomic, strong) NSDictionary *dataSource;
@property (nonatomic, assign) int totalMatchCount;

@property (nonatomic, strong) NSArray *searchIndexArray;
@property (nonatomic, strong) NSDictionary *searchDataSource;

@property (nonatomic, assign) AXMatchListFilterType filterType;
@property (nonatomic, strong) AXMatchFilterItenModel *nbaFilterModel;
@property (nonatomic, strong) AXMatchFilterItenModel *pbaFilterModel;

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
//        make.height.mas_offset(96);
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

// 计算赛事总数，和赋值nba和pba Model
- (void)handleTotalMatchCount: (NSArray *)array{
    for (AXMatchFilterItenModel *model in array) {
        self.totalMatchCount += model.items.intValue;
    
        model.isSelected = true;  // 默认选中
        if ([model.shortName isEqualToString:@"NBA"]) {
            self.nbaFilterModel = model;
        }
        
        if ([model.shortName isEqualToString:@"PBA"]) {
            self.pbaFilterModel = model;
        }
    }
}

// 自定义搜索
- (void)handleSearchWithString: (NSString *)string{
    if (!string.length) {
        self.filterType = AXMatchListFilterTypeAll;
        [self.tableView reloadData];
        return;
    }
    
    self.filterType = AXMatchListFilterTypeSearch;
    
    NSMutableArray *indexArray = [NSMutableArray array];
    NSDictionary *dataSource = [NSMutableDictionary dictionary];
    
    for (NSString *str in self.indexArray) {
        NSArray *modelArray = [self.dataSource valueForKey:str];
        NSMutableArray *temp = [NSMutableArray array];
        for (AXMatchFilterItenModel *model in modelArray) {
            NSString *leagueLowercase = model.leaguesName.lowercaseString;
            NSString *stringLowercase = string.lowercaseString;
            if ([leagueLowercase containsString:stringLowercase]) {
                if (![indexArray containsObject:str]) {
                    [indexArray addObject:str];
                }
                
                [temp addObject:model];
            }
        }
        
        if (temp.count) {
            [dataSource setValue:temp forKey:str];
        }
    }
    
    self.searchIndexArray = indexArray;
    self.searchDataSource = dataSource;
    [self.tableView reloadData];
}

// 切换all、nba、pba
- (void)handleFilterWithIndex: (int)index{
    self.filterType = (AXMatchListFilterType)index;
    [self.tableView reloadData];
}

// 全选
- (void)handleSelectAll {
    for (NSString *str in self.indexArray) {
        NSArray *modelArray = [self.dataSource valueForKey:str];
        for (AXMatchFilterItenModel *model in modelArray) {
            model.isSelected = true;
        }
    }
//    self.nbaFilterModel.isSelected = true;
//    self.pbaFilterModel.isSelected = true;
    
    [self.tableView reloadData];
}

// 反选
- (void)handleReverse {
    for (NSString *str in self.indexArray) {
        NSArray *modelArray = [self.dataSource valueForKey:str];
        for (AXMatchFilterItenModel *model in modelArray) {
            model.isSelected = !model.isSelected;
        }
    }
//    self.nbaFilterModel.isSelected = !self.nbaFilterModel.isSelected;
//    self.pbaFilterModel.isSelected = !self.pbaFilterModel.isSelected;
    
    [self.tableView reloadData];
}

// 确认
- (void)handeConfirm{
    NSMutableArray *temp = [NSMutableArray array];
    BOOL isSelectAll = true;
    for (NSString *str in self.indexArray) {
        NSArray *modelArray = [self.dataSource valueForKey:str];
        for (AXMatchFilterItenModel *model in modelArray) {
            if (model.isSelected) {
                [temp addObject:model.shortName];
            } else {
                isSelectAll = false;
            }
        }
    }
    
    !self.block ? : self.block(isSelectAll, temp.copy);
}

// MARK: UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.filterType == AXMatchListFilterTypeNBA) {
        return self.nbaFilterModel ? 1 : 0;
    } else if (self.filterType == AXMatchListFilterTypePBA) {
        return self.pbaFilterModel ? 1 : 0;
    } else if (self.filterType == AXMatchListFilterTypeSearch) {
        return self.searchIndexArray.count;
    } else {
        return self.indexArray.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.filterType == AXMatchListFilterTypeNBA) {
        return self.nbaFilterModel ? 1 : 0;
    } else if (self.filterType == AXMatchListFilterTypePBA) {
        return self.pbaFilterModel ? 1 : 0;
    } else if (self.filterType == AXMatchListFilterTypeSearch) {
        NSString *indexString = self.searchIndexArray[section];
        NSArray *array = [self.searchDataSource valueForKey:indexString];
        return array.count;
    } else {
        NSString *indexString = self.indexArray[section];
        NSArray *array = [self.dataSource valueForKey:indexString];
        return array.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AXMatchListFilterCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(AXMatchListFilterCell.class) forIndexPath:indexPath];
    
    if (self.filterType == AXMatchListFilterTypeNBA) {
        cell.model = self.nbaFilterModel;
    } else if (self.filterType == AXMatchListFilterTypePBA) {
        cell.model = self.pbaFilterModel;
    } else if (self.filterType == AXMatchListFilterTypeSearch) {
        NSString *indexString = self.searchIndexArray[indexPath.section];
        NSArray *array = [self.searchDataSource valueForKey:indexString];
        cell.model = array[indexPath.row];
    } else {
        NSString *indexString = self.indexArray[indexPath.section];
        NSArray *array = [self.dataSource valueForKey:indexString];
        cell.model = array[indexPath.row];
    }
    cell.block = ^(BOOL isSelected, int count) {
        [self.bottomView handleUpdateCount:count isIncrease:isSelected];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
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
        weakSelf(self)
        _topFilterView.block = ^(int num) {
            strongSelf(self)
            [self handleFilterWithIndex:num];
        };
        _topFilterView.searchBlock = ^(NSString *string) {
            strongSelf(self)
            [self handleSearchWithString:string];
        };
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

- (AXMatchFilterBottomView *)bottomView{
    if (!_bottomView) {
        weakSelf(self);
        _bottomView = [AXMatchFilterBottomView new];
        _bottomView.block = ^(AXMatchFilterBottomEventType eventType) {
            strongSelf(self)
            switch (eventType) {
                case AXMatchFilterBottomEvent_selectall:
                    [self handleSelectAll];
                    break;
                case AXMatchFilterBottomEvent_reverse:
                    [self handleReverse];
                    break;
                case AXMatchFilterBottomEvent_confirm:
                    [self handeConfirm];
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
