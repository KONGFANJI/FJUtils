//
//  UIViewUtils.m
//  XY
//
//  Created by silan on 16/1/9.
//  Copyright © 2016年 XY. All rights reserved.
//

#import "UIViewUtils.h"
#import "MBProgressHUD.h"
#import "Alert.h"

@implementation UIViewUtils

+ (void)showMessage:(NSString *)msg
{
    [self showMessage:msg duration:AlertLifeTime1Sec];
}

+ (void)showMessage:(NSString *)msg duration:(AlertLifeTime)time {
    [self showMessage:msg position:AlertPositionMiddle duration:time];
}

+ (void)showMessage:(NSString *)msg position:(AlertPosition)position duration:(AlertLifeTime)time {
    [Alert showAlertMessage:msg withPosition:position andLifeTime:time];
}

+ (void)showLoading {
    [self showLoading:@""];
}

+ (void)showLoading:(NSString *)title {
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    
    [self showLoading:title targetView:window];
}

+ (void)showLoading:(NSString *)title targetView:(UIView *)targetView
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:targetView];
    
    [targetView addSubview:hud];
    [hud setLabelText:title];
    [hud show:YES];
}

+ (void)hideLoading:(UIView *)view
{
    [MBProgressHUD hideAllHUDsForView:view animated:YES];
}

+ (void)hideLoading
{
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];

    [MBProgressHUD hideAllHUDsForView:window animated:YES];
}


+ (void)showImageIndicator:(UIView *)view{
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    indicatorView.color = [UIColor whiteColor];
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    hud.mode = MBProgressHUDModeCustomView;
    hud.opacity = 1;
    [hud setColor:[UIColor lightGrayColor]];
    [view addSubview:hud];

    hud.customView = indicatorView;
    
    [hud show:YES];
    
}

@end
