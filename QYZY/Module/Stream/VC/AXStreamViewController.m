//
//  AXStreamViewController.m
//  QYZY
//
//  Created by 11 on 5/16/24.
//

#import "AXStreamViewController.h"
#import "ORLineChartView.h"

@interface AXStreamViewController ()<ORLineChartViewDataSource>

@property (nonatomic, strong) NSArray *datas;
@property (nonatomic, strong) ORLineChartView *lineChartView;

@end

@implementation AXStreamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    _datas = @[@(1), @(3),@(5),@(4),@(6),@(7),@(9),@(0),@(-2),@(-4),@(-9),@(4),@(0),@(-2),@(5)];

    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    _lineChartView = [[ORLineChartView alloc] initWithFrame:CGRectMake(0, 0, width, 200)];
    _lineChartView.config.gradientLocations = @[@(0.8), @(0.9)];
    _lineChartView.config.showShadowLine = false;
    _lineChartView.config.showVerticalBgline = false;
    _lineChartView.config.showHorizontalBgline = false;
    _lineChartView.config.bottomLabelWidth = (width - 50) / _datas.count;

    _lineChartView.dataSource = self;
    
        
    [self.view addSubview:_lineChartView];
    _lineChartView.center = self.view.center;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [_lineChartView reloadData];


    return;
}

#pragma mark - ORLineChartViewDataSource
- (NSString *)chartView:(ORLineChartView *)chartView titleForHorizontalAtIndex:(NSInteger)index{
    return @"";
}

- (NSInteger)numberOfHorizontalDataOfChartView:(ORLineChartView *)chartView {
    return _datas.count;
}

- (CGFloat)chartView:(ORLineChartView *)chartView valueForHorizontalAtIndex:(NSInteger)index {
    return [_datas[index] doubleValue];
}

- (NSInteger)numberOfVerticalLinesOfChartView:(ORLineChartView *)chartView {
    return 4;
}

- (NSAttributedString *)chartView:(ORLineChartView *)chartView attributedStringForIndicaterAtIndex:(NSInteger)index {
    NSAttributedString *string = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"value: %g", [_datas[index] doubleValue]]];
    return string;
}

- (NSDictionary<NSAttributedStringKey,id> *)labelAttrbutesForVerticalOfChartView:(ORLineChartView *)chartView {
    return @{NSFontAttributeName : [UIFont systemFontOfSize:12], NSForegroundColorAttributeName : [UIColor redColor]};
}

- (NSDictionary<NSAttributedStringKey,id> *)labelAttrbutesForHorizontalOfChartView:(ORLineChartView *)chartView {
    return @{NSFontAttributeName : [UIFont systemFontOfSize:12], NSForegroundColorAttributeName : [UIColor blueColor]};
}

////custom left values
//- (CGFloat)chartView:(ORLineChartView *)chartView valueOfVerticalSeparateAtIndex:(NSInteger)index {
//    NSArray *number1 = @[@(0),@(0.2),@(0.4),@(0.6),@(0.8),@(0.10)];
//    return [number1[index] doubleValue];
//}

@end
