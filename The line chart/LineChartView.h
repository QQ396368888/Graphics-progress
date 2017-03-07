//
//  LineChartView.h
//  ecmc
//
//  Created by 王文杰 on 16/1/5.
//  Copyright © 2016年 cp9. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LineChartView : UIView
@property (nonatomic,strong) NSArray *valueArray;
@property (nonatomic, strong) NSArray *monthArray;
@property (nonatomic,strong) NSString * pitchmonth;
- (void)costArray:(NSArray *)cost monthArray:(NSArray *)month;
@end
