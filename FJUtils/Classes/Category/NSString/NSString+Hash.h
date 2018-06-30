//
//  NSString+Hash.h
//  XY
//
//  Created by liusilan on 16/1/6.
//  Copyright © 2016年 XY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Hash)

- (NSString *)MD2;
- (NSString *)MD4;
- (NSString *)MD5;

- (NSString *)SHA1;
- (NSString *)SHA224;
- (NSString *)SHA256;
- (NSString *)SHA384;
- (NSString *)SHA512;

@end
