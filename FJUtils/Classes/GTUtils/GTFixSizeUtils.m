//
//  GTFixSizeUtils.m
//  Fashion
//
//  Created by silan on 15/4/19.
//  Copyright (c) 2015年 王进华. All rights reserved.
//

#import "GTFixSizeUtils.h"

#define iPhone5_height1      568
#define iPhone5_width1       320
#define iPhone6_width1       375
#define ScreenWidth1  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight1 [UIScreen mainScreen].bounds.size.height

CGFloat GTFixHeightFloat(CGFloat height)
{
    if (ScreenHeight1 / iPhone5_height1 <= 1) {
        return height;
    }
    height = height*ScreenHeight1/iPhone5_height1;
    return height;
}

CGFloat GTFixWidthFloat(CGFloat width)
{
    if (ScreenHeight1/iPhone5_height1 <= 1) {
        return width;
    }
    width = width*ScreenWidth1/iPhone5_width1;

    return width;
}

CGFloat GTScale()
{
    if (ScreenWidth1 > iPhone5_width1)
    {
        return ScreenWidth1/iPhone5_width1;
    }

    return 1;
}

CGFloat GTNewScale()
{
    if (ScreenWidth1 != iPhone6_width1)
    {
        return ScreenWidth1/iPhone6_width1;
    }
    
    return 1;
}

CGRect GTRectMake(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
    CGRect rect;
    rect.origin.x = x; rect.origin.y = y;
    rect.size.width = GTFixWidthFloat(width); rect.size.height = GTFixHeightFloat(height);
    return rect;
}

CGSize GTSize(CGSize size)
{
    CGFloat scale = GTScale();

    return CGSizeMake(size.width * scale, size.height * scale);
}
