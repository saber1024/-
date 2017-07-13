//
//  DateCollection.m
//  automatic
//
//  Created by shiki on 2017/7/12.
//  Copyright © 2017年 两仪式. All rights reserved.
//

#import "DateCollection.h"

@implementation DateCollection
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.modelcoll = [NSMutableArray array];
    }
    return self;
}
@end
