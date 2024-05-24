//
//  AXDataBaseViewController.m
//  QYZY
//
//  Created by 22 on 5/24/24.
//

#import "AXDataBaseViewController.h"

@interface AXDataBaseViewController ()

@end

@implementation AXDataBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
}


// MARK: JXCategoryListContentViewDelegate
- (UIView *)listView {
    return self.view;
}

@end
