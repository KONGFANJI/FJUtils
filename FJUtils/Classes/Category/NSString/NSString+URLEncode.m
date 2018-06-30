//
//  NSString+URLEncode.m
//  Fashion
//
//  Created by liusilan on 14/12/9.
//  Copyright (c) 2014年 王进华. All rights reserved.
//

#import "NSString+URLEncode.h"

@implementation NSString (URLEncode)

+ (NSString*)encodeURL:(NSString *)string
{
    NSString *newString = CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)string, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));
    if (newString) {
        return newString;
    }
    return @"";
}

@end
