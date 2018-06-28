//
//  FileUtils.m
//  XY
//
//  Created by silan on 16/1/9.
//  Copyright © 2016年 XY. All rights reserved.
//

#import "FileUtils.h"

@implementation FileUtils

+ (NSString *)documentsDirectory
{
    static NSString *docsDir = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    });
    return docsDir;
}

+ (NSString *)cachesDirectory
{
    static NSString *cachesDir = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cachesDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    });
    return cachesDir;
}

+ (BOOL)createDirForPath:(NSString *)path
{
    NSRange range = [path rangeOfString:@"/" options:NSBackwardsSearch];
    NSString *dir = [path substringToIndex:range.location];
    return [[NSFileManager defaultManager] createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:nil];
}

+ (BOOL)createDirWithDirPath:(NSString *)dirPath
{
    return [[NSFileManager defaultManager] createDirectoryAtPath:dirPath
                                     withIntermediateDirectories:YES
                                                      attributes:nil
                                                           error:nil];
}

+ (BOOL)deleteFileWithFullPath:(NSString *)fullPath
{
    BOOL deleteSucc = NO;
    if ([[NSFileManager defaultManager] isDeletableFileAtPath:fullPath]) {
        deleteSucc = [[NSFileManager defaultManager] removeItemAtPath:fullPath error:NULL];
    }
    
    return deleteSucc;
}

+ (BOOL)moveFile:(NSString *)fromPath desPath:(NSString *)desPath
{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    NSError *error=nil;
    BOOL res = [fileManager moveItemAtPath:fromPath toPath:desPath error:&error];
    return res;
}

+ (BOOL)isFileExists:(NSString *)filePath
{
   	return [[NSFileManager defaultManager] fileExistsAtPath:filePath];
}

+ (id)readFileFromPath:(NSString *)path
{
    if(![self isFileExists:path])
    {
        return nil;
    }
    
    NSData *data=[NSData dataWithContentsOfFile:path];
    return data;
}

+ (BOOL)writeToFile:(id)obj path:(NSString *)path
{
    return [obj writeToFile:path atomically:YES];
}

/**UserDefault
 */
+ (BOOL)writeObject:(id)object toUserDefaultWithKey:(NSString*)key
{
    return [self writeObject:object toUserDefaultWithKey:key archive:NO];
}

+ (id)readObjectFromUserDefaultWithKey:(NSString*)key
{
    return [self readObjectFromUserDefaultWithKey:key archive:NO];
}

+ (BOOL)writeObject:(id)object toUserDefaultWithKey:(NSString*)key archive:(BOOL)archive
{
    if (object == nil || key == nil) return NO;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    if (archive) {
        NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:object];
        [defaults setObject:myEncodedObject forKey:key];
    } else {
        [defaults setObject:object forKey:key];
    }
    
    return [defaults synchronize];
}

+ (id)readObjectFromUserDefaultWithKey:(NSString*)key archive:(BOOL)archive
{
    if (!key || key.length == 0) {
        return nil;
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if (archive) {
        NSData *myEncodedObject = [defaults objectForKey:key];
        
        if (myEncodedObject == nil) {
            return nil;
        }
        
        @try {
            return [NSKeyedUnarchiver unarchiveObjectWithData: myEncodedObject];
        }
        @catch (NSException *e){
            return nil;
        }
    } else {
        return [defaults objectForKey:key];
    }
}

+ (BOOL)deleteObjectFromUserDefaultWithKey:(NSString*)key
{
    if (!key) {
        return NO;
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:key];
    return [defaults synchronize];
}

+ (BOOL)appendContent:(NSString *)content toFilePath:(NSString *)filePath
{
    if (![self isFileExists:filePath]) {
        return NO;
    }
    
    BOOL appendSucc = YES;
    
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:filePath];
    if (!fileHandle) {
        appendSucc = NO;
    } else {
        [fileHandle seekToEndOfFile];
        [fileHandle writeData:[content dataUsingEncoding:NSUTF8StringEncoding]];
        [fileHandle closeFile];
    }
    
    return appendSucc;
}


/**CachesPath archive
 */
+ (void)writeObject:(id)object toCachesPath:(NSString*)path
{
    if (object == nil || [path length] == 0)
        return;
    
    NSString *fullPath = [[self cachesDirectory] stringByAppendingPathComponent:path];
    [self writeObject:object toPath:fullPath];
}

+ (id)readArchiveObjectFromCachesPath:(NSString*)path
{
    if ([path length] == 0)
        return nil;
    
    NSString *fullPath = [[self cachesDirectory] stringByAppendingPathComponent:path];
    return [self readObjectFromPath:fullPath];
}

+ (BOOL)deleteFileFromCachesPath:(NSString *)path
{
    NSString *fullPath = [[self cachesDirectory] stringByAppendingPathComponent:path];
    return [self deleteFileWithFullPath:fullPath];
}

/**DocumentPath archive
 */
+ (void)writeObject:(id)object toDocumentPath:(NSString *)path
{
    if (object == nil || [path length] == 0)
        return;
    
    NSString *fullPath = [[self documentsDirectory] stringByAppendingPathComponent:path];
    [self writeObject:object toPath:fullPath];
    
}

+ (id)readObjectFromDocumentPath:(NSString *)path
{
    if ([path length] == 0)
        return nil;
    
    NSString *fullPath = [[self documentsDirectory] stringByAppendingPathComponent:path];
    return [self readObjectFromPath:fullPath];
}

+ (BOOL)deleteFileFromDocumentPath:(NSString *)path
{
    NSString *fullPath = [[self documentsDirectory] stringByAppendingPathComponent:path];
    return [self deleteFileWithFullPath:fullPath];
}

#pragma mark - private
static id getSemaphore(NSString *key)
{
    static NSMutableDictionary *dict = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dict = [[NSMutableDictionary alloc] initWithCapacity:10];
    });
    
    id obj = [dict objectForKey:key];
    if (!obj)
    {
        obj = [[NSObject alloc] init];
        [dict setObject:obj forKey:key];
    }
    return obj;
}

static dispatch_queue_t getFileQueue()
{
    static dispatch_queue_t queue = NULL;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = dispatch_queue_create("FileQueue", NULL);
    });
    return queue;
}


+ (void)writeObject:(id)obj toPath:(NSString *)fullPath
{
    if (obj == nil || [fullPath length] == 0)
        return;
    
    id newObj = obj;
    if ([obj isKindOfClass:[NSArray class]] || [obj isKindOfClass:[NSDictionary class]])
    {
        //集合类型为了避免出现写的同时另一个线程在操作同一个集合可能导致崩溃，这里在主线程生成一个新的集合
        if ([obj isKindOfClass:[NSMutableArray class]])
            newObj = [NSMutableArray arrayWithArray:obj];
        else if ([obj isKindOfClass:[NSArray class]])
            newObj = [NSArray arrayWithArray:obj];
        else if ([obj isKindOfClass:[NSMutableDictionary class]])
            newObj = [NSMutableDictionary dictionaryWithDictionary:obj];
        else
            newObj = [NSDictionary dictionaryWithDictionary:obj];
    }
    
    id sema = getSemaphore(fullPath);
    
    //在queue中操作
    dispatch_async(getFileQueue(), ^{
        @synchronized(sema)
        {
            //必须先创建目录，否则archiveRootObject操作在没有目录的情况下会失败！
            if ([self createDirForPath:fullPath])
            {
                [NSKeyedArchiver archiveRootObject:newObj toFile:fullPath];
            }
        }
    });
}

+ (id)readObjectFromPath:(NSString *)fullPath
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:fullPath])
    {
        return [NSKeyedUnarchiver unarchiveObjectWithFile:fullPath];
    }
    else {
        return nil;
    }
}

@end
