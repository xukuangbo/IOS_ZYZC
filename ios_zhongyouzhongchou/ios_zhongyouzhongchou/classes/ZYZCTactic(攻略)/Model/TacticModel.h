//
//  TacticModel.h
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/4/20.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TacticModel : NSObject
//id 7
@property (nonatomic, copy) NSString *id;
//"mgViewsName": "双龙寺,日本,越南",
@property (nonatomic, copy) NSString *mgViewsName;
//"pics": [
//         "http://img.tvmao.com/stills/drama/73/422/b/Kn8qW78lLRF.jpg",
//         "http://img.tvmao.com/stills/drama/73/422/b/Kn8qW78lLBA.jpg",
//         "http://img.tvmao.com/stills/drama/73/422/b/Kn8qW78lKnA.jpg",
//         "http://img.tvmao.com/stills/drama/73/422/b/Kn8qW78lK7A.jpg",
//         "http://img.tvmao.com/stills/drama/73/422/b/Kn8qW78lKRA.jpg"
//         ],
@property (nonatomic, strong) NSArray *pics;

//"status": 1,
@property (nonatomic, assign) NSInteger status;
//"videosName": "双龙寺,日本,越南,双龙寺",
@property (nonatomic, copy) NSString *videosName;
//"videos": [
@property (nonatomic, strong) NSArray *videos;

/**
 *  热门目的地模型
 */
@property (nonatomic, strong) NSArray *mgViews;

@end
