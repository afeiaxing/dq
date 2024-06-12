//
//  AXMatchStandingPolylineView.m
//  QYZY
//
//  Created by 22 on 2024/5/25.
//

#import "AXMatchStandingPolylineView.h"
#import "AXDashedLineView.h"

@interface AXMatchStandingPolylineView()

@property (nonatomic, assign) NSInteger maxScoreDiff;
@property (nonatomic, assign) BOOL isHostLeadFirst;
@property (nonatomic, strong) NSArray *dashedLines;
@property (nonatomic, strong) NSMutableArray *layerArray;

@end

#define kAXMatchStandingPolylineViewMarginRight 40
#define kAXMatchStandingPolylineViewMarginV 4

@implementation AXMatchStandingPolylineView

// MARK: lifecycle
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    NSMutableArray *temp = [NSMutableArray array];
    CGFloat dashedLineMargin = (self.bounds.size.width - kAXMatchStandingPolylineViewMarginRight) / 4;
    for (int i = 0; i < 5; i++) {
        AXDashedLineView *dashedLine = [AXDashedLineView new];
        [self addSubview:dashedLine];
        [temp addObject:dashedLine];
        [temp mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(dashedLineMargin * i);
            make.top.bottom.offset(0);
            make.width.mas_equalTo(1);
        }];
    }
    
    self.dashedLines = temp.copy;
}

// MARK: private
- (void)handleDrawAxis: (NSArray *)array{
    UIView *line = [UIView new];
    line.backgroundColor = UIColor.lightGrayColor;
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.height.mas_equalTo(1);
        make.right.offset(-kAXMatchStandingPolylineViewMarginRight);
        make.centerY.offset(0);
    }];
    
    // 判断是主队先领先，还是客队先领先
    for (NSNumber *num in array) {
        if (num.intValue != 0) {
            self.isHostLeadFirst = num.intValue > 0;
            break;
        }
    }
    
    int maxScoreDiff = 0;
    for (NSNumber *scoreDiff in array) {
        if (abs(scoreDiff.intValue) > maxScoreDiff) {
            maxScoreDiff = abs(scoreDiff.intValue);
        }
    }
    self.maxScoreDiff = maxScoreDiff;
    
    NSMutableArray *labels = [NSMutableArray array];
    for (int i = 0; i < 3; i++) {
        UILabel *label = [UILabel new];
        label.backgroundColor = rgb(255, 247, 239);
        label.layer.cornerRadius = 4;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = AXSelectColor;
        label.font = [UIFont systemFontOfSize:10];
        
        if (i == 0) {
            label.text = [NSString stringWithFormat:@"+%d", maxScoreDiff];
        } else if (i == 1) {
            label.text = @"±0";
        } else {
            label.text = [NSString stringWithFormat:@"-%d", maxScoreDiff];
        }
        [self addSubview:label];
        [labels addObject:label];
    }
    
    [labels mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedItemLength:18 leadSpacing:3 tailSpacing:3];
    [labels mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(21);
        make.left.equalTo(line.mas_right).offset(4);
    }];
}

- (void)handleDrawPolyline: (NSArray *)array{
    // 去除数组中的"0"
    NSMutableArray *temp = [NSMutableArray array];
    for (NSNumber *num in array) {
        if (num.intValue != 0) {
            [temp addObject:num];
        }
    }
    NSArray *scoreDiff = temp.copy;
    
    NSNumber *first = scoreDiff.firstObject;
    BOOL isHomeLead = first.intValue > 0;
    
    int totalCount = 0;
    
    // 处理分差数组，将主队领先、客队领先分别分组，并且在每组的最后加“0”
    NSMutableArray *sectionArr = [NSMutableArray array];
    NSMutableArray *arr1 = [NSMutableArray array];
    for (int i = 0; i < scoreDiff.count; i++) {
        NSNumber *num = scoreDiff[i];
        if ((isHomeLead && num.intValue > 0) || (!isHomeLead && num.intValue < 0)) {
            [arr1 addObject:num];
        } else {
            if (num.intValue != 0) {
                [arr1 addObject:@0];
                totalCount++;
            }
            [sectionArr addObject:arr1];
            arr1 = [NSMutableArray array];
            [arr1 addObject:num];
            isHomeLead = !isHomeLead;
        }
        totalCount++;
        
        if (i == scoreDiff.count - 1) {
            [arr1 addObject:@0];
        }
    }
    [sectionArr addObject:arr1];
    
    // 移除之前画的折线
    for (CAShapeLayer *shapeLayer in self.layerArray) {
        [shapeLayer removeFromSuperlayer];
    }
    [self.layerArray removeAllObjects];
    
    // 划折线
    CGFloat screenW = self.bounds.size.width;
    CGFloat screenH = self.bounds.size.height;
    CGFloat originX = 0;
    CGFloat ViewW = screenW - originX - kAXMatchStandingPolylineViewMarginRight;
    int matchStatus = self.matchModel.leaguesStatus.intValue;
    
    // 进行中的赛事，按照赛事进行的时间，来计算视图的宽度
    if (matchStatus > 1 && matchStatus < 10) {
        CGFloat currentSec = self.matchModel.residualTime.floatValue;
        CGFloat totalSec = 12 * 4 * 60;  // 全场时间按照4节，一节12分钟算
        CGFloat currentPrecent = MIN(currentSec / totalSec, 1.0);
        ViewW = ViewW * currentPrecent;
    }
    
    CGFloat offSetX = ViewW / totalCount;  // 间隔需要兼容进行中的赛事，根据self.matchModel的比赛状态来
    CGFloat originY = screenH / 2;
    CGFloat minY = ((screenH - kAXMatchStandingPolylineViewMarginV * 2) / 2) / self.maxScoreDiff;
    
    int index = 0;
    for (int i = 0; i < sectionArr.count; i++) {
        NSArray *arr = sectionArr[i];
        
        CGFloat posX = originX + offSetX * index;
        if (i != 0) {
            posX -= offSetX;  // 将后面的折线往前挪一个宽度
        }
        
        CGPoint startPoint = CGPointMake(posX, originY);
        UIBezierPath *path = [[UIBezierPath alloc]init];
        [path moveToPoint:startPoint];
        
        for (int j = 0; j < arr.count; j++) {
            NSNumber *scoreD = arr[j];
            CGFloat x = originX + offSetX * index;
            if ((i == sectionArr.count - 1) && (j == arr.count -1)) {
                x -= offSetX;   // 最后一个点，X轴然回移一个单位
            }
            CGFloat y = originY - scoreD.floatValue * minY;
            CGPoint point = CGPointMake(x, y);
            [path addLineToPoint:point];
            
            index++;
        }
        
        // 创建 shapeLayer
        CAShapeLayer *shapeLayer = [[CAShapeLayer alloc]init];
        [self.layer addSublayer:shapeLayer];
        [self.layerArray addObject:shapeLayer];
        shapeLayer.path = path.CGPath;
        CGFloat layerHeight = self.bounds.size.height / 2;
        UIColor *hostGradientColor = [UIColor colorWithGradientFromColor:rgba(143, 0, 255, 0.5) toColor:rgba(143, 0, 255, 0) withHeight:layerHeight];
        UIColor *awayGradientColor = [UIColor colorWithGradientFromColor:rgba(0, 162, 36, 0) toColor:rgba(0, 162, 36, 0.5) withHeight:layerHeight];

        /**
         * 主队领先用紫色，客队领先用绿色
         * 主队先领先，偶数：紫色，单数：绿色
         * 客队先领先，偶数：绿色，单数：紫色
         */
        UIColor *purpleFillColor = [UIColor colorWithGradientFromColor:rgba(143, 0, 255, 0.5) toColor:rgba(143, 0, 255, 0) withHeight:layerHeight];
        UIColor *purpleStrokeColor = rgb(143, 0, 255);
        UIColor *greenFillColor = [UIColor colorWithGradientFromColor:rgba(0, 162, 36, 0) toColor:rgba(0, 162, 36, 0.5) withHeight:layerHeight];
        UIColor *greenStrokeColor = rgb(0, 162, 36);

        struct CGColor *fillColor;
        struct CGColor *strokeColor;
        if (self.isHostLeadFirst) {
            fillColor = i % 2 == 0 ? purpleFillColor.CGColor : greenFillColor.CGColor;
            strokeColor = i % 2 == 0 ? purpleStrokeColor.CGColor : greenStrokeColor.CGColor;
        } else {
            fillColor = i % 2 == 0 ? greenFillColor.CGColor : purpleFillColor.CGColor;
            strokeColor = i % 2 == 0 ? greenStrokeColor.CGColor : purpleStrokeColor.CGColor;
        }
        
        shapeLayer.fillColor = fillColor;
        shapeLayer.strokeColor = strokeColor;
        shapeLayer.lineWidth = 1;
    }
    
    // 将虚线移动到顶部
    for (UIView *dashedView in self.dashedLines) {
        [self bringSubviewToFront:dashedView];
    }
}

// MARK: setter & getter
- (void)setScoreDiffs:(NSArray *)scoreDiffs{
    [self handleDrawAxis:scoreDiffs];
    [self handleDrawPolyline:scoreDiffs];
}

- (NSMutableArray *)layerArray{
    if (!_layerArray) {
        _layerArray = [NSMutableArray array];
    }
    return _layerArray;
}

@end
