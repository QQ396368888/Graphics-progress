//
//  RoundView.h
//  ecmc
//
//  Created by 王文杰 on 16/10/10.
//  Copyright © 2016年 cp9. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoundView : UIView
@property(nonatomic, assign) CGFloat  Waterx;
@property(nonatomic, assign) CGFloat  Watery;
@property(nonatomic, assign) CGFloat  WaterW;
@property(nonatomic, assign) CGFloat  WaterH;
@property(nonatomic, assign) CGFloat  Waterr;
@property(nonatomic, assign) CGFloat  LineW;


@property(nonatomic,assign)float percent;
//创建全局属性的ShapeLayer
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@end
