//
//  ZYZCDefine.h
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/3/5.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#ifndef ZYZCDefine_h
#define ZYZCDefine_h

//屏幕宽
#define KSCREEN_W [UIScreen mainScreen].bounds.size.width
//屏幕高
#define KSCREEN_H [UIScreen mainScreen].bounds.size.height
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

#define KZYZC_CENTERCONTENT_BTN_TAG 20//tag取值范围20～25
#define KFZC_PERSON_BTN_TAG         30//tag取值范围30～33
#define KFZC_SAVE_TYPE              40//tag取值范围40～42
#define KFZC_MOREFZCTABLEVIEW_TYPE  50//tag取值范围50～53
#define KFZC_COURSE_TYPE            60//tag取值范围60～63
#define KFZC_CONTENTCOURSE_TYPE     70//tag取值范围70～72

//图片拉伸
#define KPULLIMG(IMGNAME,TOP,LEFT,BOTTOM,RIGHT) [[UIImage imageNamed:IMGNAME]resizableImageWithCapInsets:UIEdgeInsetsMake(TOP, LEFT, BOTTOM, RIGHT) resizingMode:UIImageResizingModeStretch]

#endif /* ZYZCDefine_h */
