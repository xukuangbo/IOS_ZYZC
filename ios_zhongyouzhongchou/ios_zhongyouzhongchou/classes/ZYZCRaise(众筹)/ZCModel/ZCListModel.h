//
//  ZCListModel.h
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/5/8.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"


typedef NS_ENUM(NSInteger, ProductType)
{
    ZCListProduct,          //众筹列表
    ZCDetailProduct,        //众筹详情
    MyPublishProduct,       //我的众筹
    MyJionProduct,          //我参加的众筹
    MyReturnProduct,        //我的回报
    MyDraftProduct,         //我的草稿
    MyGoingProduct,         //我的正在进行的
    MyChoosePartnerProduct, //我的选择一起游的
    MyFailProduct,          //我的失败的
    MyVerifyProduct,        //我的上传凭证的
    MyDrawCashProduct       //我的可提现的
};

#pragma mark --- 众筹
typedef NS_ENUM(NSInteger, DetailProductType)
{
    PersonDetailProduct,
    MineDetailProduct,
    DraftDetailProduct
};


//
////所有众筹列表／我的众筹列表／众筹详情中个人信息栏/我的草稿
//typedef NS_ENUM(NSInteger, ZC_TYPE)
//{
//    AllList,
//    Mylist,
//    DetailType,
//    MyDraft
//};
//
////我的众筹列表中区分我发布，我参与，我推荐
//typedef NS_ENUM(NSInteger, MY_ZC_TYPE)
//{
//    MyPublish=1,
//    MyJoin,
//    MyRecommend
//};
//
////我的众筹列表中项目出现的状态
//typedef NS_ENUM(NSInteger, ZCStateType) {
//    ZCStateTypeDraft,             //众筹草稿
//    ZCStateTypeGoing,             //众筹正在进行
//    ZCStateTypeChoosePartner,     //选择同游(众筹达到100%，并且众筹时间已截止)
//    ZCStateTypeTypeTraveling,     //上传游记(正在进行旅行中)
//    ZCStateTypeEndTravel,         //申请提现(旅游结束)
//    ZCStateTypeFail,              //众筹失败(众筹未达到100%，并且众筹时间已截止)
//};

@class ZCOneModel,ZCProductModel,ZCSpellbuyproductModel;

@interface ZCListModel : NSObject

@property (nonatomic, copy  ) NSString *code;
@property (nonatomic, strong) NSArray  *data;

@end


@interface ZCOneModel : NSObject

@property (nonatomic, strong) NSDictionary    *country;
@property (nonatomic, strong) ZCProductModel  *product;
@property (nonatomic, strong) ZCSpellbuyproductModel *spellbuyproduct;
@property (nonatomic, strong) UserModel       *user;

@property (nonatomic, assign) ProductType     productType;



@end

@interface ZCProductModel : NSObject

@property (nonatomic, strong) NSNumber *down;
@property (nonatomic, strong) NSNumber *productId;
@property (nonatomic, strong) NSNumber *status;
@property (nonatomic, copy  ) NSString *headImage;
@property (nonatomic, copy  ) NSString *productDest;
@property (nonatomic, copy  ) NSString *productEndTime;
@property (nonatomic, copy  ) NSString *productName;
@property (nonatomic, strong) NSNumber *productPrice;
@property (nonatomic, copy  ) NSString *productStartTime;
@property (nonatomic, copy  ) NSString *travelstartTime;
@property (nonatomic, copy  ) NSString *travelendTime;
@property (nonatomic, strong) NSNumber *up;
@property (nonatomic, strong) NSNumber *friendsCount;

@end


@interface ZCSpellbuyproductModel : NSObject

@property (nonatomic, strong) NSNumber *spellRealBuyCount;
@property (nonatomic, strong) NSNumber *buyable;
@property (nonatomic, strong) NSNumber *spellbuyProductId;
@property (nonatomic, strong) NSNumber *fkProductId;
@property (nonatomic, strong) NSNumber *lotteryable;
@property (nonatomic, strong) NSNumber *annable;
@property (nonatomic, strong) NSNumber *spellRealBuyPrice;
@property (nonatomic, strong) NSNumber *realzjeNew;
@end




