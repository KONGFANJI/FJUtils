//
//  FJRouter.m
//  Tumbler
//
//  Created by XY on 2017/1/14.
//  Copyright © 2017年 Kfj. All rights reserved.
//

#import "FJRouter.h"
NSString *const FJRouterParameter = @"FJRouterParameter";
NSString *const FJRouterValue1Key = @"FJRouterValue1Key";

@implementation FJRouter
+(instancetype)shareInstance{
    static FJRouter *store = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        store = [[FJRouter alloc] init];
    });
    
    return store;
}
- (UIViewController *)FJRouterFromVC:(UIViewController *)fromVC toVC:(NSString *)toVC SBName:(NSString *)SBName withParameter:(NSDictionary *)parameter way:(MODALTYPE)way isHideBottom:(BOOL)isHide animated:(BOOL)animated{
    UIViewController *VC;
    
    if (SBName) {
        VC = [self viewControllerWithStoryboardName:SBName andViewControlleridentifier:toVC];
    }else{
        VC = [[NSClassFromString(toVC) alloc] init];
    }
    if (parameter) {
        [VC setValue:parameter forKey:FJRouterParameter];
    }
    
    if (_value1) {
        [VC setValue:_value1 forKey:FJRouterValue1Key];
    }
    
    VC.hidesBottomBarWhenPushed = isHide;
    
    switch (way) {
        case PUSH:
        {
            [fromVC.navigationController pushViewController:VC animated:animated];
        }
            
            break;
            
        case PRESENT:
        {
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:VC];
            [fromVC presentViewController:nav animated:animated completion:^{
            }];
            
        }
            break;
        default:
            break;
    }
    
    _value1 = nil;
    
    return VC;
}


- (id)viewControllerWithStoryboardName:(NSString *)storyboardName andViewControlleridentifier:(NSString *)identifier
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:[NSBundle mainBundle]];
    
    return [storyboard instantiateViewControllerWithIdentifier:identifier];
}


@end
