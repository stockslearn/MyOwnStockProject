//
//  ViewController.m
//  StockView
//
//  Created by Jezz on 2017/10/14.
//  Copyright © 2017年 Jezz. All rights reserved.
//

#import "DemoViewController.h"
#import "JJStockView.h"

#import "YYStockModel.h"
#import "YYSqliteManager.h"



#import "XMGSqliteModelTool.h"





@interface DemoViewController ()<StockViewDataSource,StockViewDelegate>

@property(nonatomic,readwrite,strong)JJStockView* stockView;


@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation DemoViewController

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

    [self demo:kActionTypeBottom | kActionTypeRight];//就是位移枚举的时候用到此方式。

    NSLog(@"++++++++++");

    [self demo:kActionTypeTop | kActionTypeLeft | kActionTypeRight];
}

// 位移枚举在传入参数时,是使用 或运算 的方式,
/*
 // 比如传进来的值是 10,也就是 1010 ;
 //1010;
 //0010;
 让 10 与上 2 得 2
 让 10 与上 8 得 8
 所以只要二进制位上有值, 就能获得对应的值
 ​
 */
//传多个参数 3个
//| (或运算符)   0|1 = 1 0|0 = 0 1|1 = 1  只要有1那么结果就是1
//& (与运算符)   0&1 = 0 0&0 = 0 1&1 = 1  只要有0那么结果就是0
-(void)demo:(kActionType)type
{
    NSLog(@"%zd",type);


    if (type & kActionTypeTop) {
        NSLog(@"向上---%zd",type & kActionTypeTop);
    }
//        1010;
//        0010;

    if (type & kActionTypeBottom) {
        NSLog(@"向下---%zd",type & kActionTypeBottom);
    }

    if (type & kActionTypeRight) {
        NSLog(@"向右---%zd",type & kActionTypeRight);
    }

    if (type & kActionTypeLeft) {
        NSLog(@"向左---%zd",type & kActionTypeLeft);
    }
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"股票表格";
//    self.stockView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
//    [self.view addSubview:self.stockView];
    
//    [XMGSqliteModelTool createTable:[YYStockModel class] uid:nil];
    
    [self readTxt];
}

#pragma mark - Stock DataSource

- (NSUInteger)countForStockView:(JJStockView*)stockView{
    return 30;
}

- (UIView*)titleCellForStockView:(JJStockView*)stockView atRowPath:(NSUInteger)row{
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    YYStockModel *model = self.dataArray[row];
//    label.text = [NSString stringWithFormat:@"标题:%ld",row];
    label.text =model.bond_nm;
    label.textColor = [UIColor grayColor];
    label.backgroundColor = [UIColor colorWithRed:223.0f/255.0 green:223.0f/255.0 blue:223.0f/255.0 alpha:1.0];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

- (UIView*)contentCellForStockView:(JJStockView*)stockView atRowPath:(NSUInteger)row{
    
    UIView* bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1000, 30)];
    bg.backgroundColor = row % 2 == 0 ?[UIColor whiteColor] :[UIColor colorWithRed:240.0f/255.0 green:240.0f/255.0 blue:240.0f/255.0 alpha:1.0];
    for (int i = 0; i < 10; i++) {
//        UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(i * 100, 0, 100, 30)];
//        [button setTitle:[NSString stringWithFormat:@"内容:%d",i] forState:UIControlStateNormal];
//        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
//        button.titleLabel.textAlignment = NSTextAlignmentCenter;
//        button.tag = i;
//        [bg addSubview:button];
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(i * 100, 0, 100, 30)];
        YYStockModel *model = self.dataArray[row];
        switch (i) {
            case 0:
                label.text = model.convert_price;
                break;
            case 1:
                label.text = model.stock_nm;
                break;
            case 2:
                label.text = model.convert_value;
                break;
                
            case 3:
                label.text = model.force_redeem_price;
                break;
                
            case 4:
                label.text = model.put_convert_price;
                break;
            case 5:
                label.text = model.ration_cd;
                break;
            case 6:
                label.text = model.redeem_price_ratio;
                break;
            case 7:
                label.text = model.year_left;
                break;
            case 8:
                label.text = model.ytm_rt;
                break;
            case 9:
                label.text = model.ytm_rt_tax;
                break;
            default:
                break;
        }
//        label.text = [NSString stringWithFormat:@"内容:%d",i];
        label.textAlignment = NSTextAlignmentCenter;
        [bg addSubview:label];
    }
    return bg;
}

#pragma mark - Stock Delegate

- (CGFloat)heightForCell:(JJStockView*)stockView atRowPath:(NSUInteger)row{
    return 30.0f;
}

- (UIView*)headRegularTitle:(JJStockView*)stockView{
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    label.text = @"标题";
    label.backgroundColor = [UIColor whiteColor];
    label.textColor = [UIColor grayColor];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

- (UIView*)headTitle:(JJStockView*)stockView{
    UIView* bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1000, 40)];
    bg.backgroundColor = [UIColor colorWithRed:223.0f/255.0 green:223.0f/255.0 blue:223.0f/255.0 alpha:1.0];
    NSArray *titleArray = @[@"成交额",@"回售触发价",@"债券回售价",@"转股价值",@"转股价",@"债券评级",@"剩余年限",@"到期税前收益",@"到期税后收益",@"到期税后收益",@"到期税后收益"];
    for (int i = 0; i < 10; i++) {
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(i * 100, 0, 100, 40)];
//        label.text = [NSString stringWithFormat:@"标题:%d",i];
        label.text = titleArray[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor grayColor];
        [bg addSubview:label];
    }
    return bg;
}

- (CGFloat)heightForHeadTitle:(JJStockView*)stockView{
    return 40.0f;
}

- (void)didSelect:(JJStockView*)stockView atRowPath:(NSUInteger)row{
    NSLog(@"DidSelect Row:%ld",row);
}

#pragma mark - Button Action

- (void)buttonAction:(UIButton*)sender{
    NSLog(@"Button Row:%ld",sender.tag);
}

#pragma mark - Get

- (JJStockView*)stockView{
    if(_stockView != nil){
        return _stockView;
    }
    _stockView = [JJStockView new];
    _stockView.dataSource = self;
    _stockView.delegate = self;
    return _stockView;
}

- (void)readTxt {
    NSError *error = nil;
    NSString *string = [[NSString alloc] initWithContentsOfFile:@"/Users/geduo/Desktop/0327.txt" encoding:NSUTF8StringEncoding error:&error];
    ///Users/geduo/Desktop/bad.txt
    //如果有报错，则把报错信息输出来
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
        
        [tempArray addObject:stockModel];
    }
    
    NSLog(@"tempArray --- %@",tempArray);
    
    self.dataArray = tempArray;
    
    //创建一个数据库     将数据存储在数据库中
//    YYSqliteManager *sqliteManager = [YYSqliteManager shareManager];
//    [sqliteManager insertModels:tempArray];
}


@end
