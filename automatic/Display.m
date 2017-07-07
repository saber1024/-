//
//  Display.m
//  manual
//
//  Created by shiki on 2017/6/28.
//  Copyright © 2017年 两仪式. All rights reserved.
//

#import "Display.h"
#import "Chameleon.h"
IB_DESIGNABLE
@implementation Display

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self ConfigView];

    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();

    
    for (int i = 0; i<8; i++) {
        CGContextMoveToPoint(context, self.frame.size.width - 30,self.frame.size.height - 30 - i * 35);
        CGContextAddLineToPoint(context, self.frame.size.width, self.frame.size.height - 30 - i * 35);
        CGContextSetLineWidth(context, 1);
        CGContextSetStrokeColorWithColor(context, [UIColor flatRedColor].CGColor);
        CGContextStrokePath(context);
        
        
        NSString *s = [NSString stringWithFormat:@"%d",i * 10];
        NSDictionary<NSString *,id> *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:15],NSForegroundColorAttributeName :[UIColor flatRedColor]};
        [s drawInRect:CGRectMake(10, self.frame.size.height - 40 - i *35, 20, 20) withAttributes:dic];
    }
}

-(void)ConfigView{
 
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
}



@end
