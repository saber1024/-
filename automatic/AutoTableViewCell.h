//
//  AutoTableViewCell.h
//  automatic
//
//  Created by shiki on 2017/7/12.
//  Copyright © 2017年 两仪式. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AutoTableViewCell : UITableViewCell
@property(nonatomic,assign)IBInspectable NSIndexPath *index;
@property(nonatomic,strong)UIImageView *img;
@property(nonatomic,strong)UILabel *time;
@property(nonatomic,strong)UILabel *temperature;

@end
