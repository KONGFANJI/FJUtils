//
//  UIButton+Attributes.h
//  WeiZhiKu
//
//  Created by linghang on 2018/6/26.
//  Copyright © 2018年 wangjian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Attributes)
+ (NSMutableAttributedString *)attributesString:(NSString *)btnStr andRange:(NSRange)range andColor:(UIColor *)color andFont:(NSInteger)font andFontName:(NSString *)fontName;
@end
