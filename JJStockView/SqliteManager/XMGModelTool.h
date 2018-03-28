//
//  XMGModelTool.h
//  sqlite封装
//
//  Created by 小码哥 on 2017/1/15.
//  Copyright © 2017年 xmg. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface XMGModelTool : NSObject

+ (NSString *)tableName:(Class)cls;
+ (NSString *)tmpTableName:(Class)cls;

// 所有的成员变量, 以及成员变量对应的类型
+ (NSDictionary *)classIvarNameTypeDic:(Class)cls;

// 所有的成员变量, 以及成员变量映射到数据库里面对应的类型
+ (NSDictionary *)classIvarNameSqliteTypeDic:(Class)cls;


+ (NSString *)columnNamesAndTypesStr:(Class)cls;


+ (NSArray *)allTableSortedIvarNames:(Class)cls;

@end
