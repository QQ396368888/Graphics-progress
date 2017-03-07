//
//  BillQueryView.h
//  ecmc
//
//  Created by 王文杰 on 16/1/5.
//  Copyright © 2016年 cp9. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RainbowView : UIView
{
    CAShapeLayer *_progressLayer;
    UIBezierPath *_progressPath;
}
@property (nonatomic, strong) UIColor *progressColor;
@property (nonatomic) float progress;//0~1之间的数
@property (nonatomic) float progressWidth;

- (void)setProgress:(float)progress animated:(BOOL)animated;

@end
