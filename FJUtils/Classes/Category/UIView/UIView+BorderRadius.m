//
//  UIView+BorderRadius.m
//  XY
//
//  Created by 耳东米青 on 2017/2/17.
//  Copyright © 2017年 XY. All rights reserved.
//

#import "UIView+BorderRadius.h"

@implementation UIView (BorderRadius)

- (void)setCircleWithRadius:(CGFloat)radius andBorderColor:(UIColor *)color andBorderWidth:(CGFloat)width
{
    if (radius > 0) {
        self.layer.cornerRadius = radius;
        self.layer.masksToBounds = YES;
    }
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = width;
}



@end
