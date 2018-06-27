//
//  StoryboardUtils.m
//  XY
//
//  Created by KFJ on 16/1/6.
//  Copyright © 2016年 KFJ. All rights reserved.
//

#import "StoryboardUtils.h"

@implementation StoryboardUtils

+ (UIViewController *)viewControllerWithStoryboardName:(NSString *)storyboardName
                          identifier:(NSString *)identifier {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:[NSBundle mainBundle]];

    return [storyboard instantiateViewControllerWithIdentifier:identifier];
}

+ (id)viewControllerWithStoryboardName:(NSString *)storyboardName andViewControlleridentifier:(NSString *)identifier
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:[NSBundle mainBundle]];
    
    return [storyboard instantiateViewControllerWithIdentifier:identifier];
}

+ (UIViewController *)initialviewControllerWithStoryboardName:(NSString *)storyboardName {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:[NSBundle mainBundle]];

    return [storyboard instantiateInitialViewController];
}
@end
