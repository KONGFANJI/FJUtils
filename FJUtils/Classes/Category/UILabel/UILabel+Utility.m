//
//  UILabel+Utility.m
//  Fashion
//
//  Created by 耳东米青 on 15/11/4.
//  Copyright © 2015年 王进华. All rights reserved.
//

#import "UILabel+Utility.h"
#import <CoreText/CoreText.h>

@implementation UILabel (Utility)

- (CGSize)sizeWithWidth:(CGFloat)width andLineSpacing:(CGFloat)lineSpacing
{
    if (self.text.length > 0) {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:self.text];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        [paragraphStyle setLineSpacing:lineSpacing];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.text.length)];
        self.attributedText = attributedString;
        CGSize size = CGSizeMake(width, MAXFLOAT);
        CGSize labelSize = [self sizeThatFits:size];
        
        self.lineBreakMode = NSLineBreakByTruncatingTail;
        return labelSize;
    }
    return CGSizeZero;
}

-(void)changeAligmentRightAndLeft{
    
    CGSize textSize = [self.text boundingRectWithSize:CGSizeMake(self.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : self.font} context:nil].size;
    
    CGFloat margion = (self.frame.size.width - textSize.width) / (self.text.length - 1);
    
    NSNumber *number = [NSNumber numberWithFloat:margion];
    
    NSMutableAttributedString *attrbuteString = [[NSMutableAttributedString alloc]initWithString:self.text];
    [attrbuteString addAttribute:(id)kCTKernAttributeName value:number range:NSMakeRange(0, self.text.length - 1)];
    
    self.attributedText = attrbuteString;
}
@end
