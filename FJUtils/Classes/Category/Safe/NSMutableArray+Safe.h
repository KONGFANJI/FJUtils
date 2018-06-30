//
//  NSMutableArray+Safe.h
//  XY
//
//  Created by silan on 16/1/10.
//  Copyright © 2016年 XY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Safe)

- (id)safeObjectAtIndex:(NSInteger)index;
- (void)safeRemoveObjectAtIndex:(NSInteger)index;

@end
