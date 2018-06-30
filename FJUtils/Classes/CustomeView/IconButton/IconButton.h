//
//  IconButton.h
//  BeiAi
//
//  Created by summer on 14-3-18.
//  Copyright (c) 2014年 Shenzhen Mobile Dream Network Science & Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum
{
    IconButtonHorizonalLeft = 0,
    IconButtonHorizonalRight,
    IconButtonVerticalTop,
    IconButtonVerticalBottom
} IconButtonType;

@interface IconButton : UIButton

@property (nonatomic, strong) UIImage *normalImage;
@property (nonatomic, strong) UIImage *pressImage;
@property (nonatomic, strong) UIImage *icon;
@property (nonatomic, strong) UIImage *pressedIcon;

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) UIColor *selectedColor;
@property (nonatomic, assign) NSInteger midMargin;          // 图标和文字间距
@property (nonatomic, assign) NSInteger leftMargin;         // 左边距
@property (nonatomic, assign) NSInteger topMargin;
@property (nonatomic, assign) IconButtonType type;
@property (nonatomic, assign) CGFloat constraindWidth;

- (CGSize)titleSize;

- (CGFloat)buttonWidth;
- (void)sizeToFit;

- (id)initWithFrame:(CGRect)frame normalImage:(UIImage *)normalImage pressedImage:(UIImage *)pressedImage;

@end
