//
//  TacticVideoModel.h
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/4/20.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TacticVideoModel : NSObject
//"destDate": 1459735343000,
@property (nonatomic, copy) NSString *destDate;
//"foods": "5,2",
@property (nonatomic, copy) NSString *foods;
//"foodsName": "小笼包,酸辣粉",
@property (nonatomic, copy) NSString *foodsName;
//"glid": "1459735341303.jpg"
@property (nonatomic, copy) NSString *glid;
//"id": 12
@property (nonatomic, assign) NSInteger id;
//"mgViews": "10,7",
@property (nonatomic, copy) NSString *mgViews;
//"mgViewsName": "双龙寺,dds",
@property (nonatomic, copy) NSString *mgViewsName;
//"name": "越南",
@property (nonatomic, copy) NSString *name;
//"pics": "1459735341704.jpg,1459735342245.jpg,1459735342780.jpg",
@property (nonatomic, copy) NSString *pics;
/**
 *  图片
 */
@property (nonatomic, copy) NSString *viewImg;
//"status": 1,
//"tipsId": 1,
//"videoUrl": "http://www.baidu.com/",
//"viewImg": "1459735338339.jpg",
//"viewText": "这里是越南",
//"viewType": 1
@end
