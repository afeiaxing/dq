//
//  AXMatchStandingPBPStatsView.m
//  QYZY
//
//  Created by 22 on 2024/5/18.
//

#import "AXMatchStandingPBPStatsView.h"
#import "AXMatchStandingPBPStatsSubCell.h"

@interface AXMatchStandingPBPStatsView()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UILabel *vsLabel;
@property (nonatomic, strong) UIImageView *hostLogo;
@property (nonatomic, strong) UIImageView *awayLogo;
@property (nonatomic, strong) UILabel *hostName;
@property (nonatomic, strong) UILabel *awayName;

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSArray *datas;

@end

@implementation AXMatchStandingPBPStatsView

// MARK: lifecycle
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame: frame]) {
        [self setupSubviews];
    }
    return self;
}

// MARK: private
- (void)setupSubviews{
    [self addSubview:self.vsLabel];
    [self.vsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.offset(15);
    }];
    
    [self addSubview:self.hostLogo];
    [self.hostLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.vsLabel);
        make.left.offset(33);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    [self addSubview:self.hostName];
    [self.hostName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.vsLabel);
        make.left.equalTo(self.hostLogo.mas_right).offset(10);
    }];
    
    [self addSubview:self.awayLogo];
    [self.awayLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.vsLabel);
        make.width.height.equalTo(self.hostLogo);
        make.right.offset(-33);
    }];

    [self addSubview:self.awayName];
    [self.awayName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.vsLabel);
        make.right.equalTo(self.awayLogo.mas_left).offset(-10);
    }];
    
    [self addSubview:self.tableview];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.top.equalTo(self.vsLabel.mas_bottom).offset(36);
    }];
}

// MARK: UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 46;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AXMatchStandingPBPStatsSubCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(AXMatchStandingPBPStatsSubCell.class) forIndexPath:indexPath];
    cell.data = self.datas[indexPath.row];
    return cell;
}

// MARK: JXCategoryListContentViewDelegate
- (UIView *)listView {
    return self;
}

// MARK: setter & getter
- (UILabel *)vsLabel {
    if (!_vsLabel) {
        _vsLabel = [[UILabel alloc] init];
        _vsLabel.font = [UIFont systemFontOfSize:16];
        _vsLabel.textColor = rgb(17, 17, 17);
        _vsLabel.text = @"VS";
    }
    return _vsLabel;
}

- (UIImageView *)hostLogo{
    if (!_hostLogo) {
        _hostLogo = [UIImageView new];
        _hostLogo.image = [UIImage imageNamed:@"match_team_logo"];
    }
    return _hostLogo;
}

- (UIImageView *)awayLogo{
    if (!_awayLogo) {
        _awayLogo = [UIImageView new];
        _awayLogo.image = [UIImage imageNamed:@"match_team_logo"];
    }
    return _awayLogo;
}

- (UILabel *)hostName {
    if (!_hostName) {
        _hostName = [[UILabel alloc] init];
        _hostName.font = [UIFont systemFontOfSize:12];
        _hostName.textColor = rgb(17, 17, 17);
        _hostName.text = @"LAL";
    }
    return _hostName;
}

- (UILabel *)awayName {
    if (!_awayName) {
        _awayName = [[UILabel alloc] init];
        _awayName.font = [UIFont systemFontOfSize:12];
        _awayName.textColor = rgb(17, 17, 17);
        _awayName.text = @"BOS";
    }
    return _awayName;
}

- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [UITableView new];
        [_tableview registerClass:AXMatchStandingPBPStatsSubCell.class forCellReuseIdentifier:NSStringFromClass(AXMatchStandingPBPStatsSubCell.class)];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.delegate = self;
        _tableview.dataSource = self;
        return _tableview;
    }
    return _tableview;
}

- (NSArray *)datas{
    return @[@"Field Goal", @"Field Goal %", @"3-Point", @"2-Point", @"Free Throw",  @"Free Throw %",];
}

@end
