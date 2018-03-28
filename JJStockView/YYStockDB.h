//
//  YYStockDB.h
//  JJStockView
//
//  Created by pactera on 2018/1/26.
//  Copyright © 2018年 Jezz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYStockModel.h"

@interface YYStockDB : NSObject

- (void)createRecentAccountTable;
- (BOOL)saveRecentAccountModel:(YYStockModel *)info;
- (void)saveAllRecentAccountModel:(NSArray *)array;
- (NSArray<YYStockModel *> *)queryAllRecentAccountModel;
- (BOOL)updateRecentAccountModel:(YYStockModel *)info;
- (BOOL)deleteRecentAccountModelWithUserID:(NSString *)userID;
- (BOOL)deleteRecentAccountModelWithCommID:(NSString *)commID;
- (BOOL)deleteAllRecentAccountModel;


@end
