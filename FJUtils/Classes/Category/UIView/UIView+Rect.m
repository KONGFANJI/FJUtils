//
//  UIView+Rect.m
//  XY
//
//  Created by liusilan on 16/1/6.
//  Copyright © 2016年 XY. All rights reserved.
//

#import "UIView+Rect.h"

@implementation UIView (Rect)

- (void)setFj_x:(float)fj_x
{
    self.frame=CGRectMake(fj_x, CGRectGetMinY(self.frame), CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
}

- (void)setFj_y:(float)fj_y
{
    self.frame=CGRectMake(CGRectGetMinX(self.frame), fj_y, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
}

- (void)setFj_width:(float)fj_width
{
    self.frame=CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), fj_width, CGRectGetHeight(self.bounds));
}

- (void)setFj_height:(float)fj_height
{
    self.frame=CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), CGRectGetWidth(self.bounds), fj_height);
}

- (void)setFj_origin:(CGPoint)fj_origin
{
    self.frame=CGRectMake(fj_origin.x, fj_origin.y, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
}

- (void)setFj_size:(CGSize)fj_size
{
    self.frame=CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), fj_size.width, fj_size.height);
}

- (float)fj_x
{
    return CGRectGetMinX(self.frame);
}

- (float)fj_y
{
    return CGRectGetMinY(self.frame);
}

- (float)fj_width
{
    return CGRectGetWidth(self.frame);
}

- (float)fj_height
{
    return CGRectGetHeight(self.frame);
}

- (CGPoint)fj_origin
{
    return self.frame.origin;
}

- (CGSize)fj_size
{
    return self.bounds.size;
}

@end
