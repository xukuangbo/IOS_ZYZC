//
//  FHFDBManager.h
//


//地名库
#import <Foundation/Foundation.h>

#import "ZYZCViewSpotModel.h"

#import "FMDatabase.h"
#import "FMResultSet.h"

typedef void (^DoFinish)(BOOL saveSuccess);

@interface ZYZCDataBase : NSObject

+(instancetype )sharedDBManager;
/**
 *  增
 */
-(BOOL)insertDataWithId:(NSNumber *)dataId andType:(NSNumber *)type andName:(NSString *)name andPinyin:(NSString *)pinyin;
/**
 *  查
 */
-(OneSpotModel *) searchOneDataWithName:(NSString *)name;

/**
 *  获取所有数据
 */
-(NSArray *)recieveDBData;

/**
 *  删除所有数据
 */
-(BOOL)deleteAllData;

/**
 *  存储数据到数据库
 */
-(void)saveDataWithFinishBlock:(DoFinish )doFinish;

/**
 *  拼音匹配
 */
-(NSArray*)queryWithPinyinCondition:(NSString *)condition;
/**
 *  文字匹配
 */
-(NSArray*)queryWithStrCondition:(NSString *)condition;

@end
