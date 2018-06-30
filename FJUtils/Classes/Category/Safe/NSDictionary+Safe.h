//
//  NSDictionary+Safe.h
//  XY
//
//  Created by liusilan on 16/1/6.
//  Copyright © 2016年 XY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Safe)

- (NSString *)stringForKey:(id)key;
- (NSString *)stringForKey:(id)key default:(NSString *)fall;

- (NSNumber *)numberForKey:(id)key;
- (NSNumber *)numberForKey:(id)key default:(NSNumber *)fall;

- (NSDictionary *)dictForKey:(id)key;
- (NSDictionary *)dictForKey:(id)key default:(NSDictionary *)fall;

- (NSArray *)arrayForKey:(id)key;
- (NSArray *)arrayForKey:(id)key default:(NSArray *)fall;

- (NSData *)dataForKey:(id)key;
- (NSData *)dataForKey:(id)key default:(NSData *)fall;

- (id)objectForKey:(id)key expectedClass:(Class)cls;
- (id)objectForKey:(id)key expectedClass:(Class)cls default:(id)fall;

@end
