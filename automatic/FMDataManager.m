//
//  FMDataManager.m
//  automatic
//
//  Created by shiki on 2017/7/13.
//  Copyright © 2017年 两仪式. All rights reserved.
//

#import "FMDataManager.h"
#import "SettingDataModel.h"
@implementation FMDataManager
+(FMDataManager *)SharedDB{
    static FMDataManager *manger = NULL;
    if (manger == nil) {
        manger = [[FMDataManager alloc]init];
    }
    return manger;
}
-(BOOL)CreateDBWithName:(NSString *)Name{
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filename = [doc stringByAppendingPathComponent:@"persons.sqlite"];
    
    db = [FMDatabase databaseWithPath:filename];
    
    if ([db open]) {
      BOOL result =   [db executeUpdateWithFormat:@"CREATE TABLE IF NOT EXISTS shiki(startime TEXT,endtime TEXT,temeprature TEXT,date TEXT)"];
        if (result) {
            NSLog(@"Create Table success!");
            [db close];

            return true;
        }else{
            NSLog(@"Create Table failure!");
            [db close];
            return false;
            
        }
    }else{
        return false;
    }
}

-(void)insertdbWithModel:(DataBaseModel *)model{
    [db open];
    BOOL flag = [db executeUpdate:@"insert into shiki(startime,endtime,temeprature,date) values (?,?,?,?)",model.startime,model.endtime,model.temperature,model.date];
    if (flag) {
        NSLog(@"新增数据成功!");
        [db close];
    }else{
        NSLog(@"新增数据失败!");
        [db close];
    }
}

-(void)deleteDBWithTitle:(NSString *)title{
    BOOL flag = [db executeUpdate:@"delete form shiki while date = ?",title];
    if (flag) {
        NSLog(@"删除数据成功!");
    }else{
        NSLog(@"删除数据失败!");
    }
}

-(NSMutableArray *)SearchDBwithTitle:(NSString *)title{
    NSMutableArray *result = [NSMutableArray array];
    [db open];

    FMResultSet *res = [db executeQuery:@"select *from shiki where date = ?",title];
    while ([res next]) {
        DataBaseModel *mode = [[DataBaseModel alloc]init];
        mode.startime = [res stringForColumn:@"startime"];
        mode.endtime = [res stringForColumn:@"endtime"];
        mode.temperature = [res stringForColumn:@"temeprature"];
        mode.date = [res stringForColumn:@"date"];
        [result addObject:mode];
    }
    [db close];
    return result;
}

-(NSMutableArray *)SearchAllDB{
    NSMutableArray *result = [NSMutableArray array];
   [db open];
    FMResultSet *res = [db executeQuery:@"select *from shiki"];
    while ([res next]) {
        DataBaseModel *mode = [[DataBaseModel alloc]init];
        mode.startime = [res stringForColumn:@"startime"];
        mode.endtime = [res stringForColumn:@"endtime"];
        mode.temperature = [res stringForColumn:@"temeprature"];
        mode.date = [res stringForColumn:@"date"];
        [result addObject:mode];
    }
     [db close];
    
    return  result;
}

-(NSMutableArray *)SearchAllSettingDB{
    NSMutableArray *result = [NSMutableArray array];
    [db open];
    FMResultSet *res = [db executeQuery:@"select *from Settings"];
    while ([res next]) {
        SettingDataModel *mode = [[SettingDataModel alloc]init];
        mode.compensation = [res stringForColumn:@"compensation"];
        mode.sensor = [res stringForColumn:@"sensor"];
        mode.highprotect = [res stringForColumn:@"high protect"];
        mode.lowprotect = [res stringForColumn:@"low protect"];
        [result addObject:mode];
    }
    [db close];
    
    return  result;
}

-(BOOL)createSettingDB{
    if ([db open]) {
        BOOL result =   [db executeUpdateWithFormat:@"CREATE TABLE IF NOT EXISTS Settings(compensation TEXT,tempdifferences TEXT,sensor TEXT,high protect TEXT,lowprotect TEXT)"];
        if (result) {
            NSLog(@"Create Table success!");
            [db close];
            
            return true;
        }else{
            NSLog(@"Create Table failure!");
            [db close];
            return false;
            
        }
    }else{
        return false;
    }
}


@end
