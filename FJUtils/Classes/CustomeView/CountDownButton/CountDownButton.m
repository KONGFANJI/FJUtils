//
//  CountDownButton.m
//  TaiHealthy
//
//  Created by KFJ on 2017/11/2.
//  Copyright © 2017年 taiKang. All rights reserved.
//



#import "CountDownButton.h"

@interface CountDownButton ()

@property (nonatomic, strong) NSTimer * timer;

//记录开始的时间，app进入后台前台使用
@property (nonatomic, assign) NSInteger startSecond;

@end
@implementation CountDownButton

- (void)initSomething{
    [self setTitle:self.originalText forState:UIControlStateNormal];
    self.currentCount = self.countNum;
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initSomething];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initSomething];
    }
    return self;
}

- (void)setCountNum:(NSInteger)countNum{
    _countNum = countNum;
    self.currentCount = self.countNum;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appGoBackgroud) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appGoForegroud) name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (void)setOriginalText:(NSString *)originalText{
    _originalText = originalText;
    [self setTitle:self.originalText forState:UIControlStateNormal];
}

- (void)startTimer{
    self.enabled = NO;
    
    //记录点击开始的时间
    self.startSecond = [[NSDate date] timeIntervalSince1970];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(nextCount) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)endTimer{
    self.startSecond = 0;
    if (self.timer.isValid) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)nextCount{
    if (self.currentCount > 0) {
        if(self.currentCountBlock){
            self.currentCountBlock(self.currentCount);
        }else{
            [self setTitle:[NSString stringWithFormat:@"%lds 后重发",(long)self.currentCount] forState:UIControlStateNormal];
        }
        self.currentCount --;
    }else{
        [self endTimer];
        self.enabled = YES;
        [self setTitle:self.originalText forState:UIControlStateNormal];
        self.currentCount = self.countNum;
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
//    [self startTimer];
}

-(void)appGoBackgroud{
    
    
}
-(void)appGoForegroud{
    
    NSTimeInterval curSecond = [[NSDate date] timeIntervalSince1970];
    
    NSInteger deta = curSecond - self.startSecond;
    
    if(self.startSecond == 0){
        [self endTimer];
    }
    else if(deta >= self.countNum)
    {
        [self endTimer];
    }
    else
    {
        self.currentCount = self.countNum - deta;
        [self nextCount];
    }
}

- (void)dealloc
{
    [self endTimer];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
}

@end
