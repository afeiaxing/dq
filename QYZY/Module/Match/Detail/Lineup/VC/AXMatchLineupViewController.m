//
//  AXMatchLineupViewController.m
//  QYZY
//
//  Created by 22 on 2024/5/17.
//

#import "AXMatchLineupViewController.h"

@interface AXMatchLineupViewController ()

@end

@implementation AXMatchLineupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.orangeColor;
}

// MARK: JXCategoryListContentViewDelegate
- (UIView *)listView {
    return self.view;
}

@end
