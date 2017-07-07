//
//  AutoViewController.m
//  automatic
//
//  Created by shiki on 2017/7/5.
//  Copyright © 2017年 两仪式. All rights reserved.
//

#import "AutoViewController.h"
#import <Chameleon.h>
#import "AutoView.h"
#import "tempViewController.h"
#import "ViewController.h"
#import "SettingViewController.h"
BOOL isopen = false;
BOOL ismaualopen  =false;
@interface AutoViewController ()
@property (weak, nonatomic) IBOutlet AutoView *autoview;
@property(nonatomic,strong)UIView *leftview;
@property(nonatomic,strong)UIVisualEffectView *visual;
@property(nonatomic,strong)UIView *maualview;
@property(nonatomic,strong)UIButton *openpanel;
@end

@implementation AutoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    NSArray *colors = @[[UIColor flatOrangeColor
                         ],[UIColor flatBlueColorDark]];
    self.autoview.backgroundColor = GradientColor(UIGradientStyleTopToBottom, self.autoview.frame, colors);

    UILabel *time1 = [[UILabel alloc]initWithFrame:CGRectMake(30, 220, 50, 40)];
    time1.text = @"17:00";
    time1.textColor = [UIColor flatWhiteColor];
    time1.tag = 10001;
    [self.view addSubview:time1];
    
    UILabel *time2 = [[UILabel alloc]initWithFrame:CGRectMake(30, 350, 50, 40)];
    time2.text = @"18:00";
    
    time2.textColor = [UIColor flatWhiteColor];
    [self.view addSubview:time2];
    
    
    UILabel *time3 = [[UILabel alloc]initWithFrame:CGRectMake(30, 480 , 50, 40)];
    time3.text = @"19:00";
    time3.textColor = [UIColor flatWhiteColor];
    [self.view addSubview:time3];
    
    UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(170, 210, 120, 30)];
    lb.numberOfLines = 0;
    lb.font = [UIFont systemFontOfSize:22];
    lb.textColor = [UIColor flatWhiteColor];
    lb.text = @"32℃";
    [self.view addSubview:lb];
    
    UILabel *lb1 = [[UILabel alloc]initWithFrame:CGRectMake(170, 245, 120,30)];
    lb1.numberOfLines = 0;
    lb1.font = [UIFont systemFontOfSize:17];
    lb1.textColor = [[UIColor flatWhiteColor] colorWithAlphaComponent:0.5];
    lb1.text = @"17:00 - 18:00";
    [self.view addSubview:lb1];
    
    
    UILabel *lb2 = [[UILabel alloc]initWithFrame:CGRectMake(170,340, 120, 30)];
    lb2.numberOfLines = 0;
    lb2.font = [UIFont systemFontOfSize:22];
    lb2.textColor = [UIColor flatWhiteColor];
    lb2.text = @"32℃";
    [self.view addSubview:lb2];
    
    UILabel *lb3 = [[UILabel alloc]initWithFrame:CGRectMake(170,365, 120, 50)];
    lb3.numberOfLines = 0;
    lb3.font = [UIFont systemFontOfSize:17];
    lb3.textColor = [[UIColor flatWhiteColor] colorWithAlphaComponent:0.5];
    lb3.text = @"18:00 - 19:00";
    [self.view addSubview:lb3];
    
    
    UILabel *lb4 = [[UILabel alloc]initWithFrame:CGRectMake(170,470, 120, 30)];
    lb4.numberOfLines = 0;
    lb4.font = [UIFont systemFontOfSize:22];
    lb4.textColor = [UIColor flatWhiteColor];
    lb4.text = @"32℃";
    [self.view addSubview:lb4];
    
    UILabel *lb5 = [[UILabel alloc]initWithFrame:CGRectMake(170,490, 120, 50)];
    lb5.numberOfLines = 0;
    lb5.font = [UIFont systemFontOfSize:17];
    lb5.textColor = [[UIColor flatWhiteColor] colorWithAlphaComponent:0.5];
    lb5.text = @"20:00 - 22:00";
    [self.view addSubview:lb5];

    UILabel *maintime = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 180,80, 120, 40)];
    maintime.text = @"30℃";
    maintime.textColor = [UIColor flatWhiteColor];
    maintime.font = [UIFont systemFontOfSize:34];
    [self.view addSubview:maintime];
    
    UILabel *lb6 = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 180, 120, 160, 30)];
    lb6.textColor = [[UIColor flatWhiteColor]colorWithAlphaComponent:0.5];
    lb6.text = @"当前计划";
    lb6.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:lb6];
    
    UILabel *lb7 = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 180, 140, 120, 40)];
    lb7.textColor = [[UIColor flatWhiteColor]colorWithAlphaComponent:0.5];
    lb7.text = @"16:00 - 17:00";
    lb7.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:lb7];
    
    
    UIImageView *run = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 60, 145, 30, 30)];
    run.image = [UIImage imageNamed:@"风量4"];
    run.tag = 100002;
    [self.view addSubview:run];
    
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    rotationAnimation.duration = 0.5;
    rotationAnimation.repeatCount = INFINITY;
    rotationAnimation.cumulative = NO;
    rotationAnimation.removedOnCompletion = NO;
    rotationAnimation.fillMode = kCAFillModeForwards;
    [run.layer addAnimation:rotationAnimation forKey:nil];
    
    UIImageView *moon = [[UIImageView alloc]initWithFrame:CGRectMake(30, self.view.frame.size.height - 45, 30, 30)];
    moon.image = [UIImage imageNamed:@"月亮"];
    [self.view addSubview:moon];
    
    
    for (int i = 0; i<7; i++) {
       
        UIImageView *img =  [[UIImageView alloc]initWithFrame:CGRectMake(65 + i * 10 , self.view.frame.size.height - [self getRandomNumber:40 to:60], 10, 10)];
        img.image = [UIImage imageNamed:@"星副本"];
        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.frame = img.frame;
        gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor whiteColor]CGColor], (id)[[UIColor flatWhiteColor] CGColor], nil];
        [img.layer addSublayer:gradient];
        
        [self.view addSubview:img];
    }
    
    
    self.maualview = [[UIView alloc]initWithFrame:CGRectMake(110, self.view.frame.size.height - 100, self.view.frame.size.width - 115, 100)];
    _maualview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_maualview];
    NSArray *btnimg  = @[@"开关",@"时钟",@"自动",@"风车"];

    for (int i = 0; i<4; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(30 + i * _maualview.frame.size.width / 4, 40, 40, 40)];
        btn.tag  = 1000+i;
        [btn addTarget:self action:@selector(BtnFunction:) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:[UIImage imageNamed:btnimg[i]] forState:0];
        [_maualview addSubview:btn];
    }
    CGRect recmanua = self.maualview.frame;
    recmanua.origin.x += self.view.frame.size.width;
    self.maualview.frame = recmanua;
    
    CABasicAnimation *anileft = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    anileft.toValue = @(-10);
    anileft.removedOnCompletion = YES;
    anileft.duration = 1.2;
    anileft.repeatCount = INFINITY;
    
    self.openpanel = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 40, self.view.frame.size.height - 100, 30, 30)];
    [self.openpanel setImage:[UIImage imageNamed:@"左 (2)"] forState:0];

    [self.openpanel addTarget:self action:@selector(OpenMaunl:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.openpanel];
    [self.openpanel.layer addAnimation:anileft forKey:nil];
    
    self.leftview = [[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 170, 70, 170, 300)];
    self.leftview.hidden = true;
    self.leftview.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.leftview];
    
    UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ocean.jpg"]];
    img.frame = CGRectMake(0, 0, self.leftview.frame.size.width, self.leftview.frame.size.height);
    [self.leftview addSubview:img];
    
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    self.visual = [[UIVisualEffectView alloc]initWithFrame:CGRectMake(0, 0, self.leftview.frame.size.width, self.leftview.frame.size.height)];
    self.visual.effect = blur;
    
    [self.leftview addSubview:self.visual];
    
    
    UILabel *t1 = [[UILabel alloc]initWithFrame:CGRectMake(5, 20, 90, 20)];
    t1.text = @"高温保护:";
    t1.font = [UIFont systemFontOfSize:17];
    t1.textColor = [UIColor whiteColor];
    [self.visual addSubview:t1];
    
    UILabel *highprote = [[UILabel alloc]initWithFrame:CGRectMake(100, 15, 60, 30)];
    highprote.textColor = [UIColor whiteColor];
    highprote.text = @"60℃";
    highprote.font = [UIFont systemFontOfSize:19];
    [self.visual addSubview:highprote];
    
    
    UILabel *t2 = [[UILabel alloc]initWithFrame:CGRectMake(5, 65, 90, 20)];
    t2.text = @"低温保护:";
    t2.font = [UIFont systemFontOfSize:17];
    t2.textColor = [UIColor whiteColor];
    [self.visual addSubview:t2];
    
    UILabel *highprote1 = [[UILabel alloc]initWithFrame:CGRectMake(100, 60, 60, 30)];
    highprote1.textColor = [UIColor whiteColor];
    highprote1.text = @"6℃";
    highprote1.font = [UIFont systemFontOfSize:19];
    [self.visual addSubview:highprote1];
    
    UILabel *room = [[UILabel alloc]initWithFrame:CGRectMake(5, 105, 90, 20)];
    room.textColor = [UIColor whiteColor];
    room.text = @"室内温度";
    [self.visual addSubview:room];
    
    
    UILabel *roomtemp = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, 60, 30)];
    roomtemp.textColor = [UIColor whiteColor];
    roomtemp.text = @"32℃";
    roomtemp.font = [UIFont systemFontOfSize:17];
    [self.visual addSubview:roomtemp];
    
    
    
    
    UIButton *menu = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 35, 35, 30, 30)];
    [menu setImage:[UIImage imageNamed:@"menu"] forState:0];
    [menu addTarget:self action:@selector(LeftPanelOpen:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:menu];
    
}


-(void)OpenMaunl:(UIButton *)sender{
    if (ismaualopen == false) {
        [UIView animateWithDuration:0.5 animations:^{
            CGRect rec = self.maualview.frame;
            rec.origin.x -= self.view.frame.size.width;
            self.maualview.frame = rec;
            ismaualopen = true;
            [self.openpanel setImage:[UIImage imageNamed:@"左 (1)"] forState:0];
        }];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            CGRect rec = self.maualview.frame;
            rec.origin.x += self.view.frame.size.width;
            self.maualview.frame = rec;
            ismaualopen = false;
            [self.openpanel setImage:[UIImage imageNamed:@"左 (2)"] forState:0];
        }];
    }
    
    
}


-(void)BtnFunction:(UIButton *)sender{
    if (sender.tag == 1002
        ) {
        tempViewController *tp = [[tempViewController alloc]init];
        [self presentViewController:tp animated:YES completion:nil];
    }else if (sender.tag == 1001){
        [self dismissViewControllerAnimated:YES completion:nil];
    }else if (sender.tag == 1003){
        SettingViewController *se = [[SettingViewController alloc]init];
        [self presentViewController:se animated:YES completion:nil];
    }
}


-(void)LeftPanelOpen:(UIButton *)left{
    if (isopen == false) {
        self.leftview.hidden = false;
        
        isopen = true;
    }else{
        self.leftview.hidden = true;
        isopen = false;
    }
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (isopen == true) {
        self.leftview.hidden = true;
        isopen = false;
    }
    
}

-(int)getRandomNumber:(int)from to:(int)to
{
    return (int)(from + (arc4random() % (to - from + 1)));
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
