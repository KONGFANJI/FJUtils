//
//  UITabBar+badge.h
//  XY
//
//  Created by XY on 16/6/14.
//  Copyright © 2016年 XY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (badge)
- (void)showBadgeOnItemIndex:(int)index;//显示小红点

- (void)hideBadgeOnItemIndex:(int)index;//隐藏小红点
@end
