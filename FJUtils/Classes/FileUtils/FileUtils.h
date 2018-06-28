//
//  FileUtils.h
//  XY
//
//  Created by silan on 16/1/9.
//  Copyright © 2016年 XY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileUtils : NSObject

/**Some FilePaths
 */
+ (NSString *)documentsDirectory;
+ (NSString *)cachesDirectory;

/**
 *  File Operation
 */

/**
 *  创建文件所在的目录
 *
 *  @param path 文件的绝对路径
 *
 *  @return 是否创建成功
 */
+ (BOOL)createDirForPath:(NSString *)path;

/**
 *  创建目录
 *
 *  @param dirPath 目录绝对路径
 *
 *  @return 是否创建成功
 */
+ (BOOL)createDirWithDirPath:(NSString *)dirPath;

/**
 *  删除文件
 *
 *  @param path 文件所在的绝对路径
 *
 *  @return 是否删除成功
 */
+ (BOOL)deleteFileWithFullPath:(NSString *)path;

/**
 *  移动文件
 *
 *  @param fromPath 源路径
 *  @param desPath  目标路径
 *
 *  @return 是否移动成功
 */
+ (BOOL)moveFile:(NSString *)fromPath desPath:(NSString *)desPath;

+ (id)readFileFromPath:(NSString *)path;
+ (BOOL)writeToFile:(id)obj path:(NSString *)path;

/**
 *  指定路径的文件是否存在
 *
 *  @param filePath 文件的绝对路径
 *
 *  @return 是否存在
 */
+ (BOOL)isFileExists:(NSString *)filePath;

/**
 *  在文件的末尾追加文本内容
 *
 *  @param content  文本内容
 *  @param filePath 文件绝对路径，比如保证该文件是存在的，返回会返回NO
 *
 *  @return 是否追加成功
 */
+ (BOOL)appendContent:(NSString *)content toFilePath:(NSString *)filePath;


/**FileUtils In UserDefault
 */
// 默认不进行archive，需配对使用
+ (BOOL)writeObject:(id)object toUserDefaultWithKey:(NSString*)key;

// archive：object是否archive
+ (BOOL)writeObject:(id)object toUserDefaultWithKey:(NSString*)key archive:(BOOL)archive;

// 默认不进行archive
+ (id)readObjectFromUserDefaultWithKey:(NSString*)key;

// archive：object是否archive
+ (id)readObjectFromUserDefaultWithKey:(NSString*)key archive:(BOOL)archive;

+ (BOOL)deleteObjectFromUserDefaultWithKey:(NSString*)key;

/**FileUtils In CachesPath archive
 */
+ (void)writeObject:(id)object toCachesPath:(NSString*)path;
+ (id)readArchiveObjectFromCachesPath:(NSString*)path;
+ (BOOL)deleteFileFromCachesPath:(NSString *)path;

/**FileUtils In DocumentPath archive
 */
+ (void)writeObject:(id)object toDocumentPath:(NSString *)path;

// archive方式
+ (void)writeObject:(id)obj toPath:(NSString *)fullPath;
+ (id)readObjectFromPath:(NSString *)fullPath;

@end
