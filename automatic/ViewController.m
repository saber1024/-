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
#import "automatic-Swift.h"
#import "tempViewController.h"
#import "AutoViewController.h"
#import "SettingViewController.h"
#import "ConfigViewController.h"
#import "DateModel.h"
#import "DateCollection.h"
#import "DataBaseModel.h"
#import "FMDataManager.h"
int date = 1;

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *dateList;
@property(nonatomic,strong)NSMutableArray *datenum;
@property(nonatomic,strong) UILabel *weekend;
@property(nonatomic,strong)FMDataManager *manger;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.datenum = [NSMutableArray array];
    
    
    
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timg.jpeg"]];
    
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *vi = [[UIVisualEffectView alloc]initWithFrame:self.view.frame];
    vi.effect = blur;
    [self.view addSubview:vi];
    
    
    UIView *back = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 100, self.view.frame.size.width, 0.5)];
    back.backgroundColor = [UIColor whiteColor];
    [vi addSubview:back];
    
    
    _weekend  = [[UILabel alloc]initWithFrame:CGRectMake(self.view.center.x - 20, self.view.frame.size.height - 175, 120, 30)];
    _weekend.text = @"周一";
    _weekend.font = [UIFont systemFontOfSize:25];
    _weekend.textColor = [UIColor whiteColor];
    [vi addSubview:_weekend];
    for (int i = 0; i<7; i++) {
        DateCollection *mode = [[DateCollection alloc]init];
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        formatter.numberStyle = kCFNumberFormatterRoundHalfDown;
        NSString *string = [formatter stringFromNumber:[NSNumber numberWithInt:i+1]];
        
        mode.date = [NSString stringWithFormat:@"周%@",string];
        [self.datenum addObject:mode];
    }

    FMDataManager *manger= [FMDataManager SharedDB];
    self.manger = manger;
    NSMutableArray *result = [manger SearchAllDB];
    NSLog(@"%@",result);
    if (result.count == 0) {
        NSLog(@"未能查找到数据!");
    }else{
        for (int i = 0; i<result.count; i++) {
            DataBaseModel *mod = result[i];
            NSString *s  = [mod.date substringWithRange:NSMakeRange(1, 1)];
            NSString *s1 = [self arabicNumberalsFromChineseNumberals:s];
            int weekend = [s1 intValue];
            
            DateCollection *mo = self.datenum[weekend];
            DateModel *mode = [[DateModel alloc]init];
            mode.startime = mod.startime;
            mode.endtime = mod.endtime;
            mode.tempture = mod.temperature;
            [mo.modelcoll addObject:mode];
            [self.dateList reloadData];
            NSLog(@"数据集合 --- %@",mo.modelcoll);
        }
        
        
    }
    
    
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
    
    NSArray *btnimg  = @[@"开关",@"时钟",@"手动",@"风车"];
    for (int i = 0; i<4; i++) {
        UIView *func = [[UIView alloc]initWithFrame:CGRectMake(i *(self.view.frame.size.width / 4), self.view.frame.size.height - 100, self.view.frame.size.width/4, 100)];
        func.layer.borderWidth = 0.5;
        func.layer.borderColor = [UIColor whiteColor].CGColor;
        func.backgroundColor = [UIColor clearColor];
        [vi addSubview:func];
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
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.center.x -70, self.view.frame.size.height - 180, 35, 35)];
    img.image = [UIImage imageNamed:@"日历"];
    [vi addSubview:img];
    
    
    UISwipeGestureRecognizer *sipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(SwipeTochangeDate:)];
    [sipe setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.weekend addGestureRecognizer:sipe];
    
    UISwipeGestureRecognizer *sipe1 = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(SwipeTochangeDate:)];
    [sipe1 setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.weekend addGestureRecognizer:sipe1];
    self.weekend.userInteractionEnabled = YES;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ReloadDateNoti:) name:@"Date" object:nil];
    
}

-(void)SwipeTochangeDate:(UISwipeGestureRecognizer *)gust{
    
    if (gust.direction == UISwipeGestureRecognizerDirectionLeft) {
        NSString *s  = [self.weekend.text substringWithRange:NSMakeRange(1, 1)];
        NSString *s1 = [self arabicNumberalsFromChineseNumberals:s];
        int weekend = [s1 intValue];
        if (weekend > 1) {
            weekend -= 1;
            NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
            formatter.numberStyle = kCFNumberFormatterRoundHalfDown;
            NSString *string = [formatter stringFromNumber:[NSNumber numberWithInt:weekend]];
            self.weekend.text = [NSString stringWithFormat:@"周%@",string];
            [self.dateList reloadData];
        }
          }
    
    else{
        NSString *s  = [self.weekend.text substringWithRange:NSMakeRange(1, 1)];
        NSString *s1 = [self arabicNumberalsFromChineseNumberals:s];
        int weekend = [s1 intValue];
        if (weekend <7) {
            weekend += 1;
            NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
            formatter.numberStyle = kCFNumberFormatterRoundHalfDown;
            NSString *string = [formatter stringFromNumber:[NSNumber numberWithInt:weekend]];
            NSLog(@"%@",string);
            self.weekend.text = [NSString stringWithFormat:@"周%@",string];
             [self.dateList reloadData];
        }
    }
}


-(void)ReloadDateNoti:(NSNotification *)noti{
    NSString *startime = (NSString *)[noti.userInfo valueForKey:@"启动时间"];
    NSString *endtime = (NSString *)[noti.userInfo valueForKey:@"结束时间"];
    NSString *temp = (NSString *)[noti.userInfo valueForKey:@"温度"];
    
    NSString *s  = [self.weekend.text substringWithRange:NSMakeRange(1, 1)];
    NSString *s1 = [self arabicNumberalsFromChineseNumberals:s];
    int weekend = [s1 intValue];
   
    DateCollection *mo = self.datenum[weekend];
    DateModel *mod = [[DateModel alloc]init];
    mod.startime = startime;
    mod.endtime = endtime;
    mod.tempture = temp;
    [mo.modelcoll addObject:mod];
    
    DataBaseModel *model = [[DataBaseModel alloc]init];
    model.startime = startime;
    model.endtime = endtime;
    model.temperature = temp;
    model.date = self.weekend.text;
    
    [self.manger insertdbWithModel:model];
    
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
    
  
    NSString *s  = [self.weekend.text substringWithRange:NSMakeRange(1, 1)];
    NSString *s1 = [self arabicNumberalsFromChineseNumberals:s];
    int weekend = [s1 intValue];
    DateCollection *mo = self.datenum[weekend];
    
    return mo.modelcoll.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"list"];
   
  
        NSString *s  = [self.weekend.text substringWithRange:NSMakeRange(1, 1)];
        NSString *s1 = [self arabicNumberalsFromChineseNumberals:s];
        int weekend = [s1 intValue];
        DateCollection *mo = self.datenum[weekend];
        
        NSString *time = [NSString stringWithFormat:@"%@ - %@",[mo.modelcoll[indexPath.row]startime],[mo.modelcoll[indexPath.row]endtime]];
        cell.date.text = time;
        cell.temp.text = [mo.modelcoll[indexPath.row]tempture];
    
    
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
        at.weekend = self.weekend.text;
        [self presentViewController:at animated:YES completion:nil];
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


- (NSString *)arabicNumberalsFromChineseNumberals:(NSString *)arabic{
    NSMutableDictionary * mdic =[[NSMutableDictionary alloc]init];
    
    [mdic setObject:[NSNumber numberWithInt:10000] forKey:@"万"];
    [mdic setObject:[NSNumber numberWithInt:1000] forKey:@"千"];
    [mdic setObject:[NSNumber numberWithInt:100] forKey:@"百"];
    [mdic setObject:[NSNumber numberWithInt:10] forKey:@"十"];
    
    [mdic setObject:[NSNumber numberWithInt:9] forKey:@"九"];
    [mdic setObject:[NSNumber numberWithInt:8] forKey:@"八"];
    [mdic setObject:[NSNumber numberWithInt:7] forKey:@"七"];
    [mdic setObject:[NSNumber numberWithInt:6] forKey:@"六"];
    [mdic setObject:[NSNumber numberWithInt:5] forKey:@"五"];
    [mdic setObject:[NSNumber numberWithInt:4] forKey:@"四"];
    [mdic setObject:[NSNumber numberWithInt:3] forKey:@"三"];
    [mdic setObject:[NSNumber numberWithInt:2] forKey:@"二"];
    [mdic setObject:[NSNumber numberWithInt:2] forKey:@"两"];
    [mdic setObject:[NSNumber numberWithInt:1] forKey:@"一"];
    [mdic setObject:[NSNumber numberWithInt:0] forKey:@"零"];
    
    //    NSLog(@"%@",mdic);
    
    BOOL flag=YES;//yes表示正数，no表示负数
    NSString * s=[arabic substringWithRange:NSMakeRange(0, 1)];
    if([s isEqualToString:@"负"]){
        flag=NO;
    }
    int i=0;
    if(!flag){
        i=1;
    }
    int sum=0;//和
    int num[20];//保存单个汉字信息数组
    for(int i=0;i<20;i++){//将其全部赋值为0
        num[i]=0;
    }
    int k=0;//用来记录数据的个数
    
    //如果是负数，正常的数据从第二个汉字开始，否则从第一个开始
    for(;i<[arabic length];i++){
        NSString * key=[arabic substringWithRange:NSMakeRange(i, 1)];
        int tmp=[[mdic valueForKey:key] intValue];
        num[k++]=tmp;
    }
    //将获得的所有数据进行拼装
    for(int i=0;i<k;i++){
        if(num[i]<10&&num[i+1]>=10){
            sum+=num[i]*num[i+1];
            i++;
        }else{
            sum+=num[i];
        }
    }
    NSMutableString * result=[[NSMutableString alloc]init];;
    if(flag){//如果正数
        result=[NSMutableString stringWithFormat:@"%d",sum];
    }else{//如果负数
        result=[NSMutableString stringWithFormat:@"-%d",sum];
    }
    return result;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
