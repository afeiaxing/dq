//
//  AXMatchSettingViewController.m
//  QYZY
//
//  Created by 22 on 2024/5/16.
//

#import "AXMatchSettingViewController.h"
#import "AXMatchListSettingCell.h"

@interface AXMatchSettingViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *settingsData;

@end

@implementation AXMatchSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    
    self.settingsData = @[@{@"title": @"Matches display", @"options": @[]},
                          @{@"title": @"Match rankings", @"options": @[@{@"title": @"", @"type": [NSNumber numberWithInt:SettingTypeSwitch]}]},
                          @{@"title": @"Notification sound in APP", @"options": @[]},
                          @{@"title": @"Favorites event push", @"options": @[@{@"title": @"ALL Matches", @"type": [NSNumber numberWithInt:SettingTypeArrow]}]},
                          @{@"title": @"Score Notification", @"options": @[]},
                          @{@"title": @"Voice notification", @"options": @[@{@"title": @"", @"type": [NSNumber numberWithInt:SettingTypeSwitch]}]},
                          @{@"title": @"Vibrate", @"options": @[@{@"title": @"", @"type": [NSNumber numberWithInt:SettingTypeSwitch]}]},
                          @{@"title": @"Mobile phone notification bar push settings", @"options": @[]},
                          @{@"title": @"Notification bar push", @"options": @[@{@"title": @"", @"type": [NSNumber numberWithInt:SettingTypeSwitch]}]},
                          @{@"title": @"Favorites event push", @"options": @[@{@"title": @"3/3", @"type": [NSNumber numberWithInt:SettingTypeArrow]}]}];
    
    [self.tableView registerClass:[AXMatchListSettingCell class] forCellReuseIdentifier:@"SettingCell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.settingsData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AXMatchListSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(AXMatchListSettingCell.class) forIndexPath:indexPath];
    
    NSDictionary *setting = self.settingsData[indexPath.row];
    cell.title = setting[@"title"];
    
    NSArray *options = setting[@"options"];
    if (options.count > 0) {
        NSDictionary *option = options[0];
        NSNumber *typeNum = option[@"type"];
        SettingType type = (SettingType)(typeNum.intValue);
        switch (type) {
            case SettingTypeSwitch:
                cell.accessoryView = [[UISwitch alloc] init];
                break;
            case SettingTypeArrow:
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
            default:
                break;
        }
    }
    
    return cell;
}

// MARK: setter & getter
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [UITableView new];
        [_tableView registerClass:AXMatchListSettingCell.class forCellReuseIdentifier:NSStringFromClass(AXMatchListSettingCell.class)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
