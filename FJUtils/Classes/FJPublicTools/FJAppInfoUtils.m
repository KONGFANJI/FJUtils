//
//  FJAppInfoUtils.m
//  FJPublicTools
//
//  Created by XY on 2017/3/15.
//  Copyright © 2017年 KFJ. All rights reserved.
//

#import "FJAppInfoUtils.h"
#import <sys/utsname.h>
#import <UIKit/UIKit.h>

@implementation FJAppInfoUtils


+ (NSString *)appVersion{
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    if (!version) {
        return @"";
    }
    
    return version;
}

+ (NSString *)buildVersion{
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    if (!version) {
        return @"";
    }
    
    return version;
}


+ (NSString *)appName{
    NSString *name = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
    if (!name) {
        return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
    }
    
    return name;
}

+(NSString *)systermVersion{
    return [[UIDevice currentDevice] systemVersion];
}

//设备名称
+(NSString *)machineName{
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([platform isEqualToString:@"iPhone1,1"]) {
        
        platform = @"iPhone 2G (A1203)";
        
    } else if ([platform isEqualToString:@"iPhone1,2"]) {
        
        platform = @"iPhone 3G (A1241/A1324)";
        
    } else if ([platform isEqualToString:@"iPhone2,1"]) {
        
        platform = @"iPhone 3GS (A1303/A1325)";
        
    } else if ([platform isEqualToString:@"iPhone3,1"]) {
        
        platform = @"iPhone 4 (A1332)";
        
    }else if ([platform isEqualToString:@"iPhone3,2"]){
        
        platform = @"iPhone 4 (A1332)";
        
    }else if ([platform isEqualToString:@"iPhone3,3"]){
        
        platform = @"iPhone 4 (A1349)";
        
    }
    else if ([platform isEqualToString:@"iPhone4,1"]) {
        
        platform = @"iPhone 4S (A1387/A1431)";
        
    } else if ([platform isEqualToString:@"iPhone5,1"]) {
        
        platform = @"iPhone 5 (A1428)";
        
    }else if ([platform isEqualToString:@"iPhone5,2"]){
        
        platform = @"iPhone 5 (A1429/A1442)";
        
    }
    else if ([platform isEqualToString:@"iPhone5,3"]) {
        
        platform = @"iPhone 5c (A1456/A1532)";
        
    }else if ([platform isEqualToString:@"iPhone5,4"]){
        
        platform = @"iPhone 5c (A1507/A1516/A1526/A1529)";
        
    }else if ([platform isEqualToString:@"iPhone6,1"]){
        
        platform = @"iPhone 5s (A1453/A1533)";
        
    }
    else if ([platform isEqualToString:@"iPhone6,2"]) {
        
        platform = @"iPhone 5s (A1457/A1518/A1528/A1530)";
        
    }else if ([platform isEqualToString:@"iPhone7,1"]){
        
        platform = @"iPhone 6 Plus (A1522/A1524)";
        
    }else if ([platform isEqualToString:@"iPhone7,2"]){
        
        platform = @"iPhone 6 (A1549/A1586)";
        
    }else if ([platform isEqualToString:@"iPhone8,1"]){
        
        platform = @"iPhone 6S";
        
    }else if ([platform isEqualToString:@"iPhone8,2"]){
        
        platform = @"iPhone 6S Plus";
        
    }else if ([platform isEqualToString:@"iPod4,1"]) {
        
        platform = @"iPod touch 4";
        
    }else if ([platform isEqualToString:@"iPod5,1"]) {
        
        platform = @"iPod touch 5";
        
    }else if ([platform isEqualToString:@"iPod3,1"]) {
        
        platform = @"iPod touch 3";
        
    }else if ([platform isEqualToString:@"iPod2,1"]) {
        
        platform = @"iPod touch 2";
        
    }else if ([platform isEqualToString:@"iPod1,1"]) {
        
        platform = @"iPod touch";
        
    } else if ([platform isEqualToString:@"iPad3,2"]||[platform isEqualToString:@"iPad3,1"]) {
        
        platform = @"iPad 3";
        
    } else if ([platform isEqualToString:@"iPad2,2"]||[platform isEqualToString:@"iPad2,1"]||[platform isEqualToString:@"iPad2,3"]||[platform isEqualToString:@"iPad2,4"]) {
        
        platform = @"iPad 2";
        
    }else if ([platform isEqualToString:@"iPad1,1"]) {
        
        platform = @"iPad 1";
        
    }else if ([platform isEqualToString:@"iPad2,5"]||[platform isEqualToString:@"iPad2,6"]||[platform isEqualToString:@"iPad2,7"]) {
        
        platform = @"ipad mini";
        
    } else if ([platform isEqualToString:@"iPad3,3"]||[platform isEqualToString:@"iPad3,4"]||[platform isEqualToString:@"iPad3,5"]||[platform isEqualToString:@"iPad3,6"]) {
        
        platform = @"ipad 3";
        
    }
    
    return platform;
}

+ (NSString *)bundleIdentifier{
    return [[NSBundle mainBundle] bundleIdentifier];
}

@end
