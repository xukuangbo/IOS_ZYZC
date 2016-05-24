//
//  FHFDBManager.m
//  FashionHomeFurnitures
//
//  Created by qianfeng on 15/12/4.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "ZYZCDataBase.h"



static ZYZCDataBase *_db;

@implementation ZYZCDataBase
{
    FMDatabase *_fmdb;
}


+(instancetype )sharedDBManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        if (!_db) {
            _db=[[ZYZCDataBase alloc]init];
        }
    });
    
    return _db;
}

-(instancetype)init
{
    //初始化数据时，需要给数据库一个沙盒路径进行永久保存，存储在Documents目录下
    if (self=[super init]) {
        NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *path=[docDir stringByAppendingPathComponent:@"siteData.db"];
        
        NSLog(@"%@",path);
        
        _fmdb=[FMDatabase databaseWithPath:path];
        
        BOOL isSuccess=[_fmdb open];
        if (isSuccess) {
            
            // 数据库语言，sqlite语句，创建一张数据库表名
            //@“create table if not exists” 表名（参数名 varchar(32)，参数名varchar(128),参数名 varchar(1024) ）,
            
            
            NSString *sql=@"create table if not exists SiteData(dataId integer,type integer,name string)";
            
            BOOL tableSucced=[_fmdb executeUpdate:sql];
            
            if (tableSucced) {
                NSLog(@"表格创建成功");
            }
            else{
                NSLog(@"表格创建失败");
            }
            
            NSLog(@"数据库创建成功");
        }
        else{
            NSLog(@"数据库创建失败%@", _fmdb.lastErrorMessage);
            
        }
    }
    return self;
}

#pragma mark----增

-(BOOL)insertDataWithId:(NSNumber *)dataId andType:(NSNumber *)type andName:(NSString *)name
{
    /*
     增insert into 表名(applicationId,name,iconurl) values(?,?,?)
     */
    BOOL exist=[self searchOneDataWithName:name];
    if (exist) {
        NSLog(@"数据已存在!");
        return NO;
    }
    NSString *sql=@"insert into SiteData(dataId,type,name) values(?,?,?)";
    
    //插入一条数据
    BOOL success=[_fmdb executeUpdate:sql,dataId,type,name];
    
    if (success) {
        NSLog(@"插入成功");
    }
    else{
        NSLog(@"插入失败%@",_fmdb.lastErrorMessage);
    }
    
    return success;
    
}

#pragma mark---查

-(BOOL )searchOneDataWithName:(NSString *)name
{
    /*查询某一个是否存在select from 表名 where Id = ?*/
    
    NSString *sql=@"select name from SiteData where  name=?";
    FMResultSet *set=[_fmdb executeQuery:sql,name];
    
    BOOL success=[set next];
    if (success) {
        NSLog(@"查找成功");
    }
    else{
        NSLog(@"没有找到%@",_fmdb.lastErrorMessage);
    }
    return success;
}

#pragma mark---查看所有

-(NSArray *)recieveDBData
{
    /* 查询所有的数据select * from 表名 */
    
    NSString *sql=@"select * from SiteData";
    
    FMResultSet *set=[_fmdb executeQuery:sql];
    
    NSMutableArray *array=[NSMutableArray array];
    
    while ([set next]) {
        
        NSDictionary *dic=[set resultDictionary];
        
        [array addObject:dic];
    }
    return array;
}
@end











