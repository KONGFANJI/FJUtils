//
//  Alert.h
//  Alert
//
//  Created by James Z.J. He on 12-8-24.
//  Copyright (c) 2012年 shenzhen Mobile Dream Network Technology co，LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
    AlertPositionTop,
    AlertPositionTopMiddle,
    AlertPositionMiddle,
    AlertPositionBottomMiddle,
    AlertPositionBottom
} AlertPosition;

typedef enum {
    AlertLifeTime1Sec = 1,
    AlertLifeTime2Sec = 2,
    AlertLifeTime3Sec = 3,
    AlertLifeTime5Sec = 5,
    AlertLifeTime10Sec = 10,
    AlertLifeTimeNone = NSNotFound
} AlertLifeTime;

typedef enum {
    AlertTouchAlertDismiss,
    AlertTouchAlertOrBackgroundDismiss
}AlertTouchDismissOption;

@interface AlertItem : NSObject {
    UIView *contentView_;
    AlertLifeTime lifeTime_;
    AlertPosition position_;
    BOOL autoDismiss_;
    AlertTouchDismissOption touchDismissOption_;
}

@property (nonatomic, retain) UIView *contentView;
@property (nonatomic, assign) AlertLifeTime lifeTime;
@property (nonatomic, assign) AlertPosition position;
@property (nonatomic, assign) BOOL autoDismiss;
@property (nonatomic, assign) AlertTouchDismissOption touchDismissOption;

- (id)initWithContenView:(UIView *)view withPosition:(AlertPosition)position andLifeTime:(AlertLifeTime)lifeTime;
+ (id)alertItemContenView:(UIView *)view withPosition:(AlertPosition)position andLifeTime:(AlertLifeTime)lifeTime;

@end

@interface Alert : NSObject

+ (void)showAlertView:(UIView *)view withPosition:(AlertPosition)position andLifeTime:(AlertLifeTime)lifeTime;
+ (void)showAlertMessage:(NSString *)message withPosition:(AlertPosition)position andLifeTime:(AlertLifeTime)lifeTime;
+ (void)showAlertView:(UIView *)view withPosition:(AlertPosition)position touchDismissOption:(AlertTouchDismissOption)option;
+ (void)showAlertMessage:(NSString *)message withPosition:(AlertPosition)position touchDismissOption:(AlertTouchDismissOption)option;
+ (void)showAlertView:(UIView *)view withPosition:(AlertPosition)position andLifeTime:(AlertLifeTime)lifeTime touchDismissOption:(AlertTouchDismissOption)option;
+ (void)showAlertMessage:(NSString *)message withPosition:(AlertPosition)position andLifeTime:(AlertLifeTime)lifeTime touchDismissOption:(AlertTouchDismissOption)option;

@end
