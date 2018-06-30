//
//  IconButton.m
//  BeiAi
//
//  Created by summer on 14-3-18.
//  Copyright (c) 2014年 Shenzhen Mobile Dream Network Science & Technology Co.,Ltd. All rights reserved.
//

#import "IconButton.h"
#import "NSString+Utility.h"
#import "UIView+Rect.h"

@interface IconButton ()
{
    UIImageView *imageView;
    UILabel *label;
}
@end

@implementation IconButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if (self)
    {
        self.adjustsImageWhenHighlighted = NO;

        imageView = [[UIImageView alloc] initWithFrame:CGRectZero];

        imageView.clipsToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFit;

        [self addSubview:imageView];

        // 默认font
        self.font = [UIFont fontWithName:@"FZLanTingHeiS-R-GB" size:12];
        self.color = [UIColor whiteColor];

        _type = IconButtonHorizonalLeft;
        _midMargin = 5;

        label = [[UILabel alloc] initWithFrame:CGRectZero];

        label.backgroundColor = [UIColor clearColor];
        label.font = _font;
        label.textColor = _color;
        label.lineBreakMode = NSLineBreakByTruncatingTail;
        
        [self addSubview:label];
    }

    return self;
}

- (id)initWithFrame:(CGRect)frame normalImage:(UIImage *)normalImage pressedImage:(UIImage *)pressedImage
{
    self = [super initWithFrame:frame];

    if (self)
    {
        self.adjustsImageWhenHighlighted = NO;

        [self setBackgroundImage:normalImage forState:UIControlStateNormal];
        [self setBackgroundImage:pressedImage forState:UIControlStateHighlighted];
        [self setBackgroundImage:pressedImage forState:UIControlStateSelected];

        imageView = [[UIImageView alloc] initWithFrame:CGRectZero];

        [self addSubview:imageView];

        // 默认font
        self.font = [UIFont fontWithName:@"FZLanTingHeiS-R-GB" size:12];
        self.color = [UIColor whiteColor];

        _type = IconButtonHorizonalLeft;
        _midMargin = 5;

        label = [[UILabel alloc] initWithFrame:CGRectZero];

        label.backgroundColor = [UIColor clearColor];
        label.font = _font;
        label.textColor = _color;

        [self addSubview:label];
    }

    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    CGSize size = [self titleSize];

    label.fj_size = size;

    if (_constraindWidth != 0)
    {
        label.fj_width = _constraindWidth;
    }

    if (imageView.image == nil)
    {
        label.frame = CGRectMake((self.fj_width - size.width) / 2, (self.fj_height - size.height) /2, size.width, size.height);
        return;
    }

    // 图标在文字左方
    if (_type == IconButtonHorizonalLeft)
    {
        if (label.fj_width == 0)
        {
            imageView.fj_origin = CGPointMake((self.fj_width - imageView.fj_width) / 2, (self.fj_height - imageView.fj_height) / 2);
        }
        else
        {
            if (_leftMargin > 0)
            {
                imageView.fj_origin = CGPointMake(_leftMargin, (self.fj_height - imageView.fj_height) / 2);
            }
            else
            {
                CGFloat width = imageView.fj_width + _midMargin + label.fj_width;
                imageView.fj_origin = CGPointMake((self.fj_width - width) / 2, (self.fj_height - imageView.fj_height) / 2);
            }

            label.fj_origin = CGPointMake(imageView.fj_x + imageView.fj_width + _midMargin, (self.fj_height - label.fj_height) / 2);
        }
    }
    // 图标在文字右方
    else if (_type == IconButtonHorizonalRight)
    {
        if (label.text.length == 0)
        {
            imageView.fj_origin = CGPointMake((self.fj_width - imageView.fj_width) / 2, (self.fj_height - imageView.fj_height) / 2);
        }
        else
        {
            if (_leftMargin > 0)
            {
                label.fj_origin = CGPointMake(_leftMargin, (self.fj_height - label.fj_height) / 2);
            }
            else
            {
                CGFloat width = label.fj_width + _midMargin + imageView.fj_width;
                label.fj_origin = CGPointMake((self.fj_width - width) / 2, (self.fj_height - label.fj_height) / 2);
            }

            imageView.fj_origin = CGPointMake(label.fj_x + label.fj_width + _midMargin, (self.fj_height - imageView.fj_height) / 2);
        }
    }
    // 图标在文字上方
    else if (_type == IconButtonVerticalTop)
    {
        if (label.text.length == 0)
        {
            imageView.fj_origin = CGPointMake((self.fj_width - imageView.fj_width) / 2, (self.fj_height - imageView.fj_height) / 2);
        }
        else
        {
            if (_topMargin > 0)
            {
                imageView.fj_origin = CGPointMake((self.fj_width - imageView.fj_width) / 2, _topMargin);
            }
            else
            {
                CGFloat height = imageView.fj_height + _midMargin + label.fj_height;
                imageView.fj_origin = CGPointMake((self.fj_width - imageView.fj_width) / 2, (self.fj_height - height) / 2);
            }

            label.fj_origin = CGPointMake((self.fj_width - label.fj_width) / 2, imageView.fj_y + imageView.fj_height + _midMargin);
        }
    }
    // 图标在文字下方
    else if (_type == IconButtonVerticalBottom)
    {
        if (label.text.length == 0)
        {
            imageView.fj_origin = CGPointMake((self.fj_width - imageView.fj_width) / 2, (self.fj_height - imageView.fj_height) / 2);
        }
        else
        {
            if (_topMargin > 0)
            {
                imageView.fj_origin = CGPointMake((self.fj_width - imageView.fj_width) / 2, _topMargin);
            }
            else
            {
                CGFloat height = label.fj_height + _midMargin + imageView.fj_height;
                CGFloat startY = (self.fj_height - height) / 2;

                label.fj_origin = CGPointMake((self.fj_width - label.fj_width) / 2, startY);
                imageView.fj_origin = CGPointMake((self.fj_width - imageView.fj_width) / 2, label.fj_y + label.fj_height + _midMargin);
            }
        }
    }
}

- (void)setConstraindWidth:(CGFloat)constraindWidth
{
    _constraindWidth = constraindWidth;

    [self layoutSubviews];
}

- (void)setNormalImage:(UIImage *)normalImage
{
    _normalImage = normalImage;

    [self setBackgroundImage:normalImage forState:UIControlStateNormal];
}

- (void)setPressImage:(UIImage *)pressImage
{
    _pressImage = pressImage;

    [self setBackgroundImage:pressImage forState:UIControlStateHighlighted];
}

- (void)setIcon:(UIImage *)icon
{
    _icon = icon;

    imageView.image = icon;
    imageView.fj_size = icon.size;

    [self layoutSubviews];
}

- (void)updateIcon:(BOOL)fPressed
{
    UIImage *image = nil;

    if (fPressed)
    {
        image = _pressedIcon;
    }
    else
    {
        image = _icon;
    }

    if (image)
    {
        imageView.image = image;
        imageView.fj_size = image.size;

        [self layoutSubviews];
    }
}

- (void)setText:(NSString *)text
{
    _text = text;

    label.text = text;

    [self layoutSubviews];
}

- (void)setFont:(UIFont *)font
{
    _font = font;

    label.font = _font;

    [self layoutSubviews];
}

- (void)setColor:(UIColor *)color
{
    _color = color;

    label.textColor = _color;
    [self layoutSubviews];
}

- (void)setMidMargin:(NSInteger)midMargin
{
    _midMargin = midMargin;

    [self layoutSubviews];
}

- (CGSize)titleSize
{
    if (_text.length == 0)
    {
        return CGSizeZero;
    }

    return [_text caculateSizeWithFont:_font];
}

- (void)sizeToFit
{
    CGFloat width = [self buttonWidth];
    self.fj_width = width;
}

- (CGFloat)buttonWidth
{
    CGSize size = [self titleSize];

    if (size.width == 0)
    {
        return (2 * _leftMargin + _icon.size.width);
    }

    return (2 * _leftMargin + size.width + _midMargin + _icon.size.width);
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];

    if (selected)
    {
        if (_selectedColor == nil)
        {
            label.textColor = [UIColor whiteColor];
        }
        else
        {
            label.textColor = _selectedColor;
        }

        imageView.image = _pressedIcon;
        imageView.fj_size = _pressedIcon.size;

        [self setBackgroundImage:_pressImage forState:UIControlStateNormal];
    }
    else
    {
        if (_color == nil)
        {
            label.textColor = [UIColor redColor];
        }
        else
        {
            label.textColor = _color;
        }

        imageView.image = _icon;
        imageView.fj_size = _icon.size;

        [self setBackgroundImage:_normalImage forState:UIControlStateNormal];
    }

    [self layoutSubviews];
}

@end
