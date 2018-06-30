//
//  NSString+Base64.h
//  XY
//
//  Created by 耳东米青 on 16/8/29.
//  Copyright © 2016年 XY. All rights reserved.
//

#import <Foundation/Foundation.h>

#define __BASE64( text )        [text base64EncodedString]

#define __TEXT( base64 )        [base64 base64DecodedString]

@interface NSString (Base64)

/**
 *  转换为Base64编码
 */
- (NSString *)base64EncodedString;
/**
 *  将Base64编码还原
 */
- (NSString *)base64DecodedString;


@end
