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
#import "BEMCheckBox.h"
#import "AutoViewController.h"
#import "ViewController.h"
#define ScrHeight [UIScreen mainScreen].bounds.size.height
#define ScrWidth  [UIScreen mainScreen].bounds.size.width


@interface SettingModel : NSObject
@property(nonatomic,strong)NSString *wd1;
@property(nonatomic,strong)NSString *hetemp;
@property(nonatomic,strong)NSString *lowtemp;
@property(nonatomic,strong)NSString *sensor;


@end

@implementation SettingModel


@end

@interface SettingViewController ()
@property(nonatomic,strong) BEMCheckBox *check;
@property(nonatomic,strong)NSMutableArray *setting;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.setting = [NSMutableArray array];

    self.view.backgroundColor = [UIColor flatBlueColorDark];
    
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    
    //温度补偿
    UIVisualEffectView *visual = [[UIVisualEffectView alloc]initWithFrame:CGRectMake(10, 50, ScrWidth  - 20, 70)];
    visual.effect = blur;
    [self.view addSubview:visual];

    ShikiSetpter *sp = [[ShikiSetpter alloc]initWithFrame:CGRectMake(visual.frame.size.width - 140, 10, 120, 50)];
    sp.backgroundColor = [UIColor flatRedColor];
    sp.StepValue = -2;
    sp.Step = 1;
    sp.StepMaxValue = 9;
    sp.SetpminValue = -9;
    sp.titleColor = [UIColor whiteColor];
    [visual addSubview:sp];
    
    
    UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 120, 30)];
    lb.text = @"温度补偿";
    lb.textColor = [UIColor whiteColor];
    lb.font = [UIFont systemFontOfSize:20];
    [visual addSubview:lb];
    
    UIVisualEffectView *visual2= [[ UIVisualEffectView alloc]initWithFrame:CGRectMake(10, 150, ScrWidth - 20, 70)];
    visual2.effect = blur;
    [self.view addSubview:visual2];
    
    UILabel *lb1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 120, 30)];
    lb1.text = @"启动温差";
    lb1.textColor = [UIColor whiteColor];
    lb1.font = [UIFont systemFontOfSize:20];
    [visual2 addSubview:lb1];
    
    
    ShikiSetpter *stp2 = [[ShikiSetpter alloc]initWithFrame:sp.frame];
    stp2.StepMaxValue = 5;
    stp2.SetpminValue = 1;
    stp2.StepValue = 1;
    stp2.Step = 1;
    stp2.backgroundColor = [UIColor flatRedColor];
    stp2.titleColor = [UIColor flatWhiteColor];
    [visual2 addSubview:stp2];
    
    UIVisualEffectView *visual3= [[ UIVisualEffectView alloc]initWithFrame:CGRectMake(10, 240, ScrWidth - 20, 70)];
    visual3.effect = blur;
    [self.view addSubview:visual3];
    
    
    
    UILabel *lb2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 120, 30)];
    lb2.text = @"低温保护";
    lb2.textColor = [UIColor whiteColor];
    lb2.font = [UIFont systemFontOfSize:20];
    [visual3 addSubview:lb2];
    
    BEMCheckBox *check = [[BEMCheckBox alloc]initWithFrame:CGRectMake(visual3.frame.size.width - 80, 10, 50, 50)];
    [check addTarget:self action:@selector(DidCheckValue) forControlEvents:UIControlEventValueChanged];
    [visual3 addSubview:check];
    
    
    ShikiSetpter *stp3 = [[ShikiSetpter alloc]initWithFrame:CGRectMake(140, 10, 120, 50)];
    stp3.StepMaxValue = 10;
    stp3.SetpminValue = 5;
    stp3.StepValue = 1;
    stp3.Step = 1;
    stp3.backgroundColor = [UIColor flatRedColor];
    stp3.titleColor = [UIColor flatWhiteColor];
    [visual3 addSubview:stp3];

    
    
    UIVisualEffectView *visual4= [[ UIVisualEffectView alloc]initWithFrame:CGRectMake(10, 330, ScrWidth - 20, 70)];
    visual4.effect = blur;
    [self.view addSubview:visual4];

    UILabel *lb3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 120, 30)];
    lb3.text = @"高温保护";
    lb3.textColor = [UIColor whiteColor];
    lb3.font = [UIFont systemFontOfSize:20];
    [visual4 addSubview:lb3];
    
    BEMCheckBox *check1 = [[BEMCheckBox alloc]initWithFrame:CGRectMake(visual3.frame.size.width - 80, 10, 50, 50)];
    [check1 addTarget:self action:@selector(DidCheckValue) forControlEvents:UIControlEventValueChanged];
    [visual4 addSubview:check1];
    
    
    ShikiSetpter *stp4 = [[ShikiSetpter alloc]initWithFrame:CGRectMake(140, 10, 120, 50)];
    stp4.StepMaxValue = 70;
    stp4.SetpminValue = 35;
    stp4.StepValue = 35;
    stp4.Step = 1;
    stp4.backgroundColor = [UIColor flatRedColor];
    stp4.titleColor = [UIColor flatWhiteColor];
    [visual4 addSubview:stp4];
    
    
    UIVisualEffectView *visual5= [[ UIVisualEffectView alloc]initWithFrame:CGRectMake(10, 420, ScrWidth - 20, 70)];
    visual5.effect = blur;
    [self.view addSubview:visual5];
    
    UILabel *lb4 = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 80, 30)];
    lb4.text = @"传感器";
    lb4.textColor = [UIColor whiteColor];
    lb4.font = [UIFont systemFontOfSize:20];
    [visual5 addSubview:lb4];
    
    UILabel *IN = [[UILabel alloc]initWithFrame:CGRectMake(110, 20, 30, 30)];
    IN.text = @"IN";
    IN.textColor = [UIColor flatWhiteColor];
    IN.font = [UIFont systemFontOfSize:17];
    [visual5 addSubview:IN];
    
    BEMCheckBox *check2 = [[BEMCheckBox alloc]initWithFrame:CGRectMake(140, 15, 40, 40)];
   
    [visual5 addSubview:check2];
    
    
    UILabel *OU = [[UILabel alloc]initWithFrame:CGRectMake(190, 20, 30, 30)];
    OU.textColor = [UIColor whiteColor];
    OU.font = [UIFont systemFontOfSize:17];
    OU.text = @"OU";
    [visual5 addSubview:OU];
    
    
    BEMCheckBox *check3 = [[BEMCheckBox alloc]initWithFrame:CGRectMake(220, 15, 40, 40)];
    
    [visual5 addSubview:check3];
    
    UILabel *AL = [[UILabel alloc]initWithFrame:CGRectMake(270, 20, 30, 30)];
    AL.textColor = [UIColor whiteColor];
    AL.font = [UIFont systemFontOfSize:17];
    AL.text = @"AL";
    [visual5 addSubview:AL];
    
    BEMCheckBox *check4 = [[BEMCheckBox alloc]initWithFrame:CGRectMake(300, 15, 40, 40)];
    
    [visual5 addSubview:check4];
    
    
    UIButton *save = [[UIButton alloc]initWithFrame:CGRectMake(10, 510, 100, 50)];
    [save addTarget:self action:@selector(SaveSetting) forControlEvents:UIControlEventTouchUpInside];
    
    [save setTitle:@"保存" forState:0];
    save.backgroundColor = [UIColor clearColor];
    save.layer.borderWidth = 1;
    save.layer.borderColor = [UIColor flatWhiteColor].CGColor;
    [self.view addSubview:save];
    
    
    UIButton *cancel = [[UIButton alloc]initWithFrame:CGRectMake(ScrWidth - 110, 510,100, 50)];
    [cancel addTarget:self action:@selector(CancelSetting) forControlEvents:UIControlEventTouchUpInside];
    [cancel setTitle:@"取消" forState:0];
    cancel.backgroundColor = [UIColor clearColor];
    cancel.layer.borderWidth = 1;
    cancel.layer.borderColor = [UIColor flatWhiteColor].CGColor;
    [self.view addSubview:cancel];
    
    NSArray *btnimg  = @[@"开关",@"时钟",@"自动",@"风车"];
    for (int i = 0; i<4; i++) {
        UIView *func = [[UIView alloc]initWithFrame:CGRectMake(i *(self.view.frame.size.width / 4), self.view.frame.size.height - 80, self.view.frame.size.width/4, 80)];
        func.layer.borderWidth = 0.5;
        func.layer.borderColor = [UIColor whiteColor].CGColor;
        func.backgroundColor = [UIColor clearColor];
        [self.view addSubview:func];
        UIButton *open = [[UIButton alloc]initWithFrame:CGRectMake(26, 20, 40, 40)];
        open.tag  = 1000+i;
        [open addTarget:self action:@selector(BtnFunction:) forControlEvents:UIControlEventTouchUpInside];
        [open setImage:[UIImage imageNamed:btnimg[i]] forState:0];
        [func addSubview:open];
    }
    
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
        UIAlertController *aler = [UIAlertController alertControllerWithTitle:@"是否强制关机" message:@"将强制关闭整个系统" preferredStyle:1];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"不关闭!" style:0 handler:nil];;
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"关闭" style:0 handler:nil];
        [aler addAction:action];
        [aler addAction:action1];
        [self presentViewController:aler animated:YES completion:nil];
    }
    
}


-(void)DidCheckValue{
    
}

-(void)SaveSetting{
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)CancelSetting{
    [self dismissViewControllerAnimated:YES completion:nil];
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
