//
//  UIView+Border.h
//  XY
//
//  Created by XY on 2017/2/17.
//  Copyright © 2017年 XY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Border)
- (void)setBorderViewtop:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right borderColor:(UIColor *)color borderWidth:(CGFloat)width;

@end
