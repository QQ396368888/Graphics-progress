//
//  WaterView.m
//  ecmc
//
//  Created by 王文杰 on 16/10/10.
//  Copyright © 2016年 cp9. All rights reserved.
//

#import "WaterView.h"
@implementation WaterView{
    
    float _currentLinePointY;
    
    float a;
    float b;
    
    BOOL jia;

}

- (void)drawRect:(CGRect)rect {

    [self Createwater:rect];

}
- (id)initWithFrame:(CGRect)frame withHigh:(NSInteger)high
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        a = 1;
        b = 0;
        jia = NO;
        
        _currentLinePointY = high;
        _percent = 0.5;
        
        [NSTimer scheduledTimerWithTimeInterval:0.04 target:self selector:@selector(animateWave) userInfo:nil repeats:YES];
        
    }
    return self;
}
-(void)animateWave
{
    if (jia) {
        a += 0.01;
    }else{
        a -= 0.01;
    }
    
    if (a<=1) {
        jia = YES;
    }
    
    if (a>=1.5) {
        jia = NO;
    }
    
    
    b+=0.1;
    
    [self setNeedsDisplay];
}

- (void)Createwater:(CGRect)rect
{
    UIColor *blue = [UIColor colorWithRed:117/255.0 green:210/255.0 blue:249/255.0 alpha:0.7];//水的颜色
    
    UIColor *blueother =[UIColor colorWithRed:117/255.0 green:210/255.0 blue:249/255.0 alpha:0.5];//水面的

    UIBezierPath * path = [UIBezierPath bezierPath];
    path.lineWidth = 1;
    
    [path moveToPoint:CGPointMake(0, _currentLinePointY)];
    _currentLinePointY = rect.size.height * (1 - _percent);
    float y=_currentLinePointY;
    if (_isopen == YES) {
        
        [blue set];
        
        for(float x=0;x<=rect.size.width;x++){
            y= a * sin( x/180*M_PI + 4*b/M_PI ) * 3 + _currentLinePointY;
            [path addLineToPoint:CGPointMake(x, y)];
        }
    }else{
        [blueother set];
        for(float x=0;x<=rect.size.width;x++){
            y= a * cos( x/180*M_PI + 4*b/M_PI ) * 3 + _currentLinePointY;
            [path addLineToPoint:CGPointMake(x, y )];
        }
    }
    
    [path addLineToPoint:CGPointMake(rect.size.width, rect.size.height)];
    [path addLineToPoint:CGPointMake(0, rect.size.height)];
    
    [path addLineToPoint:CGPointMake(0, _currentLinePointY)];
    
    [path fill];
}
- (void)setPercent:(float)percent
{
    _percent = percent;
    [self setNeedsDisplay];
}


@end
