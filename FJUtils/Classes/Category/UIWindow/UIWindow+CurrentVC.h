//
//  UIWindow+CurrentVC.h
//  FileTools
//
//  Created by KFJ on 2019/2/24.
//  Copyright © 2019 FJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIWindow (CurrentVC)
+ (UIViewController *)fj_topVC;
@end

NS_ASSUME_NONNULL_END
