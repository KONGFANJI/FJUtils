//
//  NSMutableArray+Safe.m
//  XY
//
//  Created by silan on 16/1/10.
//  Copyright © 2016年 XY. All rights reserved.
//

#import "NSMutableArray+Safe.h"

@implementation NSMutableArray (Safe)

- (id)safeObjectAtIndex:(NSInteger)index {
    if (index >= 0 && index < self.count) {
        return self[index];
    }
    
    return nil;
}

- (void)safeRemoveObjectAtIndex:(NSInteger)index {
    if (index >= 0 && index < self.count) {
        [self removeObjectAtIndex:index];
    }
}
@end
