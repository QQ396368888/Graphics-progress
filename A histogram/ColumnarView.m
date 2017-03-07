//
//  ColumnarView.m
//  ecmc
//
//  Created by 王文杰 on 16/9/29.
//  Copyright © 2016年 cp9. All rights reserved.
//

#import "ColumnarView.h"
#define XWSCREENW [UIScreen mainScreen].bounds.size.width
@implementation ColumnarView{

    CGFloat titleHeight;

}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void)drawRect:(CGRect)rect {

    //画x轴
    for (int i = 0; i<=rect.size.height/10; i++) {
        UIBezierPath *Polyline = [UIBezierPath bezierPath];
        //设置起点
        [Polyline moveToPoint:CGPointMake(0, rect.size.height-i*rect.size.height/10-30)];
        //设置终点
        [Polyline addLineToPoint:CGPointMake(self.bounds.size.width,rect.size.height-i*rect.size.height/10-30)];
        //设置颜色
        [[UIColor lightGrayColor] set];
        //设置宽度
        Polyline.lineWidth = 0.2;
        //添加到画布
        [Polyline stroke];
    }
    //获取数据最大值
    float max = [[_valueArray valueForKeyPath:@"@max.intValue"] floatValue];
    //计算坐标比例
    float value = (rect.size.height-30-(rect.size.height/10))/max;
    //循环创建柱状图
    for (int i = 0; i<_valueArray.count; i++) {
        
        //柱状图值
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake((((XWSCREENW-(5*20+5*(XWSCREENW == 320 ? 25:40)))/2)+(i*20)+(i*(XWSCREENW == 320 ? 25:40)))-20, self.bounds.size.height-45-[[_valueArray objectAtIndex:i] floatValue]*value, 40, 20)];
        label.text = [NSString stringWithFormat:@"%@",[_valueArray objectAtIndex:i]];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:11];

        [self addSubview:label];
        
        //x轴坐标
        UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake((((XWSCREENW-(5*20+5*(XWSCREENW == 320 ? 25:40)))/2)+(i*20)+(i*(XWSCREENW == 320 ? 25:40)))-20, rect.size.height-25, 40, 20)];
        label1.text = [NSString stringWithFormat:@"%@",[_monthArray objectAtIndex:i]];
        label1.textAlignment = NSTextAlignmentCenter;
        label1.font = [UIFont systemFontOfSize:15];
 
        [self addSubview:label1];
        
        UIBezierPath *Polyline = [UIBezierPath bezierPath];
        //设置起点
        [Polyline moveToPoint:CGPointMake(((XWSCREENW-(5*20+5*(XWSCREENW == 320 ? 25:40)))/2)+(i*20)+(i*(XWSCREENW == 320 ? 25:40)), rect.size.height-30)];
        //设置终点
        [Polyline addLineToPoint:CGPointMake(((XWSCREENW-(5*20+5*(XWSCREENW == 320 ? 25:40)))/2)+(i*20)+(i*(XWSCREENW == 320 ? 25:40)),rect.size.height-30-[[_valueArray objectAtIndex:i] floatValue]*value)];
        //设置颜色
        [[UIColor clearColor] set];
        //设置宽度
        Polyline.lineWidth = 20;
        //添加到画布
        [Polyline stroke];
        
        //添加CAShapeLayer
        CAShapeLayer *shapeLine = [[CAShapeLayer alloc]init];
        //设置颜色
        if (i == _valueArray.count-1) {
            shapeLine.strokeColor = [UIColor colorWithRed:254/255.0 green:210/255.0 blue:161/255.0 alpha:0.8].CGColor;
        }else{
            shapeLine.strokeColor = [UIColor colorWithRed:0.400 green:1.000 blue:1.000 alpha:0.6].CGColor;
        }

        //设置宽度
        shapeLine.lineWidth = 20.0;
        //把CAShapeLayer添加到当前视图CAShapeLayer
        [self.layer addSublayer:shapeLine];
        //把Polyline的路径赋予shapeLine
        shapeLine.path = Polyline.CGPath;
        
        //开始添加动画
        [CATransaction begin];
        //创建一个strokeEnd路径的动画
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        //动画时间
        pathAnimation.duration = 2.0;
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
    }
 
 
}


@end
