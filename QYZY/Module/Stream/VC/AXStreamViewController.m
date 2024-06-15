//
//  AXStreamViewController.m
//  QYZY
//
//  Created by 11 on 5/16/24.
//

#import "AXStreamViewController.h"
#import "AXStreamDetailViewController.h"

@interface AXStreamViewController ()

@end

@implementation AXStreamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fd_prefersNavigationBarHidden = true;
    
    self.view.backgroundColor = UIColor.whiteColor;
    

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    AXStreamDetailViewController *vc = [AXStreamDetailViewController new];
    vc.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:vc animated:true];
}


@end
