//
//  ShikiSetpter.h
//  automatic
//
//  Created by shiki on 2017/7/6.
//  Copyright © 2017年 两仪式. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ShikiSetpter : UIView
@property(nonatomic,assign)IBInspectable int SetpminValue;
@property(nonatomic,assign)IBInspectable int StepMaxValue;
@property(nonatomic,assign)IBInspectable int StepValue;
@property(nonatomic,assign)IBInspectable int Step;
@property(nonatomic,strong)IBInspectable UIColor *BackGroundColor;
@property(nonatomic,strong)IBInspectable UIColor *titleColor;

@end
