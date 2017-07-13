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

    
   self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timg.jpeg"]];
    
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *vi = [[UIVisualEffectView alloc]initWithFrame:self.view.frame];
    vi.effect = blur;
    [self.view addSubview:vi];
    
    
    UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(50, vi.center.y -60, 120, 30)];
    lb.text = @"默认启动顺序";
    lb.font = [UIFont systemFontOfSize:17];
    lb.textColor = [UIColor whiteColor];
    [vi addSubview:lb];
    
    self.menu = [[GaiDropDownMenu alloc]initWithFrame:CGRectMake(180, vi.center.y - 75, 140, 50)];
    self.menu.title = @"手动模式";
    self.menu.numberOfRows =  2;
    self.menu.textOfRows = @[@"手动模式",@"自动模式"];
//    NSArray<UIColor *> * co = [[NSArray alloc]initWithObjects:[UIColor whiteColor],[UIColor whiteColor], nil];
//    self.menu.colorOfRows = co;
    
    self.menu.titleViewColor = [UIColor clearColor];
    [vi addSubview:self.menu];


    self.On = [[UIButton alloc]initWithFrame:CGRectMake(self.view.center.x - 100, self.view.center.y +70, 200, 40)];
    [self.On setTitle:@"开启" forState:0];
    self.On.layer.borderWidth = 1;
    self.On.layer.borderColor = [UIColor whiteColor].CGColor;
    [self.On setTitleColor:[UIColor whiteColor] forState:0];
    [self.view addSubview:self.On];
    
    self.Off = [[UIButton alloc]initWithFrame:CGRectMake(self.view.center.x -100, self.view.center.y + 120 , 200, 40)];
    self.Off.layer.borderColor = [UIColor whiteColor].CGColor;
    self.Off.layer.borderWidth = 1;
    [self.Off setTitle:@"关闭" forState:0];
    [self.Off setTitleColor:[UIColor whiteColor] forState:0];
    [self.view addSubview:self.Off];
    
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
