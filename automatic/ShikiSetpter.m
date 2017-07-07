//
//  ShikiSetpter.m
//  automatic
//
//  Created by shiki on 2017/7/6.
//  Copyright © 2017年 两仪式. All rights reserved.
//

#import "ShikiSetpter.h"
IB_DESIGNABLE
@implementation ShikiSetpter
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self SetUpStepter];
    }
    return self;
}


-(void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextMoveToPoint(context, 40, 0);
    CGContextAddLineToPoint(context, 40, self.frame.size.height);
    CGContextStrokePath(context);
    
    CGContextSetLineWidth(context, 1);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextMoveToPoint(context, 80, 0);
    CGContextAddLineToPoint(context, 80, self.frame.size.height);
    CGContextStrokePath(context);
    
}

-(void)SetUpStepter{
    self.backgroundColor = self.backgroundColor;
    
    UIButton *minus = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, self.frame.size.height)];

    [minus setTitle:@"-" forState:UIControlStateNormal];
    minus.titleLabel.font = [UIFont systemFontOfSize:20];
    [minus addTarget:self action:@selector(StepValueMinus:) forControlEvents:UIControlEventTouchUpInside];
    minus.titleLabel.textColor = self.titleColor;
    [self addSubview:minus];
    
    UIView *count = [[UIView alloc]initWithFrame:CGRectMake(40, 0, 40, self.frame.size.height)];
    [count setBackgroundColor:[UIColor clearColor]];
    [self addSubview:count];
    
    UILabel *value = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, count.frame.size.width, count.frame.size.height)];
    value.tag = 1001;
    value.textAlignment = NSTextAlignmentCenter;
    value.textColor = [UIColor whiteColor];
    value.font = [UIFont systemFontOfSize:25];
    value.text = [NSString stringWithFormat:@"%d",_StepValue];
    [count addSubview:value];
    
    
    UIButton *plus = [[UIButton alloc]initWithFrame:CGRectMake(80, 0, 40, self.frame.size.height)];
    [plus addTarget:self action:@selector(StepValuePlus:) forControlEvents:UIControlEventTouchUpInside];
    [plus setTitle:@"+" forState:UIControlStateNormal];
    plus.titleLabel.font = [UIFont systemFontOfSize:20];
    plus.titleLabel.textColor = self.titleColor;
    [self addSubview:plus];
}

-(void)StepValuePlus:(UIButton *)sender{
    UILabel *valuelb = (UILabel *)[self viewWithTag:1001];
    int currvalue = [valuelb.text intValue];
    if (currvalue+_Step < self.StepMaxValue +1) {
        valuelb.text = [NSString stringWithFormat:@"%d",currvalue + self.Step];
    }
    
}

-(void)StepValueMinus:(UIButton *)sender{
    UILabel *valuelb = (UILabel *)[self viewWithTag:1001];
    int currvalue = [valuelb.text intValue];
    if (currvalue - _Step > self.SetpminValue - 1) {
        valuelb.text = [NSString stringWithFormat:@"%d",currvalue - self.Step];

    }
}

@end
