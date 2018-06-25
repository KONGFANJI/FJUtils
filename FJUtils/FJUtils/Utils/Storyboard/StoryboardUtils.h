//
//  StoryboardUtils.h
//  XY
//
//  Created by KFJ on 16/1/6.
//  Copyright © 2016年 KFJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface StoryboardUtils : NSObject

+ (UIViewController *)initialviewControllerWithStoryboardName:(NSString *)storyboardName;

+ (UIViewController *)viewControllerWithStoryboardName:(NSString *)storyboardName
                          identifier:(NSString *)identifier;

+ (id)viewControllerWithStoryboardName:(NSString *)storyboardName andViewControlleridentifier:(NSString *)identifier;

@end
