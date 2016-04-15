//
//  MoreFZCDataManager.h
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/3/22.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface MoreFZCDataManager : NSObject<NSCopying>
//第一界面
//目的地中涉及到参数
/**
 *  目的地数组
 */
@property (nonatomic, strong) NSArray *goalViewScenesArr;
/**
 *  出发日期
 */
@property (nonatomic, copy)   NSString *goalViewStartDate;
/**
 *  返回日期
 */
@property (nonatomic, copy)   NSString *goalViewBackDate;
/**
 *  旅游总时间
 */
@property (nonatomic, assign) NSInteger goalViewTotalDays;
/**
 *  一起游人数
 */
@property (nonatomic, assign) NSInteger numberPeople;
/**
 *  旅行主题名
 */
@property (nonatomic, copy  ) NSString  *travelTheme;
/**
 *  旅行主题图片路径
 */
@property (nonatomic, copy  ) NSString  *travelThemeImgUrl;

//第二界面
/**
 *  景点金额
 */
@property (nonatomic, copy  ) NSString *sightTextfiledText;
/**
 *  行程金额
 */
@property (nonatomic, copy  ) NSString *transportTextfiledText;
/**
 *  居住金额
 */
@property (nonatomic, copy  ) NSString *liveTextfiledText;
/**
 *  餐饮金额
 */
@property (nonatomic, copy  ) NSString *eatTextfiledText;

/**
 *  总金额数目
 */
@property (nonatomic, assign) CGFloat raiseMoneyCountText;
/**
 *  筹路费文字描述
 */
@property (nonatomic, copy  ) NSString *raiseMoney_wordDes;
/**
 *  筹路费图片描述
 */
@property (nonatomic, copy  ) NSArray  *raiseMoney_imgDes;
/**
 *  筹路费语音描述
 */
@property (nonatomic, copy  ) NSString *raiseMoney_voiceUrl;
/**
 *  筹路费视屏描述
 */
@property (nonatomic, copy  ) NSString *raiseMoney_movieUrl;

//第三界面属性
/**
 *  旅游行程安排
 */
@property (nonatomic, strong) NSMutableArray *travelDetailArr;


//第四界面属性
@property (nonatomic, assign) CGSize realSize;

/**
 *  return第三个cell是否选中
 */
@property (nonatomic, assign) BOOL returnThirdSelected;
/**
 *  return第三个cell的金钱
 */
@property (nonatomic, copy) NSString *returnThirdMoney;
/**
 *  return第三个cell的人数
 */
@property (nonatomic, copy) NSString *returnThirdPeople;
/**
 *  return第三个cell的是否展开
 */
@property (nonatomic, assign) BOOL returnThirdDownbuttonOpen;
/**
 *  return第四个cell的是否展开
 */
@property (nonatomic, assign) BOOL returnFourthDownbuttonOpen;
/**
 *  return第四个cell支持金额点击了第几个
 */
@property (nonatomic, assign) NSInteger returnCellSupportButton;

//这里应该定义一个长度的数组
@property (nonatomic, strong) NSArray *returnCellHeights;



+ (instancetype)sharedMoreFZCDataManager;
@end
