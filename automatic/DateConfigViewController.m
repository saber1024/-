//
//  DateConfigViewController.m
//  automatic
//
//  Created by shiki on 2017/6/27.
//  Copyright © 2017年 两仪式. All rights reserved.
//

#import "DateConfigViewController.h"
#import "XHDatePickerView.h"
#import "NSDate+Extension.h"

IB_DESIGNABLE
@interface DateConfigViewController ()
@property (weak, nonatomic) IBOutlet UILabel *startime;
@property (weak, nonatomic) IBOutlet UIButton *timepicker;
@property (weak, nonatomic) IBOutlet UILabel *endtime;
@property (weak, nonatomic) IBOutlet UIButton *jump;
@property(nonatomic,strong)UILabel *settemp;
@property (weak, nonatomic) IBOutlet UIVisualEffectView *vi;

@end

@implementation DateConfigViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
    
    self.jump.layer.borderColor = [UIColor whiteColor].CGColor;
    self.jump.layer.borderWidth = 1;
    self.jump.layer.cornerRadius = 10;
    
    
    self.settemp = [[UILabel alloc]initWithFrame:CGRectMake(self.vi.center.x - 60, 30, 120, 100)];
    self.settemp.text = @"24℃";
    self.settemp.textColor = [UIColor whiteColor];
//    self.settemp.textAlignment = NSTextAlignmentCenter;
    self.settemp.font = [UIFont systemFontOfSize:45];
    self.settemp.userInteractionEnabled = YES;
    [self.vi addSubview:self.settemp];
    
    UISwipeGestureRecognizer *sipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(SwipeNumber:)];
    [sipe setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.settemp addGestureRecognizer:sipe];
    
    UISwipeGestureRecognizer *sipe1 = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(SwipeNumber:)];
    [sipe1 setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.settemp addGestureRecognizer:sipe1];
    
    UIImageView *left = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"左 (2)"]];
    left.frame = CGRectMake(20, 70, 25,25);
    [self.vi addSubview:left];
    
    
    UIImageView *right = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 40, 70, 25, 25)];
    right.image = [UIImage imageNamed:@"左 (1)"];
    [self.vi addSubview:right];
    
    
    CABasicAnimation *anileft = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    anileft.toValue = @(-10);
    anileft.removedOnCompletion = YES;
    anileft.duration = 1.2;
    anileft.repeatCount = INFINITY;
    [left.layer addAnimation:anileft forKey:nil];
    
    CABasicAnimation *aniright = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    aniright.toValue = @(10);
    aniright.removedOnCompletion = YES;
    aniright.duration = 1.2;
    aniright.repeatCount = INFINITY;
    [right.layer addAnimation:aniright forKey:nil];

}
-(void)SwipeNumber:(UISwipeGestureRecognizer *)sender{
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        NSString *s = [self.settemp.text substringWithRange:NSMakeRange(0, 2)];
        NSInteger a = [s integerValue];
        NSString *temp = [NSString stringWithFormat:@"%ld℃",a+1];
        CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        opacityAnimation.fromValue = [NSNumber numberWithFloat:1.0];
        opacityAnimation.toValue = [NSNumber numberWithFloat:0.3];
        opacityAnimation.duration =0.5;
        opacityAnimation.removedOnCompletion = YES;
        [self.settemp.layer addAnimation:opacityAnimation forKey:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.settemp.text = temp;
        });
    }else{
        NSString *s = [self.settemp.text substringWithRange:NSMakeRange(0, 2)];
        NSInteger a = [s integerValue];
        NSString *temp = [NSString stringWithFormat:@"%ld℃",a-1];
        CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        opacityAnimation.fromValue = [NSNumber numberWithFloat:1.0];
        opacityAnimation.toValue = [NSNumber numberWithFloat:0.3];
        opacityAnimation.duration = 0.5;
        opacityAnimation.removedOnCompletion = 0.8;
        [self.settemp.layer addAnimation:opacityAnimation forKey:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.settemp.text = temp;
        });
        
    }
    
}

- (IBAction)saveDate:(UIButton *)sender {
    
    NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:
                          self.settemp.text, @"温度",
                          self.startime.text, @"启动时间",
                          self.endtime.text, @"结束时间",
                          nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"Date" object:nil userInfo:dic2];
    
    
    [self.view removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)pickerTime:(id)sender {
    XHDatePickerView *datepicker = [[XHDatePickerView alloc] initWithCurrentDate:[NSDate date:@"11:11" WithFormat:@"HH:mm"] CompleteBlock:^(NSDate *startDate, NSDate *endDate) {
        self.startime.text = [startDate stringWithFormat:@"HH:mm"];
        self.endtime.text = [endDate stringWithFormat:@"HH:mm"];
    }];
    
    
    datepicker.datePickerStyle = DateStyleShowHourMinute;
    datepicker.dateType = DateTypeStartDate;
    datepicker.minLimitDate = [NSDate date:@"0:00" WithFormat:@"HH:mm"];
    datepicker.maxLimitDate = [NSDate date:@"24:00" WithFormat:@"HH:mm"];
    [datepicker show];
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
