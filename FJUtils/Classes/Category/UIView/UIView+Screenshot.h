//
//  UIView+Screenshot.h
//  XY
//
//  Created by liusilan on 16/1/6.
//  Copyright © 2016年 XY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Screenshot)

+ (UIImage *)captureImageWithView:(UIView *)view rect:(CGRect)rect;
- (UIImage *)screenShot;

@end
