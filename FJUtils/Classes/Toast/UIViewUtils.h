//
//  UIViewUtils.h
//  XY
//
//  Created by silan on 16/1/9.
//  Copyright © 2016年 XY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Alert.h"

@interface UIViewUtils : NSObject

+ (void)showMessage:(NSString *)msg;

+ (void)showMessage:(NSString *)msg duration:(AlertLifeTime)time;

+ (void)showMessage:(NSString *)msg position:(AlertPosition)position duration:(AlertLifeTime)time;

+ (void)showLoading;
+ (void)showLoading:(NSString *)title;

+ (void)showLoading:(NSString *)title targetView:(UIView *)targetView;

+ (void)hideLoading:(UIView *)view;

+ (void)hideLoading;

+ (void)showImageIndicator:(UIView *)view;

@end
