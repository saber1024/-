//
//  ViewController.m
//  automatic
//
//  Created by shiki on 2017/6/27.
//  Copyright © 2017年 两仪式. All rights reserved.
//

#import "ViewController.h"
#import "ListTableViewCell.h"
#import "DateConfigViewController.h"
#import "CalendarViewController.h"
#import "automatic-Swift.h"
#import "tempViewController.h"
#import "AutoViewController.h"
#import "SettingViewController.h"
@interface DateModle : NSObject
@property(nonatomic,strong)NSString *tempture;
@property(nonatomic,strong)NSString *startime;
@property(nonatomic,strong)NSString *endtime;
@end
@implementation DateModle
@end


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *dateList;
@property(nonatomic,strong)NSMutableArray *datenum;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timg.jpeg"]];
    
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *vi = [[UIVisualEffectView alloc]initWithFrame:self.view.frame];
    vi.effect = blur;
    [self.view addSubview:vi];
    UIView *back = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 80, self.view.frame.size.width, 0.5)];
    back.backgroundColor = [UIColor whiteColor];
    [vi addSubview:back];
    
    
    UIButton *add = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 55, 40, 30, 30)];
    [add setImage:[UIImage imageNamed:@"添加"] forState:0];
    [vi addSubview:add];
    [add addTarget:self action:@selector(AddDate:) forControlEvents:UIControlEventTouchUpInside];
    
    self.dateList = [[UITableView alloc]initWithFrame:CGRectMake(10, 80, self.view.frame.size.width  - 20, 250) style:UITableViewStylePlain];
    self.dateList.delegate = self;
    self.dateList.dataSource = self;
    self.dateList.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.dateList];
    
    [self.dateList registerNib:[UINib nibWithNibName:@"ListTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"list"];
    
    self.datenum = [NSMutableArray array];
    NSArray *btnimg  = @[@"开关",@"时钟",@"操作_手动",@"风车"];
    for (int i = 0; i<4; i++) {
        UIView *func = [[UIView alloc]initWithFrame:CGRectMake(i *(self.view.frame.size.width / 4), self.view.frame.size.height - 80, self.view.frame.size.width/4, 80)];
        func.layer.borderWidth = 0.5;
        func.layer.borderColor = [UIColor whiteColor].CGColor;
        func.backgroundColor = [UIColor clearColor];
        [vi addSubview:func];
        UIButton *open = [[UIButton alloc]initWithFrame:CGRectMake(26, 20, 40, 40)];
        open.tag  = 1000+i;
        [open addTarget:self action:@selector(BtnFunction:) forControlEvents:UIControlEventTouchUpInside];
        [open setImage:[UIImage imageNamed:btnimg[i]] forState:0];
        [func addSubview:open];
    }
    
    UIButton *dateset = [[UIButton alloc]initWithFrame:CGRectMake(self.view.center.x - 80, self.view.frame.size.height - 170, 160, 50)];
    [dateset setTitle:@"日期设置" forState:0];
    dateset.titleLabel.textColor = [UIColor whiteColor];
    dateset.backgroundColor = [UIColor clearColor];
    dateset.layer.cornerRadius = 10;
    dateset.layer.borderColor = [UIColor whiteColor].CGColor;
    dateset.layer.borderWidth = 1;
    [dateset addTarget:self action:@selector(Dataset) forControlEvents:UIControlEventTouchUpInside];
    [vi addSubview:dateset];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ReloadDateNoti:) name:@"Date" object:nil];
    
}

-(void)Dataset{
//    CalendarViewController *ca = [[CalendarViewController alloc]init];
//    
//    [self presentViewController:ca animated:YES completion:nil];
}


-(void)ReloadDateNoti:(NSNotification *)noti{
    
    NSLog(@"%@",noti.userInfo);
    NSString *startime = (NSString *)[noti.userInfo valueForKey:@"启动时间"];
    NSString *endtime = (NSString *)[noti.userInfo valueForKey:@"结束时间"];
    NSString *temp = (NSString *)[noti.userInfo valueForKey:@"温度"];
    
    DateModle *model =  [[DateModle alloc]init];
    model.tempture = temp;
    model.startime = startime;
    model.endtime = endtime;
    [self.datenum addObject:model];
    
    [self.dateList reloadData];

}


-(void)AddDate:(UIButton *)sender{
    DateConfigViewController *dc = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"1234"];
    [self addChildViewController:dc];
    dc.view.frame = self.view.frame;
    [self.view addSubview:dc.view];
    [dc.view didMoveToWindow];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datenum.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"list"];
   
    cell.temp.text = [self.datenum[indexPath.row]tempture];
    cell.date.text = [NSString stringWithFormat:@"%@ - %@",[self.datenum[indexPath.row] startime],[self.datenum[indexPath.row] endtime]];
    cell.dateimg.image = [UIImage imageNamed:@"morning"];
    
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 93;
}

-(void)BtnFunction:(UIButton *)sender{
    if (sender.tag == 1002
        ) {
        tempViewController *tp = [[tempViewController alloc]init];
        [self presentViewController:tp animated:YES completion:nil];
    }else if (sender.tag == 1001){
        AutoViewController *at = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"auto"];
        [self presentViewController:at animated:YES completion:nil];
    }else if (sender.tag == 1003){
        SettingViewController *se = [[SettingViewController alloc]init];
        [self presentViewController:se animated:YES completion:nil];
    }}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
