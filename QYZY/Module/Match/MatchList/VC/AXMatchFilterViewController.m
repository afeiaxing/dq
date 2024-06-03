//
//  AXMatchFilterViewController.m
//  QYZY
//
//  Created by 22 on 2024/5/16.
//

#import "AXMatchFilterViewController.h"
#import "AXMatchFilterTopView.h"

@interface AXMatchFilterViewController ()

@property (nonatomic, strong) AXMatchFilterTopView *topFilterView;


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
}

// MARK: setter & getter
- (AXMatchFilterTopView *)topFilterView{
    if (!_topFilterView) {
        _topFilterView = [AXMatchFilterTopView new];
    }
    return _topFilterView;
}

@end
