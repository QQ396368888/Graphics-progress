//
//  BillQueryView.m
//  ecmc
//
//  Created by 王文杰 on 16/1/5.
//  Copyright © 2016年 cp9. All rights reserved.
//

#import "RainbowView.h"
#import "RainbowView.h"
@implementation RainbowView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _progressLayer = [CAShapeLayer new];
        [self.layer addSublayer:_progressLayer];
        _progressLayer.fillColor = nil;
        _progressLayer.lineCap = kCALineCapRound;
        _progressLayer.frame = self.bounds;
        
        //默认5
        self.progressWidth = 5;
    }
    return self;
}
- (void)setProgress
{
    if (_progress ==0) {
        _progressPath = [UIBezierPath bezierPathWithArcCenter:(CGPointMake(self.center.x, 0)) radius:130 startAngle:M_PI endAngle:M_PI clockwise:YES];
        _progressLayer.path = _progressPath.CGPath;
    }else{
        _progressPath = [UIBezierPath bezierPathWithArcCenter:(CGPointMake(self.center.x, 0)) radius:130 startAngle:M_PI endAngle:(M_PI * _progress - M_PI) clockwise:YES];
        _progressLayer.path = _progressPath.CGPath;
    
    }
}

//设置进度条的宽度
- (void)setProgressWidth:(float)progressWidth
{
    _progressWidth = progressWidth;
    _progressLayer.lineWidth = _progressWidth;
    
    [self setProgress];
}


- (void)setProgressColor:(UIColor *)progressColor
{
    _progressLayer.strokeColor = progressColor.CGColor;
}

//设置进度
- (void)setProgress:(float)progress
{

    _progress = progress;
    
    [self setProgress];
}

- (void)setProgress:(float)progress animated:(BOOL)animated
{
    [self setProgress:progress];
    
    // 给这个layer添加动画效果
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    
    pathAnimation.duration = progress;
    
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    
    [_progressLayer addAnimation:pathAnimation forKey:nil];
    
}


@end

