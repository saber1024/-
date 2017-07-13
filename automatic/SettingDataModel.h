//
//  SettingDataModel.h
//  automatic
//
//  Created by shiki on 2017/7/13.
//  Copyright © 2017年 两仪式. All rights reserved.
//

#import <Foundation/Foundation.h>
//CREATE TABLE IF NOT EXISTS Settings(compensation TEXT,tempdifferences TEXT,sensor TEXT,high protect TEXT,lowprotect TEXT
@interface SettingDataModel : NSObject
@property(nonatomic,strong)NSString *compensation;
@property(nonatomic,strong)NSString *tempdifferences;
@property(nonatomic,strong)NSString *sensor;
@property(nonatomic,strong)NSString *highprotect;
@property(nonatomic,strong)NSString *lowprotect;
@end
