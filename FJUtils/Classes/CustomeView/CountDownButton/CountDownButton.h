//
//  CountDownButton.h
//  TaiHealthy
//
//  Created by KFJ on 2017/11/2.
//  Copyright © 2017年 taiKang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ CurrentCountBlock) (NSInteger currentCount);

@interface CountDownButton : UIButton

@property (nonatomic,copy) NSString *originalText;
@property (nonatomic,assign) NSInteger countNum;
@property (nonatomic,assign) NSInteger currentCount;

@property (nonatomic, copy) CurrentCountBlock currentCountBlock;

- (void)startTimer;
@end
