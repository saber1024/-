//
//  ViewController.m
//  manual
//
//  Created by shiki on 2017/6/28.
//  Copyright © 2017年 两仪式. All rights reserved.
//

#import "tempViewController.h"
#import "Display.h"
#import "Chameleon.h"
#import "tempView.h"
#import "automatic-Swift.h"
#import "SettingViewController.h"
#import "AutoViewController.h"
#import "ViewController.h"
#import "ConfigViewController.h"
int flag = 0;
@interface tempViewController ()
@property(nonatomic,strong)CAShapeLayer *up;
@property(nonatomic,strong)CAShapeLayer *down;
@property(nonatomic,strong)UILabel *settemp;
@property(nonatomic,assign) CGRect rect;
@property(nonatomic,strong)WaveProgressView *wave;
@property(nonatomic,strong)UIVisualEffectView *vi;
@property(nonatomic,strong)Display *backview;
@property(nonatomic,strong)tempView *frontView;
@property(nonatomic,assign)CGFloat currentTemp;
@property(nonatomic,strong)UIView *scaleview;
@property(nonatomic,strong)UIImageView *upimg;
@property(nonatomic,strong)UIImageView *downimg;
@property(nonatomic,strong)UILabel *uptemp;
@property(nonatomic,strong)UILabel *downtemp;

@property(nonatomic,assign)CGFloat settingtemp;
@end

@implementation tempViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timg.jpeg"]];

    
    
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    self.vi = [[UIVisualEffectView alloc]initWithFrame:self.view.frame];
    self.vi.effect = blur;
    [self.view addSubview:self.vi];
    
    self.backview = [[Display alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 100, 60, 71, 340)];
    self.backview.backgroundColor = [UIColor whiteColor];
    [self.vi addSubview:self.backview];
    [self.backview setNeedsDisplay];
    self.currentTemp = 35;
    
    self.frontView = [[tempView alloc]initWithFrame:CGRectMake(self.backview.frame.origin.x - 155, 60, 154, 340)];
    self.frontView.backgroundColor = [UIColor whiteColor];
    self.frontView.hightprotect = @"60℃";
    self.frontView.lowprotect = @"5℃";
    self.frontView.tempColor = [UIColor flatYellowColor];
    self.frontView.tempheight = 190;
    self.frontView.waveheight = 75;
    self.frontView.currenttemp = self.currentTemp;
    
    [self.vi addSubview:self.frontView];
    [self.frontView setNeedsDisplay];
    
    self.settingtemp = 25;
    
    
    self.scaleview = [[UIView alloc]initWithFrame:CGRectMake(40, 400 - 30 - (self.settingtemp /10) * 35, self.view.frame.size.width - 100 - 40, 1)];
    self.scaleview.backgroundColor = [UIColor redColor];
    [self.vi addSubview:self.scaleview];
    
    self.upimg = [[UIImageView alloc]initWithFrame:CGRectMake(60, self.scaleview.frame.origin.y - 20, 20, 20)];
    _upimg.image = [UIImage imageNamed:@"向下32px"];
    [self.vi addSubview:self.upimg];
    
    self.downimg  =[[UIImageView alloc]initWithFrame:CGRectMake(60, self.scaleview.frame.origin.y, 20, 20)];
    self.downimg.image =[UIImage imageNamed:@"向上32px"];
    [self.vi addSubview:self.downimg];
    
    self.uptemp = [[UILabel alloc]initWithFrame:CGRectMake(40, self.scaleview.frame.origin.y - 25, 30, 30)];
    self.uptemp.text = @"+5";
    self.uptemp.textColor = [UIColor whiteColor];
    [self.vi addSubview:self.uptemp];
    
    self.downtemp = [[UILabel alloc]initWithFrame:CGRectMake(40, self.scaleview.frame.origin.y, 30, 30)];
    self.downtemp.textColor = [UIColor whiteColor];
    self.downtemp.text = @"-5";
    [self.vi addSubview:self.downtemp];
    
    
    UILabel *la = [[UILabel alloc]initWithFrame:CGRectMake(45, self.frontView.frame.size.height - 130, 120, 30)];
    la.text = [NSString stringWithFormat:@"%g℃",self.currentTemp];
    la.font = [UIFont systemFontOfSize:25];
    la.textColor = [UIColor whiteColor];
    [self.frontView addSubview:la];
    

    self.settemp = [[UILabel alloc]initWithFrame:CGRectMake(self.view.center.x - 80, self.frontView.frame.size.height +65, 160, 70)];
    self.settemp.text = [NSString stringWithFormat:@"%g",self.settingtemp];
    self.settemp.textColor = [UIColor whiteColor];
    self.settemp.textAlignment = NSTextAlignmentCenter;
    self.settemp.font = [UIFont systemFontOfSize:45];
    self.settemp.userInteractionEnabled = YES;
    [self.view addSubview:self.settemp];
    
    NSLog(@"%g",self.settemp.frame.origin.x);
    
    
    UIImageView *left = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"左 (2)"]];
    left.frame = CGRectMake(30, self.frontView.frame.size.height + 85, 25,25);
    [self.vi addSubview:left];
    
    
    UIImageView *right = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 40, self.frontView.frame.size.height + 85, 25, 25)];
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
    
    UISwipeGestureRecognizer *sipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(SwipeNumber:)];
    [sipe setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.settemp addGestureRecognizer:sipe];
    
    UISwipeGestureRecognizer *sipe1 = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(SwipeNumber:)];
    [sipe1 setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.settemp addGestureRecognizer:sipe1];
    
    
    NSArray *btnimg  = @[@"开关",@"时钟",@"自动",@"风车"];
    for (int i = 0; i<4; i++) {
        UIView *func = [[UIView alloc]initWithFrame:CGRectMake(i *(self.view.frame.size.width / 4), self.view.frame.size.height - 100, self.view.frame.size.width/4, 100)];
        func.layer.borderWidth = 0.5;
        func.layer.borderColor = [UIColor whiteColor].CGColor;
        func.backgroundColor = [UIColor clearColor];
        [self.view addSubview:func];
        UIButton *open = [[UIButton alloc]initWithFrame:CGRectMake(26,20, 40, 40)];
        open.tag  = 1000+i;
        [open addTarget:self action:@selector(BtnFunction:) forControlEvents:UIControlEventTouchUpInside];
        [open setImage:[UIImage imageNamed:btnimg[i]] forState:0];
        [func addSubview:open];
        
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 65,func.frame.size.width, 30)];
        title.text = btnimg[i];
        title.textAlignment = NSTextAlignmentCenter;
        title.textColor = [UIColor whiteColor];
        if (i == 3) {
            title.text = @"设置";
        }
        [func addSubview:title];
    }
    
    UIImageView *heat = [[UIImageView alloc]initWithFrame:CGRectMake(30, self.view.frame.size.height  - 160, 30, 30)];
    heat.image = [UIImage imageNamed:@"加热"];
    [self.vi addSubview:heat];
    
    UIImageView *manul = [[UIImageView alloc]initWithFrame:CGRectMake(80, self.view.frame.size.height -160, 30, 30)];
    manul.image = [UIImage imageNamed:@"手动"];
    [self.vi addSubview:manul];
    
    UIImageView *run = [[UIImageView alloc]initWithFrame:CGRectMake(130, self.view.frame.size.height - 160, 30, 30)];
    run.image = [UIImage imageNamed:@"风量4"];
    run.tag = 100002;
    [self.vi addSubview:run];
    
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
    
    //clam
    

    
    UIButton *open = [[UIButton alloc]initWithFrame:CGRectMake(180, self.view.frame.size.height - 160, 120, 40)];
    [open setTitle:@"强制开启" forState:0];
    open.layer.cornerRadius = 10;
    [open addTarget:self action:@selector(ChangeValueFlag:) forControlEvents:UIControlEventTouchUpInside];
    open.backgroundColor = [UIColor clearColor];
    open.layer.borderWidth = 1;
    open.layer.borderColor = [UIColor whiteColor].CGColor;
    [self.vi addSubview:open];
    
}


-(void)BtnFunction:(UIButton *)sender{
    if (sender.tag == 1002
        ) {
        AutoViewController *tp = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"auto"];
        [self presentViewController:tp animated:YES completion:nil];
    }else if (sender.tag == 1001){
        ViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"vcx"];
        [self presentViewController:vc animated:YES completion:nil];
    }else if (sender.tag == 1003){
        SettingViewController *se = [[SettingViewController alloc]init];
        [self presentViewController:se animated:YES completion:nil];
    }else if(sender.tag == 1000){
        
        ConfigViewController *con = [[ConfigViewController alloc]init];
        con.view.frame = self.view.frame;
        [self addChildViewController:con];
        [self.view addSubview:con.view];
        [con.view didMoveToWindow];
    }

}

-(void)ChangeValueFlag:(UIButton *)sender{
    if (flag == 0) {
        flag = 1;
        [sender setTitle:@"强制关闭" forState:0];
//        UIImageView *img = [self.vi viewWithTag:100002];
       // [img.layer removeAllAnimations];
    }else if (flag == 1){
        flag = 0;
        [sender setTitle:@"强制开启" forState:0];
    }
}




-(void)SwipeNumber:(UISwipeGestureRecognizer *)sender{
    
    
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        NSString *s = [self.settemp.text substringWithRange:NSMakeRange(0, 2)];
        NSInteger a = [s integerValue];
        NSString *temp = [NSString stringWithFormat:@"%ld℃",a+1];

        self.settemp.text = temp;
        self.backview.SettingTemp = a+1;
        self.settingtemp = a;
        CGRect rect = self.scaleview.frame;
        rect.origin.y = 400 - 30 - (self.settingtemp /10) * 36;
        if (rect.origin.y != 253) {
            self.scaleview.frame = rect;
        }
        
        CGRect recup = self.upimg.frame;
        CGRect recdown = self.downimg.frame;
        CGRect recup1 = self.uptemp.frame;
        CGRect recdown1 = self.downtemp.frame;
        
        recup.origin.y = self.scaleview.frame.origin.y - 20;
        recdown.origin.y = self.scaleview.frame.origin.y;
        recup1.origin.y = self.scaleview.frame.origin.y - 25;
        recdown1.origin.y  = self.scaleview.frame.origin.y;
        
        
        self.upimg.frame = recup;
        self.downimg.frame = recdown;
        self.uptemp.frame = recup1;
        self.downtemp.frame = recdown1;
        
    }else{

        NSString *s = [self.settemp.text substringWithRange:NSMakeRange(0, 2)];
        NSInteger a = [s integerValue];
        NSString *temp = [NSString stringWithFormat:@"%ld℃",a-1];

        self.settemp.text = temp;
        self.settingtemp = a - 1;
        CGRect rect = self.scaleview.frame;
        rect.origin.y = 400 - 30 - (self.settingtemp /10) * 36;
        if (rect.origin.y != 393) {
            self.scaleview.frame = rect;
        
    }
        
        CGRect recup = self.upimg.frame;
        CGRect recdown = self.downimg.frame;
        CGRect recup1 = self.uptemp.frame;
        CGRect recdown1 = self.downtemp.frame;
        
        recup.origin.y = self.scaleview.frame.origin.y - 20;
        recdown.origin.y = self.scaleview.frame.origin.y;
        recup1.origin.y = self.scaleview.frame.origin.y - 25;
        recdown1.origin.y  = self.scaleview.frame.origin.y;
        
        
        self.upimg.frame = recup;
        self.downimg.frame = recdown;
        self.uptemp.frame = recup1;
        self.downtemp.frame = recdown1;
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
