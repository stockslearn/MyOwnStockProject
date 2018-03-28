//
//  YYSqliteManager.m
//  JJStockView
//
//  Created by geduo on 2018/1/27.
//  Copyright © 2018年 Jezz. All rights reserved.
//

#import "YYSqliteManager.h"
#import <FMDB.h>


@interface YYSqliteManager()

@property (nonatomic,strong) FMDatabaseQueue *baseQueue;
@end

@implementation YYSqliteManager

-(FMDatabaseQueue *)baseQueue{
    if (!_baseQueue) {
                NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//        NSString *path = @"Users/geduo/Desktop/";
        path = [path stringByAppendingPathComponent:@"stock.db"];
        
        NSLog(@"path==%@",path);
        
        _baseQueue = [FMDatabaseQueue databaseQueueWithPath:path];
        NSLog(@"baseQueue---%@",_baseQueue);
    }
    
    return _baseQueue;
}

+(instancetype)shareManager{
    
    static YYSqliteManager *_instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_instance) {
            _instance = [[YYSqliteManager alloc] init];
        }
    });
    
    
    return _instance;
    
}




-(instancetype)init{
    if (self = [super init]) {
        [self createTables];
        
    };
    
    
    
    return self;
    
}


-(void)createTables{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"db.sql" ofType:nil];
    
    NSString *sql = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];//@"create table YYStockModel if not exits ";
    
    [self.baseQueue inDatabase:^(FMDatabase * _Nonnull db) {
        BOOL isSuccess = [db executeStatements:sql];
        if (isSuccess) {
            NSLog(@"创表成功");
        }else{
            NSLog(@"创表失败");
        }
    }];
}

-(void)insertModels:(NSArray *)modesl{
    
    for (YYStockModel *model in modesl) {
        [self insertModel:model];
    }
}


-(void)insertModel:(YYStockModel *)model{
    NSString *sql = @"insert into T_stock(bond_id,bond_nm,convert_price,convert_value,issue_dt,full_price,maturity_dt,put_convert_price,ration_cd,stock_id,stock_net_value,stock_nm,year_left,ytm_rt,ytm_rt_tax,volume) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
    
    [self.baseQueue inDatabase:^(FMDatabase * _Nonnull db) {
        NSError *error;
        [db executeUpdate:sql values:@[model.bond_id?:@"",model.bond_nm?:@"",model.convert_price?:@"",model.convert_value?:@"",model.issue_dt?:@"",model.full_price?:@"",model.maturity_dt?:@"",model.put_convert_price?:@"",model.ration_cd?:@"",model.stock_id?:@"",model.stock_net_value?:@"",model.stock_nm?:@"",model.year_left?:@"",model.ytm_rt?:@"",model.ytm_rt_tax?:@"",model.volume?:@""] error:NULL];
        
    }];
    
}


-(void)insertModelAllProperties:(YYStockModel *)model{
    NSString *sql = @"insert into T_stock(active_fl,adjust_tc,adq_rating,apply_cd,bond_id,bond_nm,btype,convert_amt_ratio,convert_cd,convert_dt,convert_price,convert_value,cpn_desc,curr_iss_amt,force_redeem,force_redeem_price,full_price,guarantor,increase_rt,issue_dt,last_time,left_put_year,list_dt,market,maturity_dt,next_put_dt,online_offline_ratio,orig_iss_amt,owned,pb,pre_bond_id,premium_rt,price,price_tips,put_convert_price,put_convert_price_ratio,put_count_days,put_dt,put_inc_cpn_fl,put_price,put_real_days,put_tc,put_total_days,qflag,rating_cd,ration,ration_cd,ration_rt) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
    
    [self.baseQueue inDatabase:^(FMDatabase * _Nonnull db) {
        NSError *error;
        [db executeUpdate:sql values:@[model.active_fl?:@"",model.adjust_tc?:@"",model.adq_rating?:@"",model.apply_cd?:@"",model.bond_id?:@"",model.bond_nm?:@"",model.btype?:@"",model.convert_amt_ratio,model.convert_cd?:@"",model.convert_dt?:@"",model.convert_price?:@"",model.convert_value?:@"",model.cpn_desc?:@"",model.curr_iss_amt?:@"",model.force_redeem?:@"",model.force_redeem_price?:@"",model.full_price?:@"",model.guarantor?:@"",model.increase_rt?:@"",model.issue_dt?:@"",model.last_time?:@"",model.left_put_year?:@"",model.list_dt?:@"",model.market?:@"",model.maturity_dt?:@"",model.next_put_dt?:@"",model.online_offline_ratio?:@"",model.orig_iss_amt?:@"",model.owned?:@"",model.pb?:@"",model.pre_bond_id?:@"",model.premium_rt?:@"",model.price?:@"",model.price_tips?:@"",model.put_convert_price?:@"",model.put_convert_price_ratio?:@"",model.put_count_days?:@"",model.put_dt?:@"",model.put_inc_cpn_fl?:@"",model.put_price?:@"",model.put_real_days?:@"",model.put_tc?:@"",model.put_total_days?:@"",model.qflag?:@"",model.rating_cd?:@"",model.ration?:@"",model.ration_cd?:@"",model.ration_rt?:@""] error:NULL];
        
    }];
    
}

@end
