//
//  Display.h
//  manual
//
//  Created by shiki on 2017/6/28.
//  Copyright © 2017年 两仪式. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface Display : UIView
@property(nonatomic,assign)IBInspectable float temp;
@property(nonatomic,strong)IBInspectable UIColor *displayColor;
@property(nonatomic,assign)IBInspectable int NumberOfIteminView;
@property(nonatomic,assign)IBInspectable float curvature;
@property(nonatomic,assign)IBInspectable float SettingTemp;
@property(nonatomic,strong)NSArray *temparr;
@end

