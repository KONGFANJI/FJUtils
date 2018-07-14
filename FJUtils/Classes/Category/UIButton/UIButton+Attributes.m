//
//  UIButton+Attributes.m
//  WeiZhiKu
//
//  Created by linghang on 2018/6/26.
//  Copyright © 2018年 wangjian. All rights reserved.
//

#import "UIButton+Attributes.h"

@implementation UIButton (Attributes)
+ (NSMutableAttributedString *)attributesString:(NSString *)btnStr andRange:(NSRange)range andColor:(UIColor *)color andFont:(NSInteger)font andFontName:(NSString *)fontName{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",btnStr]];
    if (fontName) {
        [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:fontName size:font] range:range];

    }else{
        
    }
    [str addAttribute:NSForegroundColorAttributeName value:color range:range];
    return str ;
}



@end
