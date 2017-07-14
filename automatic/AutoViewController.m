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
#import "ConfigViewController.h"
#import "FMDataManager.h"
#import "AutoTableViewCell.h"

BOOL isopen = false;
BOOL ismaualopen  =false;
@interface AutoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIView *leftview;
@property(nonatomic,strong)UIVisualEffectView *visual;
@property(nonatomic,strong)UIView *maualview;
@property(nonatomic,strong)UIButton *openpanel;
@property(nonatomic,strong)UITableView *list;
@property(nonatomic,strong)NSMutableArray *DataSource;
@end

@implementation AutoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    NSArray *colors = @[[UIColor flatOrangeColor
                         ],[UIColor flatBlueColorDark]];
    self.view.backgroundColor = GradientColor(UIGradientStyleTopToBottom,self.view.frame, colors);
    
    NSDate*date = [NSDate date];
    NSCalendar*calendar = [NSCalendar currentCalendar];
    NSDateComponents*comps;
    comps =[calendar components:(NSCalendarUnitWeekOfYear | NSCalendarUnitWeekday |NSCalendarUnitWeekdayOrdinal)
                       fromDate:date];
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init] ;
    [dateFormatter setDateFormat:@"EEEE"];
    ;
    [dateFormatter stringFromDate:date];
    
    
    
    FMDataManager *manager = [FMDataManager SharedDB];
    NSMutableArray *arr = [manager SearchDBwithTitle:[self weekdayStringFromDate:date]];
    if (arr.count == 0) {
        NSLog(@"当前日程没有计划!");
    }else{
        self.DataSource = arr;
    }
    
    self.list = [[UITableView alloc]initWithFrame:CGRectMake(20, 65, self.view.frame.size.width - 120, self.view.frame.size.height - 185) style:UITableViewStylePlain];
    [self.list registerClass:[AutoTableViewCell class] forCellReuseIdentifier:@"cell"];
    self.list.backgroundColor = [UIColor clearColor];
    self.list.delegate = self;
    self.list.dataSource = self;
    self.list.scrollEnabled = false;
    self.list.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.list];
    
    
    
    
    
    
    UIImageView *run = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 60, 145, 30, 30)];
    run.image = [UIImage imageNamed:@"风量4"];
    run.tag = 100002;
    [self.view addSubview:run];
    
    UIImageView *heat = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 60, 205, 30, 30)];
    heat.image = [UIImage imageNamed:@"加热"];
    [self.view addSubview:heat];
    
    UIImageView *automaticly = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 60, 265, 30, 30)];
    automaticly.image = [UIImage imageNamed:@"自动"];
    [self.view addSubview:automaticly];
    
    
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
    

    
    NSArray *btnimg  = @[@"开关",@"时钟",@"手动",@"风车"];
    for (int i = 0; i<4; i++) {
        UIView *func = [[UIView alloc]initWithFrame:CGRectMake(i *(self.view.frame.size.width / 4), self.view.frame.size.height - 80, self.view.frame.size.width/4, 80)];
        func.layer.borderWidth = 0.5;
        func.layer.borderColor = [UIColor whiteColor].CGColor;
        func.backgroundColor = [UIColor clearColor];
        [self.view addSubview:func];
        UIButton *open = [[UIButton alloc]initWithFrame:CGRectMake(26, 10, 40, 40)];
        open.tag  = 1000+i;
        [open addTarget:self action:@selector(BtnFunction:) forControlEvents:UIControlEventTouchUpInside];
        [open setImage:[UIImage imageNamed:btnimg[i]] forState:0];
        [func addSubview:open];
        
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, func.frame.size.width, 30)];
        title.text = btnimg[i];
        if (i == 3) {
            title.text = @"设置";
        }
        title.textColor = [UIColor whiteColor];
        title.textAlignment = NSTextAlignmentCenter;
        [func addSubview:title];
        
    }
    
    
    
    CABasicAnimation *anileft = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    anileft.toValue = @(-10);
    anileft.removedOnCompletion = YES;
    anileft.duration = 1.2;
    anileft.repeatCount = INFINITY;
    
  
    
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

-(void)BtnFunction:(UIButton *)sender{
    if (sender.tag == 1002
        ) {
        tempViewController *tp = [[tempViewController alloc]init];
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


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.DataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AutoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
     
    cell.index = indexPath;
    cell.time.text = [NSString stringWithFormat:@"%@ - %@",[self.DataSource[indexPath.row]startime],[self.DataSource[indexPath.row]endtime]];
    cell.img.image = [UIImage imageNamed:@"sun"];
    cell.temperature.text = [self.DataSource[indexPath.row] temperature];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath == 0) {
        return 140;
    }else{
        return 100;
    }
}

- (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"Sunday", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
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
