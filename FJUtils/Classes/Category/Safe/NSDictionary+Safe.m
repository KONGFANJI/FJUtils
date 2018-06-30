//
//  NSDictionary+Safe.m
//  XY
//
//  Created by liusilan on 16/1/6.
//  Copyright © 2016年 XY. All rights reserved.
//

#import "NSDictionary+Safe.h"

@implementation NSDictionary (Safe)

- (NSString *)stringForKey:(id)key
{
    return [self stringForKey:key default:nil];
}

- (NSString *)stringForKey:(id)key default:(NSString *)fall
{
    return [self objectForKey:key expectedClass:[NSString class] default:fall];
}

- (NSNumber *)numberForKey:(id)key
{
    return [self numberForKey:key default:nil];
}
- (NSNumber *)numberForKey:(id)key default:(NSNumber *)fall
{
    return [self objectForKey:key expectedClass:[NSNumber class] default:fall];
}

- (NSDictionary *)dictForKey:(id)key
{
    return [self dictForKey:key default:nil];
}

- (NSDictionary *)dictForKey:(id)key default:(NSDictionary *)fall
{
    return [self objectForKey:key expectedClass:[NSDictionary class] default:fall];
}

- (NSArray *)arrayForKey:(id)key
{
    return [self arrayForKey:key default:nil];
}

- (NSArray *)arrayForKey:(id)key default:(NSArray *)fall
{
    return [self objectForKey:key expectedClass:[NSArray class] default:fall];
}

- (NSData *)dataForKey:(id)key
{
    return [self dataForKey:key default:nil];
}

- (NSData *)dataForKey:(id)key default:(NSData *)fall
{
    return [self objectForKey:key expectedClass:[NSData class] default:fall];
}

- (id)objectForKey:(id)key expectedClass:(Class)class
{
    return [self objectForKey:key expectedClass:class default:nil];
}

- (id)objectForKey:(id)key expectedClass:(Class)class default:(id)fall
{
    id obj = [self objectForKey:key];
    if (class && [obj isKindOfClass:class]) {
        return obj;
    }
    return fall;
}

@end
