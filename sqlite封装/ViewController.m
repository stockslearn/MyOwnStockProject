//
//  ViewController.m
//  sqlite封装
//
//  Created by 小码哥 on 2017/1/15.
//  Copyright © 2017年 xmg. All rights reserved.
//

#import "ViewController.h"
#import "YYStockModel.h"
#import "XMGSqliteModelTool.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [XMGSqliteModelTool createTable:[YYStockModel class] uid:@"MyStock"];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self readTxt];
}


- (void)readTxt {
    NSError *error = nil;
    NSString *string = [[NSString alloc] initWithContentsOfFile:@"/Users/pactera/Documents/MyOwnProject/0327.txt" encoding:NSUTF8StringEncoding error:&error];
    ///Users/geduo/Desktop/bad.txt
    //如果有报错，则把报错信息输出来/Users/pactera/Documents/MyOwnProject/0327.txt
    if (error != nil) {
        NSLog(@"%@",[error localizedDescription]);
    }
    
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        NSDictionary *modelDict = dict[@"cell"];
        YYStockModel *stockModel = [[YYStockModel alloc] init];
        [stockModel setValuesForKeysWithDictionary:modelDict];
        
        [XMGSqliteModelTool saveOrUpdateModel:stockModel uid:@"MyStock"];
//        [tempArray addObject:stockModel];
    }
    
    NSLog(@"tempArray --- %@",tempArray);
    
//    [XMGSqliteModelTool];
    
//    self.dataArray = tempArray;
    
    //创建一个数据库     将数据存储在数据库中
    //    YYSqliteManager *sqliteManager = [YYSqliteManager shareManager];
    //    [sqliteManager insertModels:tempArray];
}


@end
