//
//  XMGModelTool.m
//  sqlite封装
//
//  Created by 小码哥 on 2017/1/15.
//  Copyright © 2017年 xmg. All rights reserved.
//

#import "XMGModelTool.h"
#import "XMGModelProtocol.h"
#import <objc/runtime.h>

@implementation XMGModelTool

+ (NSString *)tableName:(Class)cls {
    return NSStringFromClass(cls);
}

+ (NSString *)tmpTableName:(Class)cls {
    return [NSStringFromClass(cls) stringByAppendingString:@"_tmp"];
}

// 有效的成员变量名称, 以及, 对应的类型
+ (NSDictionary *)classIvarNameTypeDic:(Class)cls {
    
    // 获取这个类, 里面, 所有的成员变量以及类型
    
    unsigned int outCount = 0;
    Ivar *varList = class_copyIvarList(cls, &outCount);//获取该类所有的成员变量
    
    NSMutableDictionary *nameTypeDic = [NSMutableDictionary dictionary];
    
    NSArray *ignoreNames = nil;
    if ([cls respondsToSelector:@selector(ignoreColumnNames)]) {
        ignoreNames = [cls ignoreColumnNames];
    }
    
    
    
    for (int i = 0; i < outCount; i++) {
        Ivar ivar = varList[i];
        
        // 1. 获取成员变量名称
        NSString *ivarName = [NSString stringWithUTF8String: ivar_getName(ivar)];
        if ([ivarName hasPrefix:@"_"]) {
            ivarName = [ivarName substringFromIndex:1];
        }
        
        
        if([ignoreNames containsObject:ivarName]) {
            continue;
        }
        
        // 2. 获取成员变量类型
        NSString *type = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
        
        type = [type stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"@\""]];
        
        
        [nameTypeDic setValue:type forKey:ivarName];
    }
    
    return nameTypeDic;
    
}

+ (NSDictionary *)classIvarNameSqliteTypeDic:(Class)cls {
    
    NSMutableDictionary *dic = [[self classIvarNameTypeDic:cls] mutableCopy];
    
    NSDictionary *typeDic = [self ocTypeToSqliteTypeDic];
    [dic enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *obj, BOOL * _Nonnull stop) {
        dic[key] = typeDic[obj];
    }];
    
    return dic;
    
}


+ (NSString *)columnNamesAndTypesStr:(Class)cls {
    
    NSDictionary *nameTypeDic = [self classIvarNameSqliteTypeDic:cls];
//    {
//        age = integer;
//        b = integer;
//        name = text;
//        score = real;
//        stuNum = integer;
//    }
    
//    age integer,b integer
    
    NSMutableArray *result = [NSMutableArray array];
    [nameTypeDic enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *obj, BOOL * _Nonnull stop) {

        [result addObject:[NSString stringWithFormat:@"%@ %@", key, obj]];
    }];
    
    
   return [result componentsJoinedByString:@","];
    
}

+ (NSArray *)allTableSortedIvarNames:(Class)cls {
    
    NSDictionary *dic = [self classIvarNameTypeDic:cls];
    NSArray *keys = dic.allKeys;
    keys = [keys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    return keys;
}


#pragma mark - 私有的方法
+ (NSDictionary *)ocTypeToSqliteTypeDic {
    return @{
             @"d": @"real", // double
             @"f": @"real", // float
             
             @"i": @"integer",  // int
             @"q": @"integer", // long
             @"Q": @"integer", // long long
             @"B": @"integer", // bool
             
             @"NSData": @"blob",
             @"NSDictionary": @"text",
             @"NSMutableDictionary": @"text",
             @"NSArray": @"text",
             @"NSMutableArray": @"text",
             
             @"NSString": @"text"
             };

}



@end
