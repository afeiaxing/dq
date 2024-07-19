//
//  ORLineChartView.m
//  ORChartView
//
//  Created by OrangesAL on 2019/5/1.
//  Copyright © 2019年 OrangesAL. All rights reserved.
//

#import "ORLineChartView.h"
#import "ORLineChartCell.h"
#import "ORChartUtilities.h"
#import "ORLineChartValue.h"

@implementation NSObject (ORLineChartView)

- (NSInteger)numberOfVerticalLinesOfChartView:(ORLineChartView *)chartView {return 5;};

- (id)chartView:(ORLineChartView *)chartView titleForHorizontalAtIndex:(NSInteger)index {
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"MM-dd";
    NSDate *date = [[NSDate date] dateByAddingTimeInterval:index * 24 * 60 * 60];
    return [formatter stringFromDate:date];
};

- (NSDictionary<NSAttributedStringKey,id> *)labelAttrbutesForHorizontalOfChartView:(ORLineChartView *)chartView {
    return @{NSFontAttributeName : [UIFont systemFontOfSize:12]};
}
- (NSDictionary<NSAttributedStringKey,id> *)labelAttrbutesForVerticalOfChartView:(ORLineChartView *)chartView {
    return @{NSFontAttributeName : [UIFont systemFontOfSize:12]};
}

- (NSAttributedString *)chartView:(ORLineChartView *)chartView attributedStringForIndicaterAtIndex:(NSInteger)index {return nil;}

- (void)chartView:(ORLineChartView *)chartView didSelectValueAtIndex:(NSInteger)index {}

@end


#pragma mark - ORLineChartView
@interface ORLineChartView ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource> {

}

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray <UILabel *>*leftLabels;

@property (nonatomic, strong) NSMutableArray <ORLineChartHorizontal *>*horizontalDatas;

@property (nonatomic, strong) ORLineChartConfig *config;
@property (nonatomic, strong) ORLineChartValue *lineChartValue;
@property (nonatomic, strong) CAShapeLayer *bottomLineLayer;
@property (nonatomic, strong) CAShapeLayer *bgLineLayer;

@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@property (nonatomic, strong) CAShapeLayer *closeLayer;

@property (nonatomic, strong) CAShapeLayer *lineLayer;
@property (nonatomic, strong) CAShapeLayer *shadowLineLayer;

@property (nonatomic, strong) CAShapeLayer *circleLayer;

@property (nonatomic, strong) CALayer *animationLayer;

@property (nonatomic, strong) CALayer *contenLayer;

@property (nonatomic, assign) CGFloat bottomTextHeight;


@end

@implementation ORLineChartView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self _or_initData];
        [self _or_initUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _or_initData];
        [self _or_initUI];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self _or_layoutSubviews];
}

- (void)_or_initUI {
    
    self.backgroundColor = [UIColor whiteColor];
    
    _collectionView = ({
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor clearColor];
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.scrollsToTop = NO;
        [collectionView registerClass:[ORLineChartCell class] forCellWithReuseIdentifier:NSStringFromClass([ORLineChartCell class])];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView;
    });
    [self addSubview:_collectionView];
    
    _bgLineLayer = [CAShapeLayer layer];
    [self.layer addSublayer:_bgLineLayer];
    
    _bottomLineLayer = [CAShapeLayer layer];
    [self.layer addSublayer:_bottomLineLayer];
    
    _gradientLayer = ({
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(0, 1);
        gradientLayer.masksToBounds = YES;
//        gradientLayer.locations = @[@(0.5f)];
        gradientLayer;
    });
    _closeLayer = [ORChartUtilities or_shapelayerWithLineWidth:1 strokeColor:nil];
    _closeLayer.fillColor = [UIColor blueColor].CGColor;
    
    CALayer *baseLayer = [CALayer layer];
    [baseLayer addSublayer:_gradientLayer];
    [baseLayer setMask:_closeLayer];
    _contenLayer = baseLayer;
    [_collectionView.layer addSublayer:baseLayer];
    
    _lineLayer = [ORChartUtilities or_shapelayerWithLineWidth:1 strokeColor:nil];
    [_collectionView.layer addSublayer:_lineLayer];
    
    _shadowLineLayer = [ORChartUtilities or_shapelayerWithLineWidth:1 strokeColor:nil];
    [_collectionView.layer addSublayer:_shadowLineLayer];
    
    _animationLayer = ({
        CALayer *layer = [CALayer new];
        layer.backgroundColor = [UIColor clearColor].CGColor;
        layer.speed = 0.0f;
        layer;
    });
    [_collectionView.layer addSublayer:_animationLayer];

}

- (void)_or_initData {
    _leftLabels = [NSMutableArray array];
    _horizontalDatas = [NSMutableArray array];
    _config = [ORLineChartConfig new];
}

- (void)_or_configChart {
    
    _lineLayer.strokeColor = _config.chartLineColor.CGColor;
    _shadowLineLayer.strokeColor = _config.shadowLineColor.CGColor;
    _lineLayer.lineWidth = _config.chartLineWidth;
    _shadowLineLayer.lineWidth = _config.chartLineWidth * 0.8;
    _shadowLineLayer.hidden = !_config.showShadowLine;
    
    _gradientLayer.colors = _config.gradientCGColors;
    _gradientLayer.locations = _config.gradientLocations;
    
    _bgLineLayer.strokeColor = _config.bgLineColor.CGColor;
    _bgLineLayer.lineDashPattern = @[@(1.5), @(_config.dottedBGLine ? 3 : 0)];
    _bgLineLayer.lineWidth = _config.bglineWidth;
    
    _bgLineLayer.hidden = !_config.showHorizontalBgline;
    
    _bottomLineLayer.strokeColor = _config.bgLineColor.CGColor;
    _bottomLineLayer.lineWidth = _config.bglineWidth;
    
    if (self.horizontalDatas.count > 0) {
        _bottomTextHeight = [self.horizontalDatas.firstObject.title boundingRectWithSize:CGSizeMake(_config.bottomLabelWidth, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading context:nil].size.height + _config.bottomLabelInset;
    }
    
    
    [self.collectionView reloadData];
    [self setNeedsLayout];
}

- (void)_or_layoutSubviews {
    
    if (self.horizontalDatas.count == 0) {
        return;
    }
    
    self.collectionView.frame = CGRectMake(_config.leftWidth,
                                           _config.topInset,
                                           self.bounds.size.width - _config.leftWidth,
                                           self.bounds.size.height - _config.topInset - _config.bottomInset);
        
    _gradientLayer.frame = CGRectMake(0, 0, 0, self.collectionView.bounds.size.height);

    CGFloat height = self.collectionView.bounds.size.height;
    
    CGFloat labelHeight = (height - _bottomTextHeight) / (self.leftLabels.count - 1);
    
    CGFloat labelInset = 0;
    
    
    if (self.leftLabels.count > 0) {
        
        [self.leftLabels.firstObject sizeToFit];
        labelInset = labelHeight - self.leftLabels.firstObject.bounds.size.height;
        labelHeight =  self.leftLabels.firstObject.bounds.size.height;
    }
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [self.leftLabels enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        obj.frame = CGRectMake(0, self.bounds.size.height - self.bottomTextHeight - self.config.bottomInset - labelHeight * 0.5   - (labelHeight + labelInset) * idx, self.config.leftWidth, labelHeight);
        
        if (idx > 0) {
            [path moveToPoint:CGPointMake(self.config.leftWidth, obj.center.y)];
            [path addLineToPoint:CGPointMake(self.bounds.size.width, obj.center.y)];
        }else {
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(self.config.leftWidth, obj.center.y)];
            [path addLineToPoint:CGPointMake(self.bounds.size.width, obj.center.y)];
            self.bottomLineLayer.path = path.CGPath;
        }
    }];
    
    _bgLineLayer.path = path.CGPath;
    
    CGFloat ratio = (self.lineChartValue.max == self.lineChartValue.min) ? (float)1 :(CGFloat)(self.lineChartValue.min - self.lineChartValue.max);

    NSMutableArray *points = [NSMutableArray array];
    
    CGFloat maxX = _config.bottomLabelWidth * _horizontalDatas.count + _collectionView.contentInset.right;
    
    [self.horizontalDatas enumerateObjectsUsingBlock:^(ORLineChartHorizontal * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        

        CGFloat y = ORInterpolation(0, height - self.bottomTextHeight, (obj.value - self.lineChartValue.max) / ratio);
        
        if (idx == 0) {
            [points addObject:[NSValue valueWithCGPoint:CGPointMake(-self.collectionView.contentInset.left, y)]];
        }
        
        CGPoint center = CGPointMake(self.config.bottomLabelWidth * 0.5 + idx * self.config.bottomLabelWidth, y);
        
        [points addObject:[NSValue valueWithCGPoint:center]];
    
        
        if (idx == self.horizontalDatas.count - 1) {
            [points addObject:[NSValue valueWithCGPoint:CGPointMake(maxX, y)]];
        }
    }];
    
    BOOL isCurve = !self.config.isBreakLine;
    
    UIBezierPath *linePath = [ORChartUtilities or_pathWithPoints:points isCurve:isCurve];
    _lineLayer.path = [linePath.copy CGPath];
    
    [linePath applyTransform:CGAffineTransformMakeTranslation(0, 8)];
    _shadowLineLayer.path = [linePath.copy CGPath];
    
    _closeLayer.path = [ORChartUtilities or_closePathWithPoints:points isCurve:isCurve maxY: height - self.bottomTextHeight].CGPath;
    
    
    [points removeLastObject];
    [points removeObjectAtIndex:0];

    UIBezierPath *ainmationPath = [ORChartUtilities or_pathWithPoints:points isCurve:isCurve];
    
    _animationLayer.timeOffset = 0.0;
    
    [ainmationPath applyTransform:CGAffineTransformMakeTranslation(0, 0)];

    
    
    if (_config.animateDuration > 0) {
        [_lineLayer addAnimation:[ORChartUtilities or_strokeAnimationWithDurantion:_config.animateDuration] forKey:nil];
        [_shadowLineLayer addAnimation:[ORChartUtilities or_strokeAnimationWithDurantion:_config.animateDuration] forKey:nil];
        
        CABasicAnimation *anmi1 = [CABasicAnimation animation];
        anmi1.keyPath = @"bounds.size.width";
        anmi1.duration = _config.animateDuration;
        anmi1.toValue = @(maxX * 2);
        
        anmi1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        anmi1.fillMode = kCAFillModeForwards;
        anmi1.autoreverses = NO;
        anmi1.removedOnCompletion = NO;
        [_gradientLayer addAnimation:anmi1 forKey:@"bw"];
    }else {
        _gradientLayer.bounds = CGRectMake(0, 0, maxX * 2, self.collectionView.bounds.size.height);
    }
    
}

- (void)reloadData {
    
    if (!_dataSource) {
        return;
    }
    
    NSInteger items = [_dataSource numberOfHorizontalDataOfChartView:self];
    
    [self.horizontalDatas removeAllObjects];
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    [CATransaction commit];

    if (items == 0) {
        [_collectionView reloadData];
        return;
    }
    
    for (int i = 0; i < items; i ++) {
        
        ORLineChartHorizontal *horizontal = [ORLineChartHorizontal new];
        horizontal.value = [_dataSource chartView:self valueForHorizontalAtIndex:i];
        
        horizontal.title = [[NSAttributedString alloc] initWithString:[_dataSource chartView:self titleForHorizontalAtIndex:i] attributes:[_dataSource labelAttrbutesForHorizontalOfChartView:self]];
        
        [self.horizontalDatas addObject:horizontal];
    }
    
    NSInteger vertical = [_dataSource numberOfVerticalLinesOfChartView:self];
    
    if ([self.dataSource respondsToSelector:@selector(chartView:valueOfVerticalSeparateAtIndex:)]) {
        
        NSMutableArray *values = [NSMutableArray arrayWithCapacity:vertical];
        for (int i = 0; i < vertical; i ++) {
            [values addObject:@([self.dataSource chartView:self valueOfVerticalSeparateAtIndex:i])];
        }
        _lineChartValue = [[ORLineChartValue alloc] initWithData:values];
    }else {
        _lineChartValue = [[ORLineChartValue alloc] initWithHorizontalData:self.horizontalDatas numberWithSeparate:vertical];
    }
    
    if (self.leftLabels.count > vertical) {
        for (NSInteger i = vertical; i < _leftLabels.count; i ++) {
            UILabel *label = _leftLabels[i];
            [label removeFromSuperview];
            [_leftLabels removeObject:label];
        }
    }else if (self.leftLabels.count < vertical) {
        for (NSInteger i = self.leftLabels.count; i < vertical; i ++) {
            UILabel *label = [UILabel new];
            label.textAlignment = NSTextAlignmentCenter;
            [_leftLabels addObject:label];
            [self addSubview:label];
        }
    }
    
    [self.leftLabels enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSString *value = self.lineChartValue.isDecimal ? [NSString stringWithFormat:@"%.2lf", self.lineChartValue.separatedValues[idx].doubleValue] : [NSString stringWithFormat:@"%.0lf", self.lineChartValue.separatedValues[idx].doubleValue];
        
        obj.attributedText = [[NSAttributedString alloc] initWithString:value attributes:[self.dataSource labelAttrbutesForVerticalOfChartView:self]];
    }];
    
    
    NSAttributedString *lastTitle = [_dataSource chartView:self attributedStringForIndicaterAtIndex:items - 1];
    if (!lastTitle) {
        lastTitle = self.leftLabels.firstObject.attributedText;
    }
    
    NSAttributedString *title = [_dataSource chartView:self attributedStringForIndicaterAtIndex:0];
    if (!title) {
        title = self.leftLabels.firstObject.attributedText;
    }

    
    [self _or_configChart];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.horizontalDatas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ORLineChartCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ORLineChartCell class]) forIndexPath:indexPath];
    cell.title = self.horizontalDatas[indexPath.row].title;
    cell.config = self.config;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(_config.bottomLabelWidth, collectionView.bounds.size.height);//collectionView.bounds.size.height
}

- (void)setDataSource:(id<ORLineChartViewDataSource>)dataSource {
    if (_dataSource != dataSource) {
        _dataSource = dataSource;
        if (_dataSource) {
            [self reloadData];
        }
    }
}

- (void)setConfig:(ORLineChartConfig *)config {
    if (_config != config) {
        _config = config;
        if (_dataSource) {
            [self _or_configChart];
        }
    }
}



@end
