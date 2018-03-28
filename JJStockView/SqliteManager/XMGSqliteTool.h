//
//  XMGSqliteTool.h
//  sqlite封装
//
//  Created by 小码哥 on 2017/1/15.
//  Copyright © 2017年 xmg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMGSqliteTool : NSObject
// 用户机制
// uid : nil  common.db
// uid: zhangsan  zhangsan.db

+ (BOOL)deal:(NSString *)sql uid:(NSString *)uid;

// 返回值: 字典(一行记录)组成的数组
+ (NSMutableArray <NSMutableDictionary *>*)querySql:(NSString *)sql uid:(NSString *)uid;


+ (BOOL)dealSqls:(NSArray <NSString *>*)sqls uid:(NSString *)uid;

@end
