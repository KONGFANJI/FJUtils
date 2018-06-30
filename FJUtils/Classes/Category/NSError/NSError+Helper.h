//
//  NSError+Helper.h
//  XY
//
//  Created by silan on 16/1/9.
//  Copyright © 2016年 XY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError (Helper)

+ (NSError *)errorWithDesc:(NSString *)description code:(NSInteger)code;

@end
