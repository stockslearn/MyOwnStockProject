//
//  NBBaseDB.h
//  HNABim
//
//  Created by 张晓龙 on 16/9/21.
//  Copyright © 2016年 刘欢. All rights reserved.
//

#import <FMDB/FMDB.h>

@interface NBBaseDB : FMDatabase

/**
 *  根据用户ID创建特定的数据库管理对象
 *
 *  @param userID 用户ID
 *
 *  @return 数据库库管理实例
 */
+ (instancetype)initDBManager:(NSString *)userID
                       teamID:(NSString *)teamID;

+ (instancetype)initNewDoDBManager:(NSString *)userID
                            teamID:(NSString *)teamID;

+ (instancetype)initBimworkDBMananger:(NSString *)userID
                               teamID:(NSString *)teamID;

- (NSString*)tableName:(NSString*)tableId;

- (BOOL)addColumn:(NSString *)name type:(NSString *)type tableName:(NSString *)tableName;

@end
