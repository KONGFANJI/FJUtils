//
//  Alert.m
//  Alert
//
//  Created by James Z.J. He on 12-8-24.
//  Copyright (c) 2012年 shenzhen Mobile Dream Network Technology co，LTD. All rights reserved.
//

#import "Alert.h"

#define SCREEN_SIZE                 [[UIScreen mainScreen] bounds].size
#define SCREEN_WIDTH                MIN(SCREEN_SIZE.width, SCREEN_SIZE.height)
#define SCREEN_HEIGHT               MAX(SCREEN_SIZE.width, SCREEN_SIZE.height)

#define STATUS_BAR_OFFSET           ([UIApplication sharedApplication].statusBarHidden ? 0 : 20)

#define MD_ALERT_ANIMATION_DURATION 0.4

#define TOP_OFFSET                  (1 / 6.0)
#define BOTTOM_OFFSET               (5 / 6.0)

#define TOAST_FONT_SIZE             (14.0f)
#define TOAST_CORNER_RADIUS         (6.0f)
#define ARGB_COLOR(R, G, B, A)      [UIColor colorWithRed:R green:G blue:B alpha:A]
#define TOAST_BACKGROUND_COLOR      ARGB_COLOR(0.0, 0.0, 0.0, 0.9)
#define TOAST_BORDER_COLOR          ARGB_COLOR(0.6, 0.6, 0.6, 1.6)
#define TOAST_BORDER_WIDTH          (2.0f)
#define TOAST_TEXT_COLOR            ARGB_COLOR(1.0, 1.0, 1.0, 1.0)
#define TOAST_MARGIN_PADDING        (12.0f)
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#define BORDER_MASK_LEFT    (0x01)
#define BORDER_MASK_TOP     (0x02)
#define BORDER_MASK_RIGHT   (0x04)
#define BORDER_MASK_BOTTOM  (0x08)

@interface ToastView : UIView {
    NSString *message_;
    char borderMask_;
}

@property (nonatomic, assign) char borderMask;
@property (nonatomic, copy) NSString *message;

- (id)initWithMessage:(NSString *)message;
+ (id)toastViewMessage:(NSString *)message;
+ (CGRect)textToastBounds:(NSString *)message;
@end

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

@implementation ToastView

@synthesize borderMask = borderMask_;
@synthesize message = message_;

- (id)initWithMessage:(NSString *)message {
    self = [super initWithFrame:CGRectZero];

    if (self) {
        message_ = [message copy];
        self.bounds = [[self class] textToastBounds:message_];
        self.backgroundColor = [UIColor clearColor];
        borderMask_ = BORDER_MASK_LEFT | BORDER_MASK_BOTTOM | BORDER_MASK_RIGHT;
    }

    return self;
}

- (void)setBorderMask:(char)borderMask {
    if (borderMask_ != borderMask) {
        borderMask_ = borderMask;
        [self setNeedsDisplay];
    }
}

+ (id)toastViewMessage:(NSString *)message {
    return [[ToastView alloc] initWithMessage:message];
}

+ (CGRect)textToastBounds:(NSString *)message {
    if (!message || [message isEqualToString:@""]) {
        return CGRectZero;
    }

    UIFont *textFont                = [UIFont systemFontOfSize:TOAST_FONT_SIZE];

    NSDictionary *attribute = @{NSFontAttributeName:textFont};

    CGSize oneCharacterSize = [@"#" sizeWithAttributes:attribute];

    CGRect rect = [message boundingRectWithSize:CGSizeMake(0.8 * (SCREEN_WIDTH), 3 * oneCharacterSize.height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil];

    CGSize messageSize = rect.size;

    CGRect toastBounds = CGRectMake(0,
                                    0,
                                    messageSize.width + 2 * TOAST_MARGIN_PADDING,
                                    messageSize.height + 2 * TOAST_MARGIN_PADDING);

    return toastBounds;
}

- (void)drawRect:(CGRect)rect {
    CGFloat lineWidth = 0.0f;
    CGFloat radius = 0.0f;

    CGFloat minX = CGRectGetMinX(rect);
    CGFloat minY = CGRectGetMinY(rect);
    CGFloat midX = CGRectGetMidX(rect);
    CGFloat midY = CGRectGetMidY(rect);
    CGFloat maxX = CGRectGetMaxX(rect);
    CGFloat maxY = CGRectGetMaxY(rect);

    if (self.borderMask) {
        lineWidth = TOAST_BORDER_WIDTH;
        radius = TOAST_CORNER_RADIUS;
    }

    // 无边框
    lineWidth = 0;

    CGFloat lWidth = self.borderMask & BORDER_MASK_LEFT ? lineWidth : 0;
    CGFloat bWidth = self.borderMask & BORDER_MASK_BOTTOM ? lineWidth : 0;
    CGFloat rWidth = self.borderMask & BORDER_MASK_RIGHT ? lineWidth : 0;
    CGFloat tWidth = self.borderMask & BORDER_MASK_TOP ? lineWidth : 0;
    CGFloat rtl = self.borderMask & BORDER_MASK_LEFT && self.borderMask & BORDER_MASK_TOP ? radius : 0;
    CGFloat rbl = self.borderMask & BORDER_MASK_LEFT && self.borderMask & BORDER_MASK_BOTTOM ? radius : 0;
    CGFloat rbr = self.borderMask & BORDER_MASK_BOTTOM && self.borderMask & BORDER_MASK_RIGHT ? radius : 0;
    CGFloat rtr = self.borderMask & BORDER_MASK_RIGHT && self.borderMask & BORDER_MASK_TOP ? radius : 0;

    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSaveGState(context);

    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:0 green:0 blue:0 alpha:0.75].CGColor);
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0.75 green:0.75 blue:0.75 alpha:0.6].CGColor);
    CGContextSetLineWidth(context, lineWidth);

    CGContextMoveToPoint(context, minX + lineWidth / 2.0, midY);
    CGContextAddLineToPoint(context, minX + lineWidth / 2.0, midY);
    CGContextAddArcToPoint(context, minX + lineWidth / 2.0, maxY - lineWidth / 2.0, midX, maxY - lineWidth / 2.0, rbl);
    CGContextAddArcToPoint(context, maxX - lineWidth / 2.0, maxY - lineWidth / 2.0, maxX - lineWidth / 2.0, minY, rbr);
    CGContextAddArcToPoint(context, maxX - lineWidth / 2.0, minY + lineWidth / 2.0, midX, minY + lineWidth / 2.0, rtr);
    CGContextAddArcToPoint(context, minX + lineWidth / 2.0, minY + lineWidth / 2.0, minX + lineWidth / 2.0, midY, rtl);
    CGContextClosePath(context);
    CGContextStrokePath(context);

    CGContextMoveToPoint(context, minX + lWidth, minY + tWidth);
    CGContextAddLineToPoint(context, minX + lWidth, midY);
    CGContextAddArcToPoint(context, minX + lWidth, maxY - bWidth, midX, maxY - bWidth, rbl);
    CGContextAddArcToPoint(context, maxX - rWidth, maxY - bWidth, maxX - rWidth, minY - tWidth, rbr);
    CGContextAddArcToPoint(context, maxX - rWidth, minY + tWidth, midX, minY + tWidth, rtr);
    CGContextAddArcToPoint(context, minX + lWidth, minY + tWidth, minX + lWidth, midY, rtl);
    CGContextFillPath(context);

    CGContextRestoreGState(context);

    CGContextSaveGState(context);
    UIFont *font = [UIFont systemFontOfSize:TOAST_FONT_SIZE];
    CGContextSetFillColorWithColor(context, TOAST_TEXT_COLOR.CGColor);

    NSDictionary *attribute = @{NSFontAttributeName:font};

    CGSize messageSize  = [message_ boundingRectWithSize:CGSizeMake(rect.size.width - 20, rect.size.height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;

    attribute = @{NSFontAttributeName:font, NSForegroundColorAttributeName:[UIColor whiteColor]};

    [message_ drawInRect:CGRectMake((rect.size.width - messageSize.width) / 2.0, (rect.size.height - messageSize.height) / 2.0, messageSize.width, messageSize.height) withAttributes:attribute];

    CGContextRestoreGState(context);
}

@end

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

@implementation AlertItem : NSObject

@synthesize contentView = contentView_;
@synthesize lifeTime = lifeTime_;
@synthesize position = position_;
@synthesize autoDismiss = autoDismiss_;
@synthesize touchDismissOption = touchDismissOption_;

- (id)initWithContenView:(UIView *)view withPosition:(AlertPosition)position andLifeTime:(AlertLifeTime)lifeTime {
    self = [super init];

    if (self) {
        contentView_ = view;
        position_ = position;
        lifeTime_ = lifeTime;
        autoDismiss_ = YES;
        touchDismissOption_ = AlertTouchAlertOrBackgroundDismiss;
    }

    return self;
}

+ (id)alertItemContenView:(UIView *)view withPosition:(AlertPosition)position andLifeTime:(AlertLifeTime)lifeTime {
    return [[AlertItem alloc] initWithContenView:view withPosition:position andLifeTime:lifeTime];
}

@end

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

@interface Alert ()
+ (void)showAlertItem:(AlertItem *)item;
+ (void)dismissAlertItem:(AlertItem *)item;
+ (UIWindow *)mainWindow;
+ (NSMutableArray *)alertItemQueue;
+ (void)showAlert;
+ (void)dismissAlert;
+ (AlertItem *)currentAlertItem;
+ (void)setCurrentAlertItem:(AlertItem *)item;
+ (void)dismissAlertTimer:(NSTimer *)timer;
+ (CGAffineTransform)rotationTransformForOrientation:(UIInterfaceOrientation)orientation;
+ (CGRect)frameAtOrientation:(UIInterfaceOrientation)orientation forAlertItem:(AlertItem *)item withShowStatus:(BOOL)show;
+ (void)registerOrientationObserver:(BOOL)registerObserver;
+ (void)handleOrientationNotification:(NSNotification *)anotification;
+ (void)adjustOrientation;
+ (void)handleOrientationTimer:(NSTimer *)timer;
+ (void)handleTapGestureEvent:(id)sender;
+ (UITapGestureRecognizer *)tapGestureRecognizer;
@end

static AlertItem *currentAlertItem = nil;
static UIInterfaceOrientation currentOrientation = -1;
static BOOL hasRegistedObserver = NO;
static NSTimer *dismissTimer = nil;

@implementation Alert

#pragma mark - public API

+ (void)showAlertView:(UIView *)view withPosition:(AlertPosition)position andLifeTime:(AlertLifeTime)lifeTime {
    [self showAlertView:view withPosition:position andLifeTime:lifeTime touchDismissOption:AlertTouchAlertOrBackgroundDismiss];
}

+ (void)showAlertMessage:(NSString *)message withPosition:(AlertPosition)position andLifeTime:(AlertLifeTime)lifeTime {
    [self showAlertMessage:message withPosition:position andLifeTime:lifeTime touchDismissOption:AlertTouchAlertOrBackgroundDismiss];
}

+ (void)showAlertView:(UIView *)view withPosition:(AlertPosition)position touchDismissOption:(AlertTouchDismissOption)option {
    [self showAlertView:view withPosition:position andLifeTime:AlertLifeTimeNone touchDismissOption:option];
}

+ (void)showAlertMessage:(NSString *)message withPosition:(AlertPosition)position touchDismissOption:(AlertTouchDismissOption)option {
    [self showAlertMessage:message withPosition:position andLifeTime:AlertLifeTimeNone touchDismissOption:option];
}

+ (void)showAlertView:(UIView *)view withPosition:(AlertPosition)position andLifeTime:(AlertLifeTime)lifeTime touchDismissOption:(AlertTouchDismissOption)option {
    if (!view) { return; }

    void (^layzyBlock)(void) = ^{
        AlertItem *item = [AlertItem alertItemContenView:view withPosition:position andLifeTime:lifeTime];
        if (lifeTime == AlertLifeTimeNone) { item.autoDismiss = NO; }
        item.touchDismissOption = option;
        [[self alertItemQueue] addObject:item];
        [self showAlert];
    };

    if ([[NSThread currentThread] isMainThread]) {
        layzyBlock();
    } else {
        dispatch_async(dispatch_get_main_queue(), layzyBlock);
    }
}

+ (void)showAlertMessage:(NSString *)message withPosition:(AlertPosition)position andLifeTime:(AlertLifeTime)lifeTime touchDismissOption:(AlertTouchDismissOption)option {
    if (!message || [message isEqualToString:@""]) { return; }

    void (^layzyBlock)(void) = ^{
        if ([[currentAlertItem contentView] isKindOfClass:[ToastView class]]) {
            if ([[(ToastView *)currentAlertItem.contentView message] isEqualToString:message]) {
                return;
            }
        }

        for (AlertItem *item in [self alertItemQueue]) {
            if ([item.contentView isKindOfClass:[ToastView class]]) {
                if ([[(ToastView *)item.contentView message] isEqualToString:message]) {
                    return;
                }
            }
        }

        ToastView *toastView = [ToastView toastViewMessage:message];

        if (position == AlertPositionTop) {
            toastView.borderMask = BORDER_MASK_LEFT | BORDER_MASK_BOTTOM | BORDER_MASK_RIGHT;
        } else if (position == AlertPositionBottom){
            toastView.borderMask = BORDER_MASK_LEFT | BORDER_MASK_TOP | BORDER_MASK_RIGHT;
        } else {
            toastView.borderMask = BORDER_MASK_TOP | BORDER_MASK_LEFT | BORDER_MASK_BOTTOM | BORDER_MASK_RIGHT;
        }

        AlertItem *item = [AlertItem alertItemContenView:toastView withPosition:position andLifeTime:lifeTime];
        if (lifeTime == AlertLifeTimeNone) { item.autoDismiss = NO; }
        item.touchDismissOption = option;
        [[self alertItemQueue] addObject:item];
        [self showAlert];
    };

    if ([[NSThread currentThread] isMainThread]) {
        layzyBlock();
    } else {
        dispatch_async(dispatch_get_main_queue(), layzyBlock);
    }
}

#pragma mark - private API

+ (void)showAlertItem:(AlertItem *)item {
    if (!item) { return; }

    [self mainWindow].hidden = NO;

    currentOrientation = [UIApplication sharedApplication].statusBarOrientation;

    CGRect frameBeg = [self frameAtOrientation:currentOrientation forAlertItem:item withShowStatus:NO];
    CGRect frameEnd = [self frameAtOrientation:currentOrientation forAlertItem:item withShowStatus:YES];

    item.contentView.transform = [self rotationTransformForOrientation:currentOrientation];

    [[self mainWindow] addSubview:item.contentView];

    if (item.touchDismissOption == AlertTouchAlertOrBackgroundDismiss) {
        [[self mainWindow] addGestureRecognizer:[self tapGestureRecognizer]];
    } else {
        [item.contentView addGestureRecognizer:[self tapGestureRecognizer]];
    }

    item.contentView.frame = frameBeg;

    if (item.position == AlertPositionTop || item.position == AlertPositionBottom) {
        ;
    } else {
        item.contentView.alpha = 0.0;
    }

    [UIView animateWithDuration:MD_ALERT_ANIMATION_DURATION
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         item.contentView.frame = frameEnd;

                         if (item.position == AlertPositionTop || item.position == AlertPositionBottom) {
                             ;
                         } else {
                             item.contentView.alpha = 1.0;
                         }
                     }
                     completion:^(BOOL finished){
                     }];
}

+ (void)dismissAlertItem:(AlertItem *)item {
    if (!item) { return; }

    if (item.touchDismissOption == AlertTouchAlertOrBackgroundDismiss) {
        [[self mainWindow] removeGestureRecognizer:[self tapGestureRecognizer]];
    } else {
        [item.contentView removeGestureRecognizer:[self tapGestureRecognizer]];
    }

    CGRect frameEnd = [self frameAtOrientation:currentOrientation forAlertItem:item withShowStatus:NO];

    [UIView animateWithDuration:MD_ALERT_ANIMATION_DURATION
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         item.contentView.frame = frameEnd;

                         if (item.position == AlertPositionTop || item.position == AlertPositionBottom) {
                             ;
                         } else {
                             item.contentView.alpha = 0.0;
                         }
                     }
                     completion:^(BOOL finished){
                         [self mainWindow].hidden = YES;
                         [[self currentAlertItem].contentView removeFromSuperview];
                         [self setCurrentAlertItem:nil];
                     }];
}

+ (UIWindow *)mainWindow {
    static UIWindow *mainWindow = nil;

    if (!mainWindow) {
        mainWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        mainWindow.backgroundColor = [UIColor clearColor];
        mainWindow.windowLevel = UIWindowLevelStatusBar - 1;
    }
    return mainWindow;
}

+ (NSMutableArray *)alertItemQueue {
    static NSMutableArray *itemQueue = nil;

    if (!itemQueue) {
        itemQueue = [[NSMutableArray alloc] initWithCapacity:1];
    }

    return itemQueue;
}

+ (void)showAlert {
    if ([[self alertItemQueue] count] && ![self currentAlertItem]) {
        AlertItem *item = [[self alertItemQueue] objectAtIndex:0];

        [self setCurrentAlertItem:item];
        [[self alertItemQueue] removeObject:item];
        [self showAlertItem:[self currentAlertItem]];

        if ([self currentAlertItem]) {
            if (dismissTimer) { [dismissTimer invalidate]; dismissTimer = nil; }

            if ([self currentAlertItem].autoDismiss) {
                dismissTimer = [NSTimer scheduledTimerWithTimeInterval:[self currentAlertItem].lifeTime + 2 * MD_ALERT_ANIMATION_DURATION
                                                                target:[Alert class]
                                                              selector:@selector(dismissAlertTimer:)
                                                              userInfo:nil
                                                               repeats:NO];
            }
        }

        if (!hasRegistedObserver) { [self registerOrientationObserver:YES]; }
    }
}

+ (void)dismissAlert {
    [self dismissAlertItem:[self currentAlertItem]];

    if ([[self alertItemQueue] count]) {
        NSMethodSignature *methodSignature = [[self class] methodSignatureForSelector:@selector(showAlert)];
        if (methodSignature) {
            NSInvocation *invo = [NSInvocation invocationWithMethodSignature:methodSignature];
            [invo retainArguments];
            [invo setTarget:[self class]];
            [invo setSelector:@selector(showAlert)];
            [invo performSelector:@selector(invoke) withObject:nil afterDelay:MD_ALERT_ANIMATION_DURATION + 0.2];
        }
    } else {
        if (hasRegistedObserver) { [self registerOrientationObserver:NO]; }
    }
}

+ (AlertItem *)currentAlertItem {
    return currentAlertItem;
}

+ (void)setCurrentAlertItem:(AlertItem *)item {
    if (currentAlertItem != item) {
        currentAlertItem = item;
    }
}

+ (void)dismissAlertTimer:(NSTimer *)timer {
    dismissTimer = nil;
    [self dismissAlert];
}

+ (CGAffineTransform)rotationTransformForOrientation:(UIInterfaceOrientation)orientation {
    CGFloat angle = 0;

    switch (orientation) {
        case UIInterfaceOrientationLandscapeLeft:
            angle   = -1 * M_PI_2;
            break;
        case UIInterfaceOrientationLandscapeRight:
            angle   = M_PI_2;
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            angle   = M_PI;
            break;
        case UIInterfaceOrientationPortrait:
        default:
            angle   = 0;
            break;
    }

    return CGAffineTransformMakeRotation(angle);
}

/*
 * UIInterfaceOrientationPortrait:
 * |---|
 * |   |
 * |_o_|
 *
 * UIInterfaceOrientationPortraitUpsideDown:
 * |-o-|
 * |   |
 * |___|
 *
 * UIInterfaceOrientationLandscapeLeft:
 * |-----|
 * o     |
 * |_____|
 *
 * UIInterfaceOrientationLandscapeRight:
 * |-----|
 * |     o
 * |_____|
 */

+ (CGRect)frameAtOrientation:(UIInterfaceOrientation)orientation forAlertItem:(AlertItem *)item withShowStatus:(BOOL)show {
    CGRect result = CGRectZero;

    if (!item) { return result; }

    CGFloat width = 0;
    CGFloat height = 0;
    CGFloat x = 0;
    CGFloat y = 0;
    CGRect frame = [item contentView].bounds;

    if (UIInterfaceOrientationIsPortrait(orientation)) {
        width   = frame.size.width;
        height  = frame.size.height;
    } else {
        width   = frame.size.height;
        height  = frame.size.width;
    }

    switch (orientation) {
        case UIInterfaceOrientationLandscapeLeft:
            //NSLog(@"UIInterfaceOrientationLandscapeLeft");
            if (item.position == AlertPositionTop) {
                if (show) {
                    x =  STATUS_BAR_OFFSET;
                    y = (SCREEN_HEIGHT - height) / 2.0;
                } else {
                    x = STATUS_BAR_OFFSET - width;
                    y = (SCREEN_HEIGHT - height) / 2.0;
                }
            } else if (item.position == AlertPositionMiddle){
                x  = (SCREEN_WIDTH - width) / 2.0;
                y  = (SCREEN_HEIGHT - height) / 2.0;
            } else if (item.position == AlertPositionBottom){
                if (show) {
                    x =  SCREEN_WIDTH - width;
                    y = (SCREEN_HEIGHT - height) / 2.0;
                } else {
                    x = SCREEN_WIDTH;
                    y = (SCREEN_HEIGHT - height) / 2.0;
                }
            } else if (item.position == AlertPositionTopMiddle){
                x  = SCREEN_WIDTH * TOP_OFFSET - width / 2.0;
                y  = (SCREEN_HEIGHT - height) / 2.0;
            } else if (item.position == AlertPositionBottomMiddle){
                x  = SCREEN_WIDTH * BOTTOM_OFFSET - width / 2.0;
                y  = (SCREEN_HEIGHT - height) / 2.0;
            }
            break;
        case UIInterfaceOrientationLandscapeRight:
            //NSLog(@"UIInterfaceOrientationLandscapeRight");
            if (item.position == AlertPositionTop) {
                if (show) {
                    x = SCREEN_WIDTH - STATUS_BAR_OFFSET - width;
                    y = (SCREEN_HEIGHT - height) / 2.0;
                } else {
                    x = SCREEN_WIDTH - STATUS_BAR_OFFSET + width;
                    y = (SCREEN_HEIGHT - height) / 2.0;
                }
            } else if (item.position == AlertPositionMiddle){
                x  = (SCREEN_WIDTH - width) / 2.0;
                y  = (SCREEN_HEIGHT - height) / 2.0;
            } else if (item.position == AlertPositionBottom){
                if (show) {
                    x = 0;
                    y = (SCREEN_HEIGHT - height) / 2.0;
                } else {
                    x = 0 - width;
                    y = (SCREEN_HEIGHT - height) / 2.0;
                }
            } else if (item.position == AlertPositionTopMiddle){
                x  = SCREEN_WIDTH * BOTTOM_OFFSET - width / 2.0;
                y  = (SCREEN_HEIGHT - height) / 2.0;
            } else if (item.position == AlertPositionBottomMiddle){
                x  = SCREEN_WIDTH * TOP_OFFSET - width / 2.0;
                y  = (SCREEN_HEIGHT - height) / 2.0;
            }
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            //NSLog(@"UIInterfaceOrientationPortraitUpsideDown");
            if (item.position == AlertPositionTop) {
                if (show) {
                    x = (SCREEN_WIDTH - width) / 2.0;
                    y = SCREEN_HEIGHT -  STATUS_BAR_OFFSET - height;
                } else {
                    x = (SCREEN_WIDTH - width) / 2.0;
                    y = SCREEN_HEIGHT - STATUS_BAR_OFFSET + height;
                }
            } else if (item.position == AlertPositionMiddle){
                x  = (SCREEN_WIDTH - width) / 2.0;
                y  = (SCREEN_HEIGHT - height) / 2.0;
            } else if (item.position == AlertPositionBottom){
                if (show) {
                    x = (SCREEN_WIDTH - width) / 2.0;
                    y = 0;
                } else {
                    x = (SCREEN_WIDTH - width) / 2.0;
                    y = 0 - height;
                }
            } else if (item.position == AlertPositionTopMiddle){
                x  = (SCREEN_WIDTH - width) / 2.0;
                y  = SCREEN_HEIGHT * BOTTOM_OFFSET - height / 2.0;
            } else if (item.position == AlertPositionBottomMiddle){
                x  = (SCREEN_WIDTH - width) / 2.0;
                y  = SCREEN_HEIGHT * TOP_OFFSET - height / 2.0;
            }
            break;
        case UIInterfaceOrientationPortrait:
        default:
            //NSLog(@"UIInterfaceOrientationPortrait");
            if (item.position == AlertPositionTop) {
                if (show) {
                    x = (SCREEN_WIDTH - width) / 2.0;
                    y = STATUS_BAR_OFFSET;
                } else {
                    x = (SCREEN_WIDTH - width) / 2.0;
                    y = STATUS_BAR_OFFSET - height;
                }
            } else if (item.position == AlertPositionMiddle){
                x  = (SCREEN_WIDTH - width) / 2.0;
                y  = (SCREEN_HEIGHT - height) / 2.0;
            } else if (item.position == AlertPositionBottom){
                if (show) {
                    x = (SCREEN_WIDTH - width) / 2.0;
                    y = SCREEN_HEIGHT - height;
                } else {
                    x = (SCREEN_WIDTH - width) / 2.0;
                    y = SCREEN_HEIGHT + height;
                }
            } else if (item.position == AlertPositionTopMiddle){
                x  = (SCREEN_WIDTH - width) / 2.0;
                y  = SCREEN_HEIGHT * TOP_OFFSET - height / 2.0;
            } else if (item.position == AlertPositionBottomMiddle){
                x  = (SCREEN_WIDTH - width) / 2.0;
                y  = SCREEN_HEIGHT * BOTTOM_OFFSET - height / 2.0;
            }
            break;
    }

    result = CGRectMake(floor(x), floor(y), width, height);

    return result;
}

+ (void)registerOrientationObserver:(BOOL)registerObserver {
    if (registerObserver) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handleOrientationNotification:)
                                                     name:UIDeviceOrientationDidChangeNotification
                                                   object:nil];

        hasRegistedObserver = YES;
    } else {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        hasRegistedObserver = NO;
    }
}

+ (void)handleOrientationNotification:(NSNotification *)anotification {
    [NSTimer scheduledTimerWithTimeInterval:0.3
                                     target:self
                                   selector:@selector(handleOrientationTimer:)
                                   userInfo:nil
                                    repeats:NO];
}

+ (void)adjustOrientation {
    CGRect frame = [self frameAtOrientation:[UIApplication sharedApplication].statusBarOrientation
                               forAlertItem:[self currentAlertItem]
                             withShowStatus:YES];
    CGAffineTransform transform = [self rotationTransformForOrientation:[UIApplication sharedApplication].statusBarOrientation];

    [self currentAlertItem].contentView.transform = transform;
    [self currentAlertItem].contentView.frame = frame;
}

+ (void)handleOrientationTimer:(NSTimer *)timer {
    if (currentOrientation == [UIApplication sharedApplication].statusBarOrientation) {
        return;
    }

    [self adjustOrientation];

    currentOrientation = [UIApplication sharedApplication].statusBarOrientation;
}

+ (void)handleTapGestureEvent:(id)sender {
    if (dismissTimer) { [dismissTimer invalidate]; dismissTimer = nil; }
    [self dismissAlert];
}

+ (UITapGestureRecognizer *)tapGestureRecognizer {
    static UITapGestureRecognizer *gestureRecognizer = nil;

    if (!gestureRecognizer) {
        gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:[Alert class]
                                                                    action:@selector(handleTapGestureEvent:)];
    }

    return gestureRecognizer;
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
