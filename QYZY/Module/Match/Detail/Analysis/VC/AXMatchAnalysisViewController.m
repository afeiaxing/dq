//
//  AXMatchAnalysisViewController.m
//  QYZY
//
//  Created by 22 on 2024/5/17.
//

#import "AXMatchAnalysisViewController.h"

@interface AXMatchAnalysisViewController ()

@end

@implementation AXMatchAnalysisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.purpleColor;
}

// MARK: JXCategoryListContentViewDelegate
- (UIView *)listView {
    return self.view;
}

@end
