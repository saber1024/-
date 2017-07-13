//
//  FMDataManager.h
//  automatic
//
//  Created by shiki on 2017/7/13.
//  Copyright © 2017年 两仪式. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>
#import "DataBaseModel.h"
@interface FMDataManager : NSObject{
    FMDatabase *db;
}


+(FMDataManager *)SharedDB;
-(BOOL)CreateDBWithName:(NSString *)Name;
-(BOOL)createSettingDB;
-(void)insertdbWithModel:(DataBaseModel *)model;
-(void)deleteDBWithTitle:(NSString *)title;
-(NSMutableArray*)SearchDBwithTitle:(NSString *)title;
-(NSMutableArray *)SearchAllDB;
-(NSMutableArray *)SearchAllSettingDB;


@end
