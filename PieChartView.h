//
//  PieChartView.h
//  测试
//
//  Created by 王文杰 on 2017/2/8.
//  Copyright © 2017年 王文杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PieChartView : UIView{

    NSArray *_ArcCentreCoordinateAll;
}

//饼状图颜色
@property (nonatomic, strong) UIColor *PieChartColor;

//饼状图进度
@property (nonatomic, strong) NSArray *PieChartprogress;

//饼状图宽度
@property (nonatomic, assign) CGFloat PieChartWidth;

//指示线颜色
@property (nonatomic, strong) UIColor *indicatrixLineColor;

//指示线长度
@property (nonatomic, assign) CGFloat IndicatrixLineLength;

//指示线宽度
@property (nonatomic, assign) CGFloat IndicatrixLineWidth;

//指示文字大小
@property (nonatomic, assign) CGFloat HintTextFont;

//指示文字颜色
@property (nonatomic, strong) UIColor * HintTextColor;

//指示文字(下)
@property (nonatomic, strong) NSArray * belowHintTextAttayAll;

//指示文字(上)
@property (nonatomic, strong) NSArray * aboveHintTextAttayAll;


@property (nonatomic,strong) NSArray *ArcCentreCoordinateAll;

- (void)drawRect:(CGRect)rect;
@end
