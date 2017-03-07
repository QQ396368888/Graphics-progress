//
//  RootViewController.m
//  Water container
//
//  Created by 王文杰 on 16/10/24.
//  Copyright © 2016年 王文杰. All rights reserved.
//

#import "RootViewController.h"
#import "WaterView.h"
#import "RoundView.h"
#import "ColumnarView.h"
#import "LineChartView.h"
#import "RainbowView.h"
#define XWSCREENW [UIScreen mainScreen].bounds.size.width
#define XWSCREENH [UIScreen mainScreen].bounds.size.height
#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]

#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
@interface RootViewController (){
    
    UILabel * DataTagLb;
}


@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self CreateHistogram];
    [self CreateLineChart];
    [self CreatteRainbow];
    [self CreateWater];
}


-(void)CreateHistogram{

    ColumnarView *columnarView = [[ColumnarView alloc]initWithFrame:CGRectMake(0, 150, XWSCREENW,200)];
    columnarView.valueArray = @[@"60",@"90",@"100",@"80",@"200",@"30"];
    columnarView.monthArray =@[@"1月",@"2月",@"3月",@"4月",@"5月",@"6月"];
    columnarView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:columnarView];
    
}
-(void)CreateLineChart{

    LineChartView * Lineview = [[LineChartView alloc]initWithFrame:CGRectMake(0, 400, XWSCREENW, 200)];
    Lineview.backgroundColor = [UIColor whiteColor];
    Lineview.valueArray = @[@"60",@"90",@"100",@"80",@"200",@"30"];
    Lineview.monthArray =@[@"1月",@"2月",@"3月",@"4月",@"5月",@"6月"];
    [self.view addSubview:Lineview];


}
-(void)CreatteRainbow{
    
    CGFloat record = 0;
    CGFloat cumsum = 0;
    
    NSArray * array = @[@"20",@"20",@"20",@"20",@"10",@"10"];
    
    for (int i = 0; i<array.count; i++) {
       RainbowView *rainbowView = [[RainbowView alloc]initWithFrame:CGRectMake(0,140, XWSCREENW, 500)];
        
        rainbowView.progressColor = randomColor;
        
        rainbowView.progressWidth = 15;
        //计算下一条的长度+上一条的长度
        if (i!=0){
            record = [[array objectAtIndex:i-1] floatValue]*0.01;
            cumsum = cumsum+record;
            
        }
        [rainbowView setProgress:[[array objectAtIndex:i] floatValue]*0.01 +cumsum animated:YES];
        [self.view addSubview:rainbowView];
        [self.view insertSubview:rainbowView atIndex:0];
        

    }

}
-(void)CreateWater{
    
    RoundView *roundView = [[RoundView alloc]initWithFrame:CGRectMake(50, XWSCREENH-120, 100, 100)];
    roundView.LineW = 3;
    roundView.percent = 0.5;
    [self.view addSubview:roundView];
    
    WaterView *waterbig = [[WaterView alloc] initWithFrame:CGRectMake(50, XWSCREENH-120, 90, 90) withHigh:50];
    waterbig.layer.cornerRadius = waterbig.frame.size.width / 2;
    waterbig.layer.masksToBounds = YES;
    waterbig.isopen = NO;
    waterbig.percent = 0.5;
    roundView.center = waterbig.center;
    [self.view addSubview:waterbig];
    
    WaterView *watersmall = [[WaterView alloc] initWithFrame:CGRectMake(50, XWSCREENH-120, 90, 90) withHigh:50];
    watersmall.layer.cornerRadius = watersmall.frame.size.width / 2;
    watersmall.backgroundColor = [UIColor clearColor];
    watersmall.layer.masksToBounds = YES;
    watersmall.isopen = YES;
    watersmall.percent = 0.5;
    roundView.center = waterbig.center;
    [self.view addSubview:watersmall];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
