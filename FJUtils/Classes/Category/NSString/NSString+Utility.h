//
//  NSString+Utility.h
//  XY
//
//  Created by silan on 16/1/9.
//  Copyright © 2016年 XY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Utility)

+ (BOOL)isNilOrEmpty:(NSString *)string;
+ (BOOL)isBlankString:(NSString *)string;

+ (BOOL)isEmail:(NSString *)str;

+ (NSString *)createUUID;

+ (CGSize)sizeWithLabel:(UILabel *)label str:(NSString *)str;

- (CGSize)sizeWithConstraint:(CGSize)size font:(UIFont *)font;

- (CGSize)sizeWithConstraint:(CGSize)size font:(UIFont *)font lineSpacing:(CGFloat)lineSpacing;

- (CGSize)caculateSizeWithFont:(UIFont *)font;

+ (BOOL)isChiniseString:(NSString *)text;

+ (NSString *)getEmailName:(NSString *)email;

+ (BOOL)checkStringInArray:(NSString *)str array:(NSArray *)array;

- (NSMutableAttributedString *)convertToAttributedString:(NSArray *)attributes;

@end
