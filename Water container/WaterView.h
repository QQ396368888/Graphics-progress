//
//  WaterBallView.h
//  ecmc
//
//  Created by 王文杰 on 16/10/10.
//  Copyright © 2016年 cp9. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaterView : UIView

@property(assign ,nonatomic)BOOL isopen;
@property(nonatomic,assign)float percent;
- (id)initWithFrame:(CGRect)frame withHigh:(NSInteger)high;

@end
