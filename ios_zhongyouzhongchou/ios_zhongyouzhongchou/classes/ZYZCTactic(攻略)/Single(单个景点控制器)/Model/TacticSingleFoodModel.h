//
//  TacticSingleFoodModel.h
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/4/21.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TacticSingleFoodModel : NSObject
//"destDate": 1458657885000,

//"foodImg": "/productImg/show/indexImg/1458657885064.jpg",
@property (nonatomic, copy) NSString *foodImg;
//"foodText": "小笼包",
@property (nonatomic, copy) NSString *foodText;
//"id": 5,
@property (nonatomic, assign) NSInteger ID;
//"name": "小笼包",
@property (nonatomic, copy) NSString *name;
//"status": 1
@end
