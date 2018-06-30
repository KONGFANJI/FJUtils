//
//  NSString+Base64.m
//  XY
//
//  Created by 耳东米青 on 16/8/29.
//  Copyright © 2016年 XY. All rights reserved.
//

#import "NSString+Base64.h"
//引入IOS自带密码库
//#import <CommonCrypto/CommonCryptor.h>

@implementation NSString (Base64)

/**
 *  系统自带方法base64编码
 */
- (NSString *)base64EncodedString;
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}

/**
 *  系统自带方法base64解码
 */
- (NSString *)base64DecodedString
{
    NSData *data = [[NSData alloc]initWithBase64EncodedString:self options:0];
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}


@end
