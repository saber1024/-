//
//  ListTableViewCell.h
//  automatic
//
//  Created by shiki on 2017/6/27.
//  Copyright © 2017年 两仪式. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *temp;
@property (weak, nonatomic) IBOutlet UIImageView *dateimg;

@end
