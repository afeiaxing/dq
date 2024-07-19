//
//  AXMatchChatViewController.m
//  QYZY
//
//  Created by 22 on 2024/5/17.
//

#import "AXMatchChatViewController.h"

@interface AXMatchChatViewController ()

@end

@implementation AXMatchChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.cyanColor;
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
