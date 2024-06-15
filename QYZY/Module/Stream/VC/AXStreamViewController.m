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
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.whiteColor;
    

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    AXStreamDetailViewController *vc = [AXStreamDetailViewController new];
    [self.navigationController pushViewController:vc animated:true];
}


@end
