//
//  YYSqliteManager.h
//  JJStockView
//
//  Created by geduo on 2018/1/27.
//  Copyright © 2018年 Jezz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYStockModel.h"

@interface YYSqliteManager : NSObject

+(instancetype)shareManager;
-(void)insertModel:(YYStockModel *)model;

-(void)insertModels:(NSArray *)models;
@end
