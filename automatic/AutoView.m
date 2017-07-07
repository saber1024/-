//
//  AutoView.m
//  automatic
//
//  Created by shiki on 2017/7/5.
//  Copyright © 2017年 两仪式. All rights reserved.
//

#import "AutoView.h"
#import <Chameleon.h>
IB_DESIGNABLE
@implementation AutoView

-(void)awakeFromNib{
    [super awakeFromNib];
   
}


-(void)drawRect:(CGRect)rect{
   
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor flatWhiteColor].CGColor);
    CGContextFillEllipseInRect(context, CGRectMake(70, 90, 80, 80));
    CGContextStrokePath(context);
    CGContextSetFillColorWithColor(context, [[UIColor flatWhiteColor] colorWithAlphaComponent:0.5].CGColor);
    CGContextFillEllipseInRect(context, CGRectMake(60, 80, 100, 100));
    CGContextSetFillColorWithColor(context, [[UIColor flatWhiteColor] colorWithAlphaComponent:0.2].CGColor);
    CGContextFillEllipseInRect(context, CGRectMake(50, 70, 120, 120));
    
    CGContextSetLineWidth(context, 2);
    CGContextSetStrokeColorWithColor(context, [[UIColor flatWhiteColor] colorWithAlphaComponent:0.5].CGColor);
    CGContextMoveToPoint(context, 110, 110);
    CGContextAddLineToPoint(context, 110, self.frame.size.height - 80);
    CGContextStrokePath(context);
    CGContextSetFillColorWithColor(context, [UIColor flatWhiteColor].CGColor);
    CGContextFillEllipseInRect(context, CGRectMake(107, self.frame.size.height - 85, 6, 6));
    
    
    CGContextSetFillColorWithColor(context, [UIColor flatWhiteColor].CGColor);
    CGContextFillEllipseInRect(context, CGRectMake(90, 220, 40, 40));
    CGContextSetFillColorWithColor(context, [[UIColor flatWhiteColor] colorWithAlphaComponent:0.2].CGColor);
    CGContextFillEllipseInRect(context, CGRectMake(85, 215, 50, 50));
    
    
    CGContextSetFillColorWithColor(context, [UIColor flatWhiteColor].CGColor);
    CGContextFillEllipseInRect(context, CGRectMake(90, 350, 40, 40));
    CGContextSetFillColorWithColor(context, [[UIColor flatWhiteColor] colorWithAlphaComponent:0.2].CGColor);
    CGContextFillEllipseInRect(context, CGRectMake(85, 345, 50, 50));
    
    CGContextBeginPath(context);
    CGContextAddArc(context, 110, 500, 15, 0, M_PI, 1);
    CGContextClosePath(context);
    CGContextSetFillColorWithColor(context, [[UIColor flatWhiteColor] colorWithAlphaComponent:0.9].CGColor);
    CGContextFillPath(context);
    
    CGContextBeginPath(context);
    CGContextAddArc(context, 110, 500, 20, 0, M_PI, 1);
    CGContextClosePath(context);
    CGContextSetFillColorWithColor(context, [[UIColor flatWhiteColor] colorWithAlphaComponent:0.2].CGColor);
    CGContextFillPath(context);
    
    CGContextMoveToPoint(context, 90, 500);
    CGContextSetStrokeColorWithColor(context, [UIColor flatWhiteColor].CGColor);
    CGContextSetLineWidth(context,2);
    CGContextAddLineToPoint(context, 130, 500);
    CGContextStrokePath(context);

    CGContextMoveToPoint(context, 95, 505);
    CGContextSetStrokeColorWithColor(context, [[UIColor flatWhiteColor] colorWithAlphaComponent:0.5].CGColor);
    CGContextSetLineWidth(context,2);
    CGContextAddLineToPoint(context,125, 505);
    CGContextStrokePath(context);
    
    CGContextMoveToPoint(context, 100, 509);
    CGContextSetStrokeColorWithColor(context, [[UIColor flatWhiteColor] colorWithAlphaComponent:0.5].CGColor);
    CGContextSetLineWidth(context,2);
    CGContextAddLineToPoint(context,120, 509);
    CGContextStrokePath(context);
}

@end
