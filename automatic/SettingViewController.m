//
//  SettingViewController.m
//  automatic
//
//  Created by shiki on 2017/7/6.
//  Copyright © 2017年 两仪式. All rights reserved.
//

#import "SettingViewController.h"
#import <Chameleon.h>
#import "ShikiSetpter.h"
#define ScrHeight [UIScreen mainScreen].bounds.size.height
#define ScrWidth  [UIScreen mainScreen].bounds.size.width
@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor flatBlueColorDark];
    
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    
    //温度补偿
    UIVisualEffectView *visual = [[UIVisualEffectView alloc]initWithFrame:CGRectMake(10, 50, ScrWidth  - 20, 70)];
    visual.effect = blur;
    [self.view addSubview:visual];

    ShikiSetpter *sp = [[ShikiSetpter alloc]initWithFrame:CGRectMake(visual.frame.size.width - 140, 10, 120, 50)];
    sp.backgroundColor = [UIColor flatRedColor];
    sp.StepValue = 1;
    sp.Step = 1;
    sp.StepMaxValue = 9;
    sp.SetpminValue = -9;
    sp.titleColor = [UIColor whiteColor];
    [visual addSubview:sp];
    
    
    
    
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
