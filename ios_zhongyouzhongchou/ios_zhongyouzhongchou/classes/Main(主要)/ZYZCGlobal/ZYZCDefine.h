//
//  ZYZCDefine.h
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/3/5.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#ifndef ZYZCDefine_h
#define ZYZCDefine_h

//在documents中创建保存发众筹资源的文件
#define KMY_ZHONGCHOU_FILE  @"zcDraft"

#define KMY_ZC_FILE_PATH(fileName) [NSString stringWithFormat:@"%@/zcDraft/%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) objectAtIndex:0],fileName]

#define KHTTP_FILE_HEAD @"http://zyzc-bucket01.oss-cn-hangzhou.aliyuncs.com"

//屏幕宽
#define KSCREEN_W [UIScreen mainScreen].bounds.size.width
//屏幕高
#define KSCREEN_H [UIScreen mainScreen].bounds.size.height

// globalization
#define ZYLocalizedString(x)   NSLocalizedString(x, nil)

//比例系数
#define KCOFFICIEMNT  KSCREEN_W/320

//工具栏高度
#define KTABBAR_HEIGHT self.tabBarController.tabBar.frame.size.height
//导航栏高度
#define KNAV_HEIGHT self.navigationController.navigationBar.frame.size.height
//状态栏＋导航栏高度
#define KNAV_STATUS_HEIGHT 64
#pragma mark --- 颜色
//RGBA
#define KCOLOR_RGBA(R,G,B,A)	[UIColor colorWithRed:(CGFloat)R/255.0 green:(CGFloat)G/255.0 blue:(CGFloat)B/255.0 alpha:A]
//RGB
#define KCOLOR_RGB(R,G,B)	[UIColor colorWithRed:(CGFloat)R/255.0 green:(CGFloat)G/255.0 blue:(CGFloat)B/255.0 alpha:1.0]

//边距设定
#define KEDGE_DISTANCE 10
//设置圆角弧度
#define KCORNERRADIUS  5

//tag值使用
#define KZYZC_CENTERCONTENT_BTN_TAG 20//tag取值范围20～25
#define KFZC_PERSON_BTN_TAG         30//tag取值范围30～36
#define KFZC_SAVE_TYPE              40//tag取值范围40～42
#define KFZC_MOREFZCTABLEVIEW_TYPE  50//tag取值范围50～53
#define KFZC_COURSE_TYPE            60//tag取值范围60～63
#define KFZC_CONTENTCOURSE_TYPE     70//tag取值范围70～72
#define KFZC_MOVIERECORDSAVE_TAG    80
#define KZC_DETAIL_BOTTOM_TYPE      90//tag取值范围90～92
#define KMineHeadViewChangeType     100//tag取值范围100～101
#define KZCDETAIL_CONTENTTYPE       110//tag取值范围110～102
#define KFZC_INPUTCONTENT_TYPE      120//tag取值范围120～122
#define KFZC_INPUTCONTENTVIEW_TYPE  130//tag取值范围130～132
#define KSUPPORTMONEY_TYPE          140//tag取值范围140～142
#define KPERSON_PRODUCT_TYPE        150//tag取值范围150～152
#define KTOUCH_PERSON_TYPE          160//tag取值范围160～161

#define KWebImage(urlImage) [[NSString stringWithFormat:@"http://zhongyou-hz.oss-cn-hangzhou.aliyuncs.com/%@",[urlImage stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] //网络访问阿里云的图片

//NSUserDefaults-key使用
#define KMOREFZC_RETURN_SUPPORTTYPE  @"return_supportType"
#define KUSER_ID                     @"userId"    //用于保存用户id(这里是openid)
#define KAPP_VERSION                 @"version"       //存储app的版本号
#define KMY_LOCALTION                @"myLocation"    //记录当地城市
#define KMY_ZC_DRAFT_SAVE            @"myDraftSave"   //记录我的草稿的状态
                                                      //@“yes”为保
#define KVIEWSPOT_SAVE               @"viewSportSave" //记录地名库有没有存储下来
                                                      //@“yes”为保存
#define KFAIL_UPLOAD_OSS             @"failUpload"    //记录上传资源到oss时失败没
                                                      //有删除的文件
#define KCHAT_TOKEN                  @"chatToken"     //存储用户聊天信息

//图片拉伸
#define KPULLIMG(IMGNAME,TOP,LEFT,BOTTOM,RIGHT) [[UIImage imageNamed:IMGNAME]resizableImageWithCapInsets:UIEdgeInsetsMake(TOP, LEFT, BOTTOM, RIGHT) resizingMode:UIImageResizingModeStretch]


//登陆授权
#define kWechatAuthScope @"snsapi_message,snsapi_userinfo,snsapi_friend,snsapi_contact"
#define kWechatAuthOpenID  @"0c806938e2413ce73eef92cc3"
#define kWechatAuthState   @"xxx"

#define kAppOpenid @"wx4f5dad0f41bb5a7d"//微信的
#define kAppSercet @"cbb6bf01c64e64aa869d497f600b1270"
#define KORDER_PAY_NOTIFICATION @"orderPay"



#endif /* ZYZCDefine_h */
