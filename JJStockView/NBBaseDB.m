//
//  NBBaseDB.m
//  HNABim
//
//  Created by 张晓龙 on 16/9/21.
//  Copyright © 2016年 刘欢. All rights reserved.
//

#import "NBBaseDB.h"
//#import <CocoaSecurity/CocoaSecurity.h>
#import <CommonCrypto/CommonDigest.h>

#define wSelf(x) __weak typeof(self) x = self;

@implementation NBBaseDB

+ (instancetype)initDBManagerWithDocPath:(NSString *)userID
                                  teamID:(NSString *)teamID
{
    if (0 == userID.length
        || 0 == teamID.length)
    {
        return nil;
    }
    
    __block NSString *teamDBPath = nil;
    wSelf(weakSelf);
//    [NBBaseHelper initDocFilePathWithUserID:userID
//                                     teamID:teamID
//                                   response:^(NSString *userIDPath, NSString *teamIDPath)
//     {
         NSString *className = NSStringFromClass([weakSelf class]);
         if (0 != className.length)
         {
//             NSString *dbName = [CocoaSecurity md5:className].hex;
             if (0 != @"my".length)
             {
                 teamDBPath = [NSString stringWithFormat:@"%@/%@.db", @"stock",@"my"];
             }
         }
//     }];
    
    if (0 != teamDBPath.length)
    {
        //草 忘了使用的邮箱了
        NBBaseDB *db = [[self class] databaseWithPath:teamDBPath];
        
        if(![db open])
        {
          
            return nil;
        }
        
        return db;
    }
    
    return nil;
}





- (NSString*)tableName:(NSString*)tableId
{
    //username md5
    const char *cStr = [tableId UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    NSString* SessionMD5 =  [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],result[8], result[9], result[10], result[11],result[12], result[13], result[14], result[15]];

    NSString *className = NSStringFromClass([self class]);
//    NSString *preTable = [CocoaSecurity md5:className].hex;
    return [NSString stringWithFormat:@"%@_%@", nil, SessionMD5];
}

- (BOOL)addColumn:(NSString *)name type:(NSString *)type tableName:(NSString *)tableName
{
    if (0 == name.length
        || 0 == type.length
        || 0 == tableName.length)
    {
        return NO;
    }

    if (NO == [self columnExists:name inTableWithName:tableName])
    {
        NSString *add = [NSString stringWithFormat:@"ALTER TABLE %@ ADD %@ %@", tableName, name, type];
        return [self executeUpdate:add];
    }

    return YES;
}

@end
