//
//  tempView.m
//  manual
//
//  Created by shiki on 2017/6/30.
//  Copyright © 2017年 两仪式. All rights reserved.
//

#import "tempView.h"
#import "Chameleon.h"

IB_DESIGNABLE
@implementation tempView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        self.layer.borderWidth = 1;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGRect rectangle = CGRectMake(0, self.frame.size.height - 30 - (self.currenttemp/10) * 35, self.frame.size.width,150);
    
    // 获取当前图形，视图推入堆栈的图形，相当于你所要绘制图形的图纸
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 在当前路径下添加一个矩形路径
    CGContextAddRect(ctx, rectangle);
    
    // 设置试图的当前填充色
    CGContextSetFillColorWithColor(ctx, self.tempColor.CGColor);
    
    // 绘制当前路径区域
    CGContextFillPath(ctx);
    
    
    CGContextSetLineWidth(ctx, 2.0f);
    CGContextSetLineDash(ctx, 0, (CGFloat[]){10, 5}, 2);//绘制10个跳过5个
    CGContextSetStrokeColorWithColor(ctx, [[UIColor flatRedColor] CGColor]);
    CGContextMoveToPoint(ctx, 0,105);
    CGContextAddLineToPoint(ctx, self.frame.size.width,105);
    CGContextStrokePath(ctx);
    
    
    
    CGContextSetLineWidth(ctx, 2.0f);
    CGContextSetLineDash(ctx, 0, (CGFloat[]){10, 5}, 2);//绘制10个跳过5个
    CGContextSetStrokeColorWithColor(ctx, [[UIColor flatSkyBlueColor] CGColor]);
    CGContextMoveToPoint(ctx, 0,self.frame.size.height - 44);
    CGContextAddLineToPoint(ctx, self.frame.size.width,self.frame.size.height - 44);
    CGContextStrokePath(ctx);

    NSDictionary<NSString *,id> *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:25],NSForegroundColorAttributeName :[UIColor flatRedColor]};
    [self.hightprotect drawInRect:CGRectMake(50, 70, 80, 30) withAttributes:dic];
    
    
    NSDictionary<NSString *,id> *dic1 = @{NSFontAttributeName : [UIFont systemFontOfSize:25],NSForegroundColorAttributeName :[UIColor flatSkyBlueColor]};
    [self.lowprotect drawInRect:CGRectMake(50, self.frame.size.height - 40, 80, 30) withAttributes:dic1];
    
    
   
    
}



@end
