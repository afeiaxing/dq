//
//  AXMatchBetViewController.m
//  QYZY
//
//  Created by 22 on 2024/5/17.
//

#import "AXMatchBetViewController.h"

@interface AXMatchBetViewController ()

@end

@implementation AXMatchBetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.lightGrayColor;
}

// MARK: JXCategoryListContentViewDelegate
- (UIView *)listView {
    return self.view;
}

- (UIScrollView *)listScrollView {
    return [UIScrollView new];
}

- (void)listViewDidScrollCallback:(void (^)(UIScrollView *))callback {
    
}

@end
