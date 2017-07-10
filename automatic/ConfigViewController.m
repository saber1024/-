//
//  ConfigViewController.m
//  automatic
//
//  Created by shiki on 2017/7/10.
//  Copyright © 2017年 两仪式. All rights reserved.
//

#import "ConfigViewController.h"
#import "GaiDropDownMenu.h"
BOOL ison = YES;
@interface ConfigViewController ()<CCDropDownMenuDelegate>
@property(nonatomic,strong)NSArray *titles;
@property(nonatomic,strong)GaiDropDownMenu *menu;
@property(nonatomic,strong)UIButton *Off;
@property(nonatomic,strong)UIButton *On;
@end

@implementation ConfigViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
    UIView *configview = [[UIView alloc]initWithFrame:CGRectMake(40, self.view.center.y - 150, self.view.frame.size.width - 80, 300)];
    configview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:configview];
    
    
    UIButton *back = [[UIButton alloc]initWithFrame:CGRectMake(configview.frame.size.width - 30, 15, 25, 25)];
    [back setImage:[UIImage imageNamed:@"关闭"] forState:0];
    [configview addSubview:back];
    [back addTarget:self action:@selector(ClosePage) forControlEvents:UIControlEventTouchUpInside];
    
    self.titles = @[@"手动模式",@"自动模式"];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(90, 10, 120, 30)];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"设备属性设置";
    title.font = [UIFont systemFontOfSize:17];
    [configview addSubview:title];
    
    
    UILabel *la = [[UILabel alloc]initWithFrame:CGRectMake(10, 60, 100, 40)];
    la.text = @"默认启动";
    [configview addSubview:la];
    
    GaiDropDownMenu *menu = [[GaiDropDownMenu alloc]initWithFrame:CGRectMake(130, 60, configview.frame.size.width - 140, 30)];
    menu.numberOfRows = 2;
    menu.delegate = self;
    NSString *localPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
   
    NSString *filePath = [localPath  stringByAppendingPathComponent:@"ManualMode.txt"];
    NSString *filePath1 = [localPath  stringByAppendingPathComponent:@"Automode.txt"];
   
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]) {
       menu.title = @"手动模式";
       menu.textOfRows = @[@"手动模式",@"自动模式"];
    }
    
    if ([fileManager fileExistsAtPath:filePath1]) {
        menu.title = @"自动模式";
        menu.textOfRows = @[@"自动模式",@"手动模式"];
    }
    menu.seperatorColor = [UIColor blackColor];
    self.menu = menu;;
    [configview addSubview:menu];
    
    
    self.On = [[UIButton alloc]initWithFrame:CGRectMake(30, 130, configview.frame.size.width - 60, 50)];
    [self.On setTitle:@"开启设备" forState:0];
    self.On.titleLabel.textColor = [UIColor blackColor];
    self.On.layer.borderColor = [UIColor blackColor].CGColor;
    [self.On setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.On.layer.borderWidth = 1;
    self.On.enabled = YES;
    [self.On addTarget:self action:@selector(TurnOnDevice:) forControlEvents:UIControlEventTouchUpInside];
    [configview addSubview:self.On];
    
    
    
    self.Off = [[UIButton alloc]initWithFrame:CGRectMake(30, 200, configview.frame.size.width - 60, 50)];
    [self.Off setTitle:@"关闭设备" forState:0];
    self.Off.layer.borderColor = [UIColor blackColor].CGColor;
    [self.Off setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.Off addTarget:self action:@selector(TurnOffDevice:) forControlEvents:UIControlEventTouchUpInside];
    self.Off.layer.borderWidth = 1;
    [configview addSubview:self.Off];
    
    
    
}

-(void)TurnOnDevice:(UIButton *)sender{
    if (ison == false) {
        [sender setTitleColor:[UIColor greenColor] forState:0];
        sender.layer.borderColor = [UIColor greenColor].CGColor;
        self.Off.layer.borderColor = [UIColor blackColor].CGColor;
        [self.Off setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        ison = false;
    }
}

-(void)TurnOffDevice:(UIButton *)sender{
    [sender setTitleColor:[UIColor redColor] forState:0];
    sender.layer.borderColor = [UIColor redColor].CGColor;
    ison = false;
    self.On.enabled = YES;
    self.On.titleLabel.textColor = [UIColor blackColor];
    self.On.layer.borderColor = [UIColor blackColor].CGColor;
}


-(void)ClosePage{
    [self.view removeFromSuperview];
}



-(void)dropDownMenu:(CCDropDownMenu *)dropDownMenu didSelectRowAtIndex:(NSInteger)index{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *directoryPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,      NSUserDomainMask, YES);
    
    NSString *documentDirectory = [directoryPaths objectAtIndex:0];
    
    if ([_menu.title  isEqual: @"手动模式"]) {
        NSString *filePath = [documentDirectory stringByAppendingPathComponent:@"ManualMode.txt"];
        
        if (![fileManager fileExistsAtPath:filePath]) {
            
            [fileManager createFileAtPath:filePath contents:nil attributes:nil];
            
        }

    }else{
        NSString *filePath = [documentDirectory stringByAppendingPathComponent:@"Automode.txt"];
        
        if (![fileManager fileExistsAtPath:filePath]) {
            
            [fileManager createFileAtPath:filePath contents:nil attributes:nil];
            
        }

    }

}


//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self.view removeFromSuperview];
//}


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
