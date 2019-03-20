//
//  UIWindow+CurrentVC.m
//  FileTools
//
//  Created by KFJ on 2019/2/24.
//  Copyright © 2019 FJ. All rights reserved.
//

#import "UIWindow+CurrentVC.h"

@implementation UIWindow (CurrentVC)
+ (UIViewController *)fj_topVC{
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    UIViewController *topViewController = [window rootViewController];
    while (true) {
        if (topViewController.presentedViewController) {
            topViewController = topViewController.presentedViewController;
        } else if ([topViewController isKindOfClass:[UINavigationController class]] && [(UINavigationController*)topViewController topViewController]) {
            topViewController = [(UINavigationController *)topViewController topViewController];
        } else if ([topViewController isKindOfClass:[UITabBarController class]]) {
            UITabBarController *tab = (UITabBarController *)topViewController;
            topViewController = tab.selectedViewController;
        } else {
            break;
        }
    }
    return topViewController;
}
@end
