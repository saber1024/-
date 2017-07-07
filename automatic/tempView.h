//
//  tempView.h
//  manual
//
//  Created by shiki on 2017/6/30.
//  Copyright © 2017年 两仪式. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface tempView : UIView
@property(nonatomic,strong)NSArray *temparr;
@property(nonatomic,strong)IBInspectable NSString *lowprotect;
@property(nonatomic,strong)IBInspectable NSString *hightprotect;
@property(nonatomic,strong)IBInspectable UIColor *tempColor;
@property(nonatomic,assign)CGFloat tempheight;
@property(nonatomic,assign)CGFloat waveheight;
@property(nonatomic,assign)CGFloat currenttemp;
@end
