//
//  UIView+Screenshot.m
//  XY
//
//  Created by liusilan on 16/1/6.
//  Copyright © 2016年 XY. All rights reserved.
//

#import "UIView+Screenshot.h"

@implementation UIView (Screenshot)

+ (UIImage *)captureImageWithView:(UIView *)view rect:(CGRect)rect
{
    CGRect screenRect =  rect;
    UIGraphicsBeginImageContextWithOptions(screenRect.size, NO, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return viewImage;
}

- (UIImage *)screenShot {
    CGRect screenRect =  self.frame;
    UIGraphicsBeginImageContextWithOptions(screenRect.size, NO, 0.0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return viewImage;
}

@end
