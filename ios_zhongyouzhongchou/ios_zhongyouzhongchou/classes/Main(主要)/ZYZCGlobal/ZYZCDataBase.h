//
//  FHFDBManager.h
//  FashionHomeFurnitures
//
//  Created by qianfeng on 15/12/4.
//  Copyright © 2015年 qianfeng. All rights reserved.
//


//地名库
#import <Foundation/Foundation.h>

#import "FMDatabase.h"
#import "FMResultSet.h"

@interface ZYZCDataBase : NSObject

+(instancetype )sharedDBManager;

-(BOOL)insertDataWithId:(NSNumber *)dataId andType:(NSNumber *)type andName:(NSString *)name;

-(NSArray *)recieveDBData;



@end
