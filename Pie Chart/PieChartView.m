//
//  PieChartView.m
//  测试
//
//  Created by 王文杰 on 2017/2/8.
//  Copyright © 2017年 王文杰. All rights reserved.
//

#import "PieChartView.h"
/*
 (值->角度->弧度)*值占饼图比例-弧度转移起始点。
 */
#define   DEGREES_TO_VALUE(degrees)  ((M_PI/180*degrees*360/100)-((M_PI * 90)/ 180))
#define   VALUE_TO_DEGREES(degrees)  (degrees*(360/100)/2)
//屏幕宽高
#define XWSCREENW [UIScreen mainScreen].bounds.size.width
#define XWSCREENH [UIScreen mainScreen].bounds.size.height
//饼状图半径
#define   PieChartRadius (XWSCREENW == 320?40:XWSCREENW == 375?45:50)
@implementation PieChartView{
    
    CGPoint ArcCentreCoordinate;
    
    CGPoint ARCCENTER;
    
    CGFloat start;
    
    CGFloat end;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        //饼状图圆心
        ARCCENTER = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);

        //饼状图起点
        start = M_PI*1.5/M_PI/180/360;
    }
    return self;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
-(void)setArcCentreCoordinateAll:(NSArray *)ArcCentreCoordinateAll{

    
    _ArcCentreCoordinateAll = ArcCentreCoordinateAll;
    
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    NSArray * RedAarray = @[@"46",@"255",@"62",@"254",@"253",@"153",@"110"];
    NSArray * greenArray = @[@"191",@"48",@"209",@"199",@"109",@"208",@"123"];
    NSArray * blueArray = @[@"238",@"145",@"185",@"17",@"31",@"60",@"254"];
    
    for (int i = 0; i < _ArcCentreCoordinateAll.count; i++) {

        CAShapeLayer * progressLayer = [CAShapeLayer new];
        [self.layer addSublayer:progressLayer];
        progressLayer.fillColor = nil;
        progressLayer.frame = self.bounds;
        
        end = start+[[_ArcCentreCoordinateAll objectAtIndex:i] floatValue];
        
        NSMutableArray * startORendArray =  [[NSMutableArray alloc]init];
        [startORendArray addObject:[NSString stringWithFormat:@"%f",start]];
        [startORendArray addObject:[NSString stringWithFormat:@"%f",end]];
        
        start = end;
        
        /*
         @1.addPieChart:CAShapeLayer对象
         @2.andArcCenter:饼状图中心坐标
         @3.andStart_Angle:饼状图起点位置
         @4.andend_Angle:饼状图结束点位置
         @5.andPieChartColor:饼状图颜色
         @6.animated:是否添加动画
         */
        
        [self addPieChart:progressLayer
             andArcCenter:ARCCENTER
           andStart_Angle:[startORendArray[0] floatValue]
             andend_Angle:[startORendArray[1] floatValue]
         andPieChartWidht:_PieChartWidth
         andPieChartColor:[UIColor colorWithRed:[[RedAarray objectAtIndex:i] intValue]/255.0  green:[[greenArray objectAtIndex:i] intValue]/255.0 blue:[[blueArray objectAtIndex:i] intValue]/255.0 alpha:1]
                 animated:YES];
        
        
        CAShapeLayer * IndicatrixLayer =  [CAShapeLayer new];
        [self.layer addSublayer:IndicatrixLayer];
        IndicatrixLayer.fillColor = nil;
        IndicatrixLayer.frame = self.bounds;
        
        /*
         @1.addIndicatrixLine:CAShapeLayer对象
         @2.andOriginCoordinate:指示线&线帽起点坐标
         @3.andIndicatrixLineLength:指示线长度
         @4.andIndicatrixLineLength:指示线宽度
         @5.andIndicatrixLineColor:指示线颜色
         @6.animated:是否添加动画
         */
        
        CGPoint TextCoordinate =  [self addIndicatrixLine:IndicatrixLayer
            andOriginCoordinate:ArcCentreCoordinate
        andIndicatrixLineLength:_IndicatrixLineLength
         andIndicatrixLineWidth:_IndicatrixLineWidth
         andIndicatrixLineColor:[UIColor colorWithRed:[[RedAarray objectAtIndex:i] intValue]/255.0  green:[[greenArray objectAtIndex:i] intValue]/255.0 blue:[[blueArray objectAtIndex:i] intValue]/255.0 alpha:1]
                       animated:YES];
    
    
        
        /*
         @1.addHintText:文字坐标
         @2.andabovetext:上面文字
         @3.andDowntext:下面文字
         @4.andTextFont:文字大小
         @5.andTextColor:文字颜色
         */
        
        [self addHintText:TextCoordinate
             andabovetext:_aboveHintTextAttayAll[i]
              andDowntext:_belowHintTextAttayAll[i]
              andTextFont:_HintTextFont
             andTextColor:_HintTextColor];

    }
}

#pragma mark ------ 绘制饼状图 -------
- (void)addPieChart:(CAShapeLayer *)layer
       andArcCenter:(CGPoint)ArcCenter
     andStart_Angle:(CGFloat)start_Angle
       andend_Angle:(CGFloat)end_Angle
   andPieChartWidht:(CGFloat)PieChartWidht
andandPieChartColor:(UIColor *)andPieChartColor{

    UIBezierPath * progressPath = [UIBezierPath bezierPathWithArcCenter:ArcCenter radius:PieChartRadius startAngle:DEGREES_TO_VALUE(start_Angle) endAngle:DEGREES_TO_VALUE(end_Angle) clockwise:YES];
    layer.path = progressPath.CGPath;
    layer.lineWidth = PieChartWidht;
    layer.strokeColor = andPieChartColor.CGColor;
    
    
    // 计算存储圆弧中心点到数组
    // 弧度的中心角度
    CGFloat RadianCentreCoordinate = (DEGREES_TO_VALUE(start_Angle) + DEGREES_TO_VALUE(end_Angle)) / 2.0;
    
    // 小圆的中心点(折现起始点)
    ArcCentreCoordinate.x = ArcCenter.x+(PieChartRadius+40) * cos(RadianCentreCoordinate);
    ArcCentreCoordinate.y = ArcCenter.y+(PieChartRadius+40) * sin(RadianCentreCoordinate);
}

#pragma mark ------ 饼状图动画添加 -------
- (void)addPieChart:(CAShapeLayer *)layer
       andArcCenter:(CGPoint)ArcCenter
     andStart_Angle:(CGFloat)start_Angle
       andend_Angle:(CGFloat)end_Angle
   andPieChartWidht:(CGFloat)PieChartWidht
   andPieChartColor:(UIColor *)PieChartColor
           animated:(BOOL)animated{
    
    [self addPieChart:layer andArcCenter:ArcCenter andStart_Angle:start_Angle andend_Angle:end_Angle andPieChartWidht:PieChartWidht andandPieChartColor:PieChartColor];
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    
    pathAnimation.duration = end_Angle*0.01;
    
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    
    [layer addAnimation:pathAnimation forKey:nil];
}

#pragma mark ------ 绘制指示线 -------
- (CGPoint)addIndicatrixLine:(CAShapeLayer *)layer
      andOriginCoordinate:(CGPoint)OriginCoordinate
  andIndicatrixLineLength:(CGFloat)IndicatrixLineLength
   andIndicatrixLineWidth:(CGFloat)IndicatrixLineWidth
   andIndicatrixLineColor:(UIColor *)IndicatrixLineColor{
    
    //起点坐标
    CGFloat IndicatrixLine_Origin_CoordInateX = OriginCoordinate.x;
    CGFloat IndicatrixLine_Origin_CoordInateY = OriginCoordinate.y;
    
    //圆点坐标
    [self addIndicatrixLine_Origin_Style:CGPointMake(IndicatrixLine_Origin_CoordInateX, IndicatrixLine_Origin_CoordInateY) andColor:IndicatrixLineColor];
    
    //终点坐标
    CGFloat IndicatrixLine_End_CoordInateX;
    CGFloat IndicatrixLine_End_CoordInateY;
    
    UIBezierPath * IndicatrixLine = [UIBezierPath bezierPath];
    
    //指示线第一段(小段)
    if (IndicatrixLine_Origin_CoordInateX < ARCCENTER.x) {
        
        if (IndicatrixLine_Origin_CoordInateY < ARCCENTER.y) {
            
            //终点坐标
            IndicatrixLine_End_CoordInateX = OriginCoordinate.x-10;
            IndicatrixLine_End_CoordInateY = OriginCoordinate.y-10;
        }else{
            
            //终点坐标
            IndicatrixLine_End_CoordInateX = OriginCoordinate.x-10;
            IndicatrixLine_End_CoordInateY = OriginCoordinate.y+10;
        }
    }else{
        
        if (IndicatrixLine_Origin_CoordInateY < ARCCENTER.y) {
            
            //终点坐标
            IndicatrixLine_End_CoordInateX = OriginCoordinate.x+10;
            IndicatrixLine_End_CoordInateY = OriginCoordinate.y-10;
        }else{
            
            //终点坐标
            IndicatrixLine_End_CoordInateX = OriginCoordinate.x+10;
            IndicatrixLine_End_CoordInateY = OriginCoordinate.y+10;
        }
    }
    
    [IndicatrixLine moveToPoint:CGPointMake(IndicatrixLine_Origin_CoordInateX, IndicatrixLine_Origin_CoordInateY)];
    [IndicatrixLine addLineToPoint:CGPointMake(IndicatrixLine_End_CoordInateX, IndicatrixLine_End_CoordInateY)];
    
    //画完第一段(小段)把小段的终点赋值给第二段(大段)当起点
    IndicatrixLine_Origin_CoordInateX = IndicatrixLine_End_CoordInateX;
    IndicatrixLine_Origin_CoordInateY = IndicatrixLine_End_CoordInateY;
    
    //指示线第二段(大段)
    if (IndicatrixLine_Origin_CoordInateX < ARCCENTER.x) {
        
        if (IndicatrixLine_Origin_CoordInateY < ARCCENTER.y) {
            
            //终点坐标
            IndicatrixLine_End_CoordInateX = OriginCoordinate.x-IndicatrixLineLength;
            IndicatrixLine_End_CoordInateY = OriginCoordinate.y-10;
        }else{
            
            //终点坐标
            IndicatrixLine_End_CoordInateX = OriginCoordinate.x-IndicatrixLineLength;
            IndicatrixLine_End_CoordInateY = OriginCoordinate.y+10;
        }
        
    }else{
        
        if (IndicatrixLine_Origin_CoordInateY < ARCCENTER.y) {
            
            //终点坐标
            IndicatrixLine_End_CoordInateX = OriginCoordinate.x+IndicatrixLineLength;
            IndicatrixLine_End_CoordInateY = OriginCoordinate.y-10;
        }else{
            
            //终点坐标
            IndicatrixLine_End_CoordInateX = OriginCoordinate.x+IndicatrixLineLength;
            IndicatrixLine_End_CoordInateY = OriginCoordinate.y+10;
        }
    }
    
    
    [IndicatrixLine moveToPoint:CGPointMake(IndicatrixLine_Origin_CoordInateX, IndicatrixLine_Origin_CoordInateY)];
    [IndicatrixLine addLineToPoint:CGPointMake(IndicatrixLine_End_CoordInateX, IndicatrixLine_End_CoordInateY)];
    
    layer.path = IndicatrixLine.CGPath;
    layer.lineWidth = IndicatrixLineWidth;
    layer.strokeColor = IndicatrixLineColor.CGColor;
    
    return CGPointMake(IndicatrixLine_End_CoordInateX, IndicatrixLine_End_CoordInateY);
}
#pragma mark ------ 指示线动画添加 -------
- (CGPoint)addIndicatrixLine:(CAShapeLayer *)layer
      andOriginCoordinate:(CGPoint)OriginCoordinate
  andIndicatrixLineLength:(CGFloat)IndicatrixLineLength
   andIndicatrixLineWidth:(CGFloat)IndicatrixLineWidth
   andIndicatrixLineColor:(UIColor *)IndicatrixLineColor
                 animated:(BOOL)animated{
    
   CGPoint TextCoordinate = [self addIndicatrixLine:layer andOriginCoordinate:OriginCoordinate andIndicatrixLineLength:IndicatrixLineLength andIndicatrixLineWidth:IndicatrixLineWidth andIndicatrixLineColor:IndicatrixLineColor];
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    
    pathAnimation.duration = IndicatrixLineLength*0.01;
    
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    
    [layer addAnimation:pathAnimation forKey:nil];
    
    return TextCoordinate;
}
#pragma mark ------ 绘制指示线起点样式 -------
- (void)addIndicatrixLine_Origin_Style:(CGPoint)coordinate
                              andColor:(UIColor *)indicatrixLineColor{
    
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    // 指定frame，只是为了设置宽度和高度
    circleLayer.frame = CGRectMake(0, 0, 2, 2);
    // 设置居中显示
    circleLayer.position = CGPointMake(coordinate.x, coordinate.y);
    // 设置填充颜色
    circleLayer.fillColor = [UIColor clearColor].CGColor;
    // 设置线宽
    circleLayer.lineWidth = 2.0;
    // 设置线的颜色
    circleLayer.strokeColor = indicatrixLineColor.CGColor;
    
    // 使用UIBezierPath创建路径
    CGRect frame = CGRectMake(0, 0, 2, 2);
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithOvalInRect:frame];
    
    // 设置CAShapeLayer与UIBezierPath关联
    circleLayer.path = circlePath.CGPath;
    
    // 将CAShaperLayer放到某个层上显示
    [self.layer addSublayer:circleLayer];
}

#pragma mark ------ 绘制指示文字 -------
- (void)addHintText:(CGPoint)TextCoordinate
       andabovetext:(NSString *)abovetext
        andDowntext:(NSString *)Downtext
        andTextFont:(CGFloat)font
       andTextColor:(UIColor *)color{

    // 上面Size
    CGSize abovetextSize = [abovetext sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}];
    // 下面Size
    CGSize DowntextSize = [Downtext sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}];

    //上面文字坐标
    CGFloat abovetextCoordinateX;
    CGFloat abovetextCoordinateY;
    //下面文字坐标
    CGFloat DowntextCoordinateX;
    CGFloat DowntextCoordinateY;

    if (ARCCENTER.x < TextCoordinate.x) {
        
        abovetextCoordinateX = TextCoordinate.x-abovetextSize.width;
        abovetextCoordinateY = TextCoordinate.y-abovetextSize.height;
        
        DowntextCoordinateX = TextCoordinate.x-DowntextSize.width;
        DowntextCoordinateY = TextCoordinate.y;
    }else{
    
        abovetextCoordinateX = TextCoordinate.x;
        abovetextCoordinateY = TextCoordinate.y-abovetextSize.height;
        
        DowntextCoordinateX = TextCoordinate.x;
        DowntextCoordinateY = TextCoordinate.y;
    }
    
    
    NSMutableParagraphStyle * paragraph = [[NSMutableParagraphStyle alloc]init];
    paragraph.alignment = NSTextAlignmentLeft;

    //指引线上面的数字
    [abovetext drawAtPoint:CGPointMake(abovetextCoordinateX, abovetextCoordinateY) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font],NSForegroundColorAttributeName:color,NSParagraphStyleAttributeName:paragraph}];
    //指示线下面的文字
    [Downtext drawAtPoint:CGPointMake(DowntextCoordinateX, DowntextCoordinateY)
                        withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font],
                                         NSForegroundColorAttributeName:color,
                                         NSParagraphStyleAttributeName:paragraph}];

    
}
@end
