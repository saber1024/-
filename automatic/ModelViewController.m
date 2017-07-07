//
//  ModelViewController.m
//  automatic
//
//  Created by shiki on 2017/7/7.
//  Copyright © 2017年 两仪式. All rights reserved.
//

#import "ModelViewController.h"
#import "AutoViewController.h"
#import "tempViewController.h"
#import "CalendarViewController.h"
@interface ModelViewController ()

@end

@implementation ModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timg.jpeg"]];
                                                                                                                             
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *vi = [[UIVisualEffectView alloc]initWithFrame:self.view.frame];
    vi.effect = blur;
    [self.view addSubview:vi];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(self.view.center.x -  75, 40, 150, 30)];
    lab.text = @"选择一种模式";
    lab.textColor = [UIColor whiteColor];
    lab.font = [UIFont systemFontOfSize:20];
    [vi addSubview:lab];
    
    
    UIButton *manul = [[UIButton alloc]initWithFrame:CGRectMake(0,80, self.view.frame.size.width, 200)];
    manul.backgroundColor = [UIColor clearColor];
    [manul setTitle:@"手动模式" forState:0];
    manul.titleLabel.font = [UIFont systemFontOfSize:35];
    [manul addTarget:self action:@selector(manualMode) forControlEvents:UIControlEventTouchUpInside];
    manul.layer.borderColor = [UIColor whiteColor].CGColor;
    manul.layer.borderWidth = 1;
    manul.titleLabel.textColor = [UIColor whiteColor];
    [vi addSubview:manul];
    
    UIButton *automatic = [[UIButton alloc]initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, 200)];
    [automatic addTarget:self action:@selector(AutoMode) forControlEvents:UIControlEventTouchUpInside];
    automatic.backgroundColor = [UIColor clearColor];
    automatic.titleLabel.textColor = [UIColor whiteColor];
    automatic.titleLabel.font = [UIFont systemFontOfSize:35];
    automatic.layer.borderColor = [UIColor whiteColor].CGColor;
    automatic.layer.borderWidth = 1;
    [automatic setTitle:@"自动模式" forState:0];
    [vi addSubview:automatic];
    
}

-(void)AutoMode
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *directoryPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,      NSUserDomainMask, YES);
    
    NSString *documentDirectory = [directoryPaths objectAtIndex:0];
    
    NSString *filePath = [documentDirectory stringByAppendingPathComponent:@"ManualMode.txt"];
    
    if (![fileManager fileExistsAtPath:filePath]) {
        
        [fileManager createFileAtPath:filePath contents:nil attributes:nil];
        
    }
    CalendarViewController *ca = [[CalendarViewController alloc]init];
    [self presentViewController:ca animated:YES completion:nil];
    
}

-(void)manualMode{
    

    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *directoryPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,      NSUserDomainMask, YES);
    
    NSString *documentDirectory = [directoryPaths objectAtIndex:0];
    
    NSString *filePath = [documentDirectory stringByAppendingPathComponent:@"Automode.txt"];
    
    if (![fileManager fileExistsAtPath:filePath]) {
        
        [fileManager createFileAtPath:filePath contents:nil attributes:nil];
        
    }
    
    tempViewController *tp = [[tempViewController alloc]init];
    [self presentViewController:tp animated:YES completion:nil];
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
