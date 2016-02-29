//
//  DBManger.m
//  健客
//
//  Created by qianfeng on 15/10/22.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DBManger.h"
#import "FMDatabase.h"
#import "ProductDetailModel.h"

@interface DBManger ()
{
    FMDatabase *_fmdb;//数据库对象
    NSLock *_lock;

}
@end
static DBManger *_db; //static 一个我创建的_db 类对象

@implementation DBManger

//创建单例模式  为这个类对象 _db  创建单例模式!!
+(instancetype)sharManger
{
    static dispatch_once_t danli;
    dispatch_once(&danli, ^{
        _db = [[DBManger alloc]init];
        
    });
    return _db;
}
//重写这个类的init方法
-(instancetype)init
{
    if (self = [super init]) {
        //创建数据库(路径)
        NSString *dbpath = [NSHomeDirectory() stringByAppendingString:@"/Documents/app.db"];
        
        //根据路径 取出数据库对象
        _fmdb = [FMDatabase databaseWithPath:dbpath];
        
        //打开数据库
        BOOL isOpen = [_fmdb open];
        
        if (isOpen) {
            //创建数据库表  里面就存放数据模型
            NSString *sql = @"create table if not exists app (productID varchar(100),productName varchar(100),ourPrice varchar(100),marketPrice varchar(100),head_img varchar(1024))";
            
            //执行sql语句
            BOOL isSuccess = [_fmdb executeUpdate:sql];
            if (isSuccess) {
                LFFLog(@"建表成功");
            }else
            {
                LFFLog(@"建表失败");
            }
        }else
        {
            LFFLog(@"打开数据库失败");
        }

    }return self;
}



//插入数据
-(BOOL)insertDataWithProductDetailModel:(ProductDetailModel*)model
{
    //防止在多线程中同时访问数据库. 所以加锁
    [_lock lock];
    
    //1
    NSString *sql = @"insert into app values(?,?,?,?,?)";
    
    //执行sql语句
    BOOL isSuccess = [_fmdb executeUpdate:sql,model.productCode,model.productName,model.ourPrice,model.marketPrice,model.head_img];
    
    //
    LFFLog(isSuccess?@"插入成功":@"插入失败");
    
    //4
    [_lock unlock];
    
    return isSuccess;
}

//删除数据
-(BOOL)deleteDataWithProductCode:(NSString*)productCode
{
    [_lock lock];
    NSString *sql = @"delete from app where productID = ?";
    BOOL isSuccess = [_fmdb executeUpdate:sql,productCode];
    
    LFFLog(isSuccess?@"删除成功":@"删除失败");
    [_lock unlock];
    return isSuccess;
    
    
}
//根据appid查找单条数据
-(BOOL)selectOneDatawithproductCode:(NSString *)productCode
{
    NSString *sql = @"select *from app where productID = ?";
    FMResultSet *set = [_fmdb executeQuery:sql,productCode];
    return [set next];
}

//查询所有数据
-(NSArray*)selectAlldata
{
    NSString *sql = @"select *from app";
    FMResultSet *set = [_fmdb executeQuery:sql];
    
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
    
    //遍历结果集(返回yes 停止遍历)
    while ([set next]) {
        ProductDetailModel *model = [[ProductDetailModel alloc] init];
        //将结果里的字段值 保存
        model.productCode = [set stringForColumn:@"productID"];
        model.productName = [set stringForColumn:@"productName"];
        model.ourPrice = [set stringForColumn:@"ourPrice"];
        model.marketPrice = [set stringForColumn:@"marketPrice"];
        
        model.head_img = [set stringForColumn:@"head_img"];
        
        [arr addObject:model];
        
    }return arr;
    
}

@end
