//
//  AXDataBaseViewController.m
//  QYZY
//
//  Created by 22 on 5/24/24.
//

#import "AXDataBaseViewController.h"

@interface AXDataBaseViewController ()

@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@property (nonatomic, strong) CAShapeLayer *lineLayer;

@end

static CGFloat KTopSpaceValue = 20.0f;
static CGFloat KBottomSpaceValue = 34.0f;

@implementation AXDataBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    UIView *testView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    testView.backgroundColor = [UIColor colorWithGradientFromColor:rgba(143, 0, 255, 0.5) toColor:rgba(143, 0, 255, 0) withHeight:100];
    [self.view addSubview:testView];
    
    _gradientLayer = [CAGradientLayer layer];
    NSArray *colors = @[(__bridge id)rgba(143, 0, 255, 1).CGColor,
                        (__bridge id)rgba(143, 0, 255, 0).CGColor,
                        (__bridge id)[UIColor whiteColor].CGColor];
    _gradientLayer.colors = colors;
    _gradientLayer.locations = @[@0.0,@0.5,@1.0];
    _gradientLayer.startPoint = CGPointMake(0.5,0.0);
    _gradientLayer.endPoint = CGPointMake(0.5,1.0);
    _gradientLayer.opacity = 0.5;
    [self.view.layer addSublayer:_gradientLayer];
    
    _lineLayer = [CAShapeLayer layer];
    _lineLayer.allowsEdgeAntialiasing = YES;
    _lineLayer.strokeColor = rgb(255, 66, 117).CGColor;
    _lineLayer.fillColor = [UIColor clearColor].CGColor;
    _lineLayer.lineWidth = 2.0;
    _lineLayer.lineJoin = kCALineJoinRound;
    _lineLayer.lineCap = kCALineCapRound;
    [self.view.layer addSublayer:_lineLayer];
    
    
    _lineLayer.frame = self.view.bounds;
    _gradientLayer.frame = self.view.bounds;

    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    CGFloat firstPointY = 100;
    CGFloat lastPointY = 500;
    NSLog(@"first: %.2f   last: %.2f", firstPointY, lastPointY);
    
    UIBezierPath *gradientPath = [UIBezierPath bezierPath];
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    [gradientPath moveToPoint:CGPointMake(-1, firstPointY)];
    [linePath moveToPoint:CGPointMake(0, firstPointY)];
    
    NSArray *temp = @[@150, @180, @170, @200, @210, @300, @250, @400, @500, @350];
    NSUInteger count = temp.count;
    CGFloat superWidth =  CGRectGetWidth(self.view.frame);
    CGFloat itemWidth = superWidth / count;
    
    for (int index = 0; index < count; index++){
        NSNumber *num = temp[index];
        CGFloat pointY = num.floatValue;
        CGPoint pathPoint = CGPointMake((index + 1)*itemWidth, pointY);
        [gradientPath addLineToPoint:pathPoint];
        [linePath addLineToPoint:pathPoint];
    }
    
    [gradientPath addLineToPoint:CGPointMake(width+1, lastPointY)];
    [linePath addLineToPoint:CGPointMake(width, lastPointY)];
    
    // 构造渐变闭环
    [gradientPath addLineToPoint:CGPointMake(width+1, height - KBottomSpaceValue)];
    [gradientPath addLineToPoint:CGPointMake(-1, height - KBottomSpaceValue)];
    [gradientPath addLineToPoint:CGPointMake(-1, firstPointY)];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = gradientPath.CGPath;
    _gradientLayer.mask = shapeLayer;
    _lineLayer.path = linePath.CGPath;
    
}


// MARK: JXCategoryListContentViewDelegate
- (UIView *)listView {
    return self.view;
}

@end
