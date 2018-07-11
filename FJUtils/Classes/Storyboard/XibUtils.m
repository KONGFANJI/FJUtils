//
//  XibUtils.m
//  Qingtuo
//
//  Created by linghang on 16/9/21.
//  Copyright © 2016年 wangjian. All rights reserved.
//

#import "XibUtils.h"

@implementation XibUtils
+ (id)nibNameIdentifer:(NSString *)identifer andClass:(id)object{
    UINib * nib = [UINib nibWithNibName:identifer bundle:nil];
    id vc = [[nib instantiateWithOwner:nil options:nil] lastObject];
    return vc;
}
@end
