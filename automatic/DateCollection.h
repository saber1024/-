//
//  DateCollection.h
//  automatic
//
//  Created by shiki on 2017/7/12.
//  Copyright © 2017年 两仪式. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DateModel.h"
@interface DateCollection : NSObject
@property(nonatomic,strong)NSString *date;
@property(nonatomic,strong)NSMutableArray<DateModel *> *modelcoll;
@end
