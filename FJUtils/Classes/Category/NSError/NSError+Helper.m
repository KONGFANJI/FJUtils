//
//  NSError+Helper.m
//  XY
//
//  Created by silan on 16/1/9.
//  Copyright © 2016年 XY. All rights reserved.
//

#import "NSError+Helper.h"

#define ErrorDomain         @"com.error.ios"

@implementation NSError (Helper)

+ (NSError *)errorWithDesc:(NSString *)description code:(NSInteger)code {
    
    NSMutableDictionary *detail = [NSMutableDictionary dictionary];
    [detail setValue:description forKey:NSLocalizedDescriptionKey];
    
    return [[NSError alloc] initWithDomain:ErrorDomain code:code
                                                     userInfo:detail];

}

@end
