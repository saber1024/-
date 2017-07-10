//
//  CalendarViewController.m
//  automatic
//
//  Created by shiki on 2017/6/27.
//  Copyright © 2017年 两仪式. All rights reserved.
//

#import "CalendarViewController.h"
#import "FSCalendar.h"
#import <Chameleon.h>
#import "AutoViewController.h"
#define ScrHeight [UIScreen mainScreen].bounds.size.height
#define ScrWidth  [UIScreen mainScreen].bounds.size.width

@interface PlaneModle : NSObject
@property(nonatomic,strong)NSString *time;
@property(nonatomic,strong)NSString *temp;
@end

@implementation PlaneModle


@end

@interface CalendarViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *list;
@property(nonatomic,strong)UITableView *week;
@end

@implementation CalendarViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.Datecollection = [NSMutableArray array];
    
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timg.jpeg"]];
    
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *vi = [[UIVisualEffectView alloc]initWithFrame:self.view.frame];
    vi.effect = blur;
    [self.view addSubview:vi];
    
    self.list = [[NSMutableArray alloc]initWithObjects:@"周一",@"周二",@"周三",@"周四",@"周五" , nil];
    self.week = [[UITableView alloc]initWithFrame:CGRectMake(10, 80, self.view.frame.size.width  - 20, 350) style:UITableViewStylePlain];
    self.week.delegate = self;
    self.week.backgroundColor = [UIColor clearColor];
    self.week.dataSource = self;
    [vi addSubview:self.week];
    
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
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.list.count
    ;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont systemFontOfSize:20];
        cell.detailTextLabel.textColor = [UIColor whiteColor];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:20];
        cell.textLabel.text = self.list[indexPath.row];
        if (indexPath.row != 0) {
            cell.detailTextLabel.text = @"未设置";
        }else{
            cell.detailTextLabel.text = @"已设置";
        }
    }
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(void)SaveSetting{
   
    AutoViewController *tp = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]]instantiateViewControllerWithIdentifier:@"auto"];
    [self presentViewController:tp animated:YES completion:nil];
}

-(void)CancelSetting{
    [self dismissViewControllerAnimated:YES completion:nil];
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
