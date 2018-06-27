//
//  FJFileCleanCache.m
//  Tumbler
//
//  Created by XY on 2017/2/20.
//  Copyright © 2017年 Kfj. All rights reserved.
//

#import "FJFileCleanCache.h"
#import <UIKit/UIKit.h>

#define FileManager [NSFileManager defaultManager]

@implementation FJFileCleanCache

+ (void)cleanCaches:(void (^)(BOOL))CompleteBlock exclude:(NSString *)folderName
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 获取cache文件目录
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        // 获取该路径下的所有文件, 删除的时候，可以直接删除文件夹，计算的时候不能直接计算文件夹的大小
        BOOL isSuccess = NO;
        NSArray *allSubPathArray = [FileManager subpathsAtPath:path];
        for (NSString *subPath in allSubPathArray) {
            NSString *subPathStrigng = [path stringByAppendingPathComponent:subPath];
            if (![subPath containsString:folderName]) {
                if ([FileManager removeItemAtPath:subPathStrigng error:nil]) {
                    //                NSLog(@"成功");
                    isSuccess = YES;
                } else {
                    
                    // Snapshots 本来就存在的文件夹删除不了,可以回去看一下没用SDWebImage之前的文件夹，caches文件夹里面本来就有Snapshots（快照）
                    //                NSLog(@"失败");
                    
                }
            }
           
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if ([[self getCachesSizeExclude:folderName] floatValue] == 0) {
                // 本来就没有缓存，那也算成功
                CompleteBlock(YES);
            }else{
                CompleteBlock(isSuccess);
            }
        });
        
    });
}

+ (NSString *)getCachesSizeExclude:(NSString *)folderName
{
    long long cachesSize = 0;
    //    __block double doubleCaches = 0;
    
    // 获取cache文件目录
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    // 获取该路径下的所有文件, 删除的时候，可以直接删除文件夹，计算的时候不能直接计算文件夹的大小, 所以用subpathsAtPath 方法。正好拿不到Snapshots。删除的时候也删除不了这里面的东西，所以刚好对上。   真机发现好像说的不对呢 ？？？？
    NSArray *allSubPathArray = [FileManager subpathsAtPath:path];
    for (NSString *subPath in allSubPathArray) {
        NSString *subPathString = [path stringByAppendingPathComponent:subPath];
        NSDictionary *subCachesDic = [FileManager attributesOfItemAtPath:subPathString error:nil];
 
        if (![subPath isEqualToString:@"Snapshots"]) {
            // 得出的结果是B 最后要转成K 再转成 M
            if (![subPath containsString:folderName]) {
                cachesSize += subCachesDic.fileSize;
            }
        }
    }
    
    //    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    //
    //        dispatch_async(dispatch_get_main_queue(), ^{
    //            // 转成M， 保留两位小数。注意计算的时候进制是以1000计算，而不是1024。这也是为什么有些手机说是16G的内存，但实际容量只有14G左右。
    //            doubleCaches = (double)cachesSize / pow(10, 6);
    //            // 传回去的是M，可以根据实际情况转换成K，或者G
    //
    //        });
    //
    //    });
    
    return [NSString stringWithFormat:@"%lld",cachesSize];
}

+ (NSString *)getCachesSizeFormat:(sizeFormat)sizeFormat exclude:(NSString *)folderName{
    
    CGFloat folderSize = [[self getCachesSizeExclude:folderName] floatValue];
    NSString *totleStr = nil;
    
    if (sizeFormat == BType) {
        totleStr = [NSString stringWithFormat:@"%.1fB",folderSize / 1.0f];
    }else if (sizeFormat == KType){
        totleStr = [NSString stringWithFormat:@"%.1fKB",folderSize / 1000.0f ];
    }else if (sizeFormat == MType){
        totleStr = [NSString stringWithFormat:@"%.1fM",folderSize / 1000.0f / 1000.0f];
    }else if (sizeFormat == GType){
        totleStr = [NSString stringWithFormat:@"%.1GM",folderSize / 1000.0f / 1000.0f / 1000.0f];
    }else{
        if (folderSize > 1000 * 1000 * 1000) {
            totleStr = [NSString stringWithFormat:@"%.1GM",folderSize / 1000.0f / 1000.0f / 1000.0f];
        }else if (folderSize > 1000 * 1000)
        {
            totleStr = [NSString stringWithFormat:@"%.1fM",folderSize / 1000.0f / 1000.0f];
            
        }else if (folderSize > 1000)
        {
            totleStr = [NSString stringWithFormat:@"%.1fKB",folderSize / 1000.0f ];
            
        }else
        {
            totleStr = [NSString stringWithFormat:@"%.1fB",folderSize / 1.0f];
        }
        
    }
    
    return totleStr;
}

+ (void)cleanCachesAtPath:(NSString *)path exclude:(NSString *)folderName completeBlock:(void (^)(BOOL))CompleteBlock
{
    if (![FileManager isExecutableFileAtPath:path]) {
        // 文件夹不存在
        //        [[[UIAlertView alloc] initWithTitle:@"文件路径不存在" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
        NSLog(@"文件夹不存在");
        CompleteBlock(NO);
        return;
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        BOOL isSuccess = NO;
        // 获取指定文件夹下面的所有文件
        NSArray *allSubPathArray = [FileManager subpathsAtPath:path];
        for (NSString *subPath in allSubPathArray) {
            NSString *subPathStrigng = [path stringByAppendingPathComponent:subPath];
            if (![subPath isEqualToString:folderName]) {
                if ([FileManager removeItemAtPath:subPathStrigng error:nil]) {
                    //                NSLog(@"成功");
                    isSuccess = YES;
                } else {
                    //                NSLog(@"失败");
                    
                }
            }
           
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([[self getCachesSizeExclude:folderName] floatValue] == 0) {
                // 本来就没有缓存，那也算成功
                CompleteBlock(YES);
            }else{
                CompleteBlock(isSuccess);
            }
        });
        
    });
}

+ (BOOL)remindCleanCache:(long long)lessThanSize
{
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    return [[fattributes objectForKey:NSFileSystemFreeSize] longLongValue] > lessThanSize ? NO : YES;
}



@end
