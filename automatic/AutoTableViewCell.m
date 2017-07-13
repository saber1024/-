//
//  AutoTableViewCell.m
//  automatic
//
//  Created by shiki on 2017/7/12.
//  Copyright © 2017年 两仪式. All rights reserved.
//

#import "AutoTableViewCell.h"
#import <Chameleon.h>
IB_DESIGNABLE
@implementation AutoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
   
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.img = [[UIImageView alloc]initWithFrame:CGRectMake(30, 0, 60, 60)];
        [self addSubview:self.img];
        
        self.time = [[UILabel alloc]initWithFrame:CGRectMake(100, 10, 130, 30)];
        self.time.textColor = [UIColor flatWhiteColor];
        self.time.font = [UIFont systemFontOfSize:20];
        [self addSubview:self.time];
        
        
        self.temperature = [[UILabel alloc]initWithFrame:CGRectMake(100, 50, 120, 30)];
        self.temperature.textColor = [[UIColor flatWhiteColor]colorWithAlphaComponent:0.5];
        self.temperature.font = [UIFont systemFontOfSize:17];
        [self addSubview:self.temperature];
        
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 4);
    CGContextSetStrokeColorWithColor(context, [[UIColor flatWhiteColor] colorWithAlphaComponent:0.5].CGColor);
    CGContextMoveToPoint(context, 60, 62);
    CGContextAddLineToPoint(context, 60, self.frame.size.height);
    CGContextStrokePath(context);
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
