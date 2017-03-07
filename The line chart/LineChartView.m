//
//  LineChartView.m
//  ecmc
//
//  Created by 王文杰 on 16/1/5.
//  Copyright © 2016年 cp9. All rights reserved.
//

#import "LineChartView.h"

@implementation LineChartView
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void)drawRect:(CGRect)rect {
    
    [self costArray:_valueArray monthArray:_monthArray pitchmonth:_pitchmonth];
}
- (void)costArray:(NSArray *)cost monthArray:(NSArray *)month pitchmonth:(NSString *)pitchmonth {
    
    //绘制坐标系
    for (int i=0; i<4; i++) {
        // 创建path
        UIColor *color = [UIColor colorWithRed:198/255.0 green:237/255.0 blue:249/255.0 alpha:1];
        [color set]; //设置线条颜色
        UIBezierPath *x = [UIBezierPath bezierPath];
        // 添加路径[1条点(100,100)到点(200,100)的线段]到path
        [x moveToPoint:CGPointMake(20 , i*45+25)];
        [x addLineToPoint:CGPointMake(self.window.bounds.size.width-20, i*45+25)];
        // 将path绘制出来
        [x stroke];
    }
    for (int i=0; i<6; i++) {
        // 创建path
        UIColor *color = [UIColor colorWithRed:198/255.0 green:237/255.0 blue:249/255.0 alpha:1];
        [color set]; //设置线条颜色
        UIBezierPath *y = [UIBezierPath bezierPath];
        // 添加路径[1条点(100,100)到点(200,100)的线段]到path
        [y moveToPoint:CGPointMake(50+((self.window.bounds.size.width-100)/5)*i , 0)];
        [y addLineToPoint:CGPointMake(50+((self.window.bounds.size.width-100)/5)*i, 160)];
        // 将path绘制出来
        [y stroke];
    }
    
    //绘制折线走势
    if (cost.count > 0 || month.count > 0) {
        float max = [[cost valueForKeyPath:@"@max.intValue"] floatValue];
        float value = 135/max;
        
        UIBezierPath *Polyline = [UIBezierPath bezierPath];
        for (int i = 0; i<cost.count-1; i++) {

            // 添加路径[1条点(100,100)开始增结束减开始和结束总和100到点(200,100)开始增结束减开始和结束总和320的线段]到path
            [Polyline moveToPoint:CGPointMake(50+((self.window.bounds.size.width-100)/5)*i , 160-([cost[i] floatValue]*value))];
            [Polyline addLineToPoint:CGPointMake(50+((self.window.bounds.size.width-100)/5)*(i+1), 160-([cost[i+1] floatValue]*value))];
            //设置线条宽度
            Polyline.lineWidth = 0.5;
            //设置颜色
            [[UIColor clearColor] set];
            // 将path绘制出来
            [Polyline stroke];
            
        }
        
        
        //添加CAShapeLayer
        CAShapeLayer *shapeLine = [[CAShapeLayer alloc]init];
        //设置颜色
        shapeLine.strokeColor = [UIColor colorWithRed:26/255.0 green:181/255.0 blue:232/255.0 alpha:1].CGColor;
        //设置宽度
        shapeLine.lineWidth = 0.5;
        //把CAShapeLayer添加到当前视图CAShapeLayer
        [self.layer addSublayer:shapeLine];
        //把Polyline的路径赋予shapeLine
        shapeLine.path = Polyline.CGPath;
        
        //开始添加动画
        [CATransaction begin];
        //创建一个strokeEnd路径的动画
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        //动画时间
        pathAnimation.duration = 3.0;
        //添加动画样式
        pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        //动画起点
        pathAnimation.fromValue = @0.0f;
        //动画停止位置
        pathAnimation.toValue   = @1.0f;
        //把动画添加到CAShapeLayer
        [shapeLine addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
        //动画终点
        shapeLine.strokeEnd = 1.0;
        //结束动画
        [CATransaction commit];
        
        for (int i = 0; i<cost.count; i++) {
            //坐标数值;
            UILabel * costValueLb = [[UILabel alloc]initWithFrame:CGRectMake(25+((self.bounds.size.width-100)/5)*i, 135-([cost[i] floatValue]*value), 50, 15)];
            costValueLb.text = [NSString stringWithFormat:@"%@",cost[i]];
            costValueLb.font = [UIFont systemFontOfSize:12];
            costValueLb.textAlignment = NSTextAlignmentCenter;
            [self addSubview:costValueLb];
            
            //坐标圆点;
            UIView * cercle = [[UIView alloc]initWithFrame:CGRectMake(45+((self.bounds.size.width-100)/5)*i, 155-([cost[i] floatValue]*value),10, 10)];
            cercle.layer.cornerRadius = 5;
            [self addSubview:cercle];
            
            //月份;
            UILabel * monthLb = [[UILabel alloc]initWithFrame:CGRectMake(25+((self.bounds.size.width-100)/5)*i, 170, 50, 20)];
            monthLb.text = [NSString stringWithFormat:@"%@",month[i]];
            monthLb.textAlignment = NSTextAlignmentCenter;
            [self addSubview:monthLb];

            costValueLb.textColor = [UIColor blackColor];
            cercle.backgroundColor = [UIColor colorWithRed:26/255.0 green:181/255.0 blue:232/255.0 alpha:1];
            monthLb.textColor = [UIColor blackColor];

        }

    }
}

@end


