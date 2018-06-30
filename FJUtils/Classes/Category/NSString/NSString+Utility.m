//
//  NSString+Utility.m
//  XY
//
//  Created by silan on 16/1/9.
//  Copyright © 2016年 XY. All rights reserved.
//

#import "NSString+Utility.h"

@implementation NSString (Utility)

+ (BOOL)isNilOrEmpty:(NSString *)string
{
    if (nil == string)
    {
        return YES;
    }
    else
    {
        if ([string isKindOfClass:[NSNull class]])
        {
            return YES;
        }
        
        if ([string length] <= 0)
        {
            return YES;
        }
        else
        {
            NSRange range = [string rangeOfString:@"null"];
            
            if (range.location == NSNotFound)
            {
                return NO;
            }
            else
            {
                return YES;
            }
            
        }
    }
    
    return [string length] == 0;
}
+ (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL)
    {
        return YES;
    }
    
    if ([string isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0){
        return YES;
    }
    return NO;
}
+ (BOOL)isEmail:(NSString *)str
{
    if ([NSString isNilOrEmpty:str])
    {
        return NO;
    }
    
    NSString *regex = @"\\b([a-zA-Z0-9%_.+\\-]+)@([a-zA-Z0-9.\\-]+?\\.[a-zA-Z]{2,6})\\b";
    
    NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [regexTest evaluateWithObject:str];
}

+ (NSString *)createUUID
{
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    return (__bridge NSString *)string;
}

+ (CGSize)sizeWithLabel:(UILabel *)label str:(NSString *)str
{
    CGSize size = CGSizeMake(label.frame.size.width, label.frame.size.height);
    if(![NSString isNilOrEmpty:str])
    {
        return [str sizeWithConstraint:size font:label.font];
    }
    else
    {
        return CGSizeMake(0, 0);
    }
}

- (CGSize)sizeWithConstraint:(CGSize)size font:(UIFont *)font
{
    NSDictionary *attribute = @{NSFontAttributeName:font};
    
    CGRect rect = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil];
    
    return rect.size;
}

- (CGSize)sizeWithConstraint:(CGSize)size font:(UIFont *)font lineSpacing:(CGFloat)lineSpacing
{
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];
    
    NSDictionary *attribute = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle};
    
    CGRect rect = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil];
    
    return rect.size;
}

- (CGSize)caculateSizeWithFont:(UIFont *)font
{
    if (font)
    {
        NSDictionary *attribute = @{NSFontAttributeName:font};
        
        return [self sizeWithAttributes:attribute];
    }
    
    return CGSizeZero;
}

+ (BOOL)isChiniseString:(NSString *)text
{
    if ([NSString isNilOrEmpty:text]) {
        return NO;
    }
    NSRange range = NSMakeRange(0, 1);
    NSString *subString = [text substringWithRange:range];
    const char *cString= [subString UTF8String];
    if (strlen(cString) == 3) {
        return YES;
    }
    else{
        return NO;
    }
}

+ (NSString *)getEmailName:(NSString *)email
{
    if (![self isEmail:email]) {
        return email;
    }
    
    if(![self isNilOrEmpty:email] )
    {
        NSRange range = [email rangeOfString:@"@"];
        
        return [email substringToIndex:range.location];
    }
    else
    {
        return @"";
    }
}

+ (BOOL)checkStringInArray:(NSString *)str array:(NSArray *)array
{
    if ([array count]  <= 0) {
        return NO;
    }
    
    if ([NSString isNilOrEmpty:str]) {
        return NO;
    }
    
    for (NSString *s in array) {
        if ([str isEqualToString:s]) {
            return YES;
        }
    }
    return NO;
}

// @[@{@"range":@[@(0),@(1)], @"name":NSForegroundColorAttributeName, @"value":[UIColor redColor]}]
- (NSMutableAttributedString *)convertToAttributedString:(NSArray *)attributes
{
    if (attributes)
    {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self];
        
        [attributes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSDictionary *dict = obj;
            NSArray *range = dict[@"range"];
            if (range && range.count == 2)
            {
                NSInteger location = [range[0] integerValue];
                NSInteger length = [range[1] integerValue];
                
                NSString *attributeName = dict[@"name"];
                if (!attributeName)
                {
                    attributeName = NSFontAttributeName;
                }
                
                id value = dict[@"value"];
                if (!value)
                {
                    value = [UIFont systemFontOfSize:14];
                }
                
                if (location >= 0 && location + length <= self.length)
                {
                    NSRange range = NSMakeRange(location, length);
                    
                    [attributedString addAttribute:attributeName value:value range:range];
                }
            }
        }];
        
        return attributedString;
    }
    
    return nil;
}

@end
