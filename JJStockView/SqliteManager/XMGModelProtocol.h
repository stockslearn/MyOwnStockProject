//
//  XMGModelProtocol.h
//  sqlite封装
//
//  Created by 小码哥 on 2017/1/15.
//  Copyright © 2017年 xmg. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol XMGModelProtocol <NSObject>

@required
+ (NSString *)primaryKey;

@optional
+ (NSArray *)ignoreColumnNames;

@end
