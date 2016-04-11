//
//  MineHeadView.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/4/6.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "MineHeadView.h"
#import "MineUserModel.h"
#define mineCornerRadius 5
#define mineMargin 4
@interface MineHeadView ()


@end
@implementation MineHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.userInteractionEnabled = YES;
        //0头像遮盖
        UIView *shadowIconView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 76, 76)];
        shadowIconView.centerX = self.centerX;
        shadowIconView.top = 30;
        shadowIconView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        shadowIconView.layer.cornerRadius = mineCornerRadius;
        shadowIconView.layer.masksToBounds = YES;
        [self addSubview:shadowIconView];
        //1.头像
        UIButton *iconButton = [UIButton buttonWithType:UIButtonTypeCustom];
        iconButton.size = CGSizeMake(66, 66);
        iconButton.center = shadowIconView.center;
        [self addSubview:iconButton];
        self.iconButton = iconButton;
        [self.iconButton setBackgroundImage:[UIImage imageNamed:@"minicon.jpg"] forState:UIControlStateNormal];
        self.iconButton.layer.cornerRadius = mineCornerRadius;
        self.iconButton.layer.masksToBounds = YES;
        
        //2.名字
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.size = CGSizeMake(60, 20);
        nameLabel.centerX = iconButton.centerX;
        nameLabel.top = shadowIconView.bottom + mineMargin;
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.textColor = [UIColor whiteColor];
        nameLabel.font = [UIFont systemFontOfSize:18];
        nameLabel.text = @"李晓雅";
        //在赋值完名字后应该计算一下，调用一下方法吧
//        nameLabel.backgroundColor = [UIColor redColor];
        [self addSubview:nameLabel];
        
        //3.性别
        UIImageView *sexView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"btn_sex_fem"]];
        sexView.origin = CGPointMake(nameLabel.right, nameLabel.top);
        sexView.centerY = nameLabel.centerY;
        [self addSubview:sexView];
        self.sexView = sexView;
        
        //4.加V用户
        UIImageView *vipView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ico_renzheng"]];
        vipView.origin = CGPointMake(sexView.right, nameLabel.top);
        vipView.centerY = nameLabel.centerY;
        [self addSubview:vipView];
        self.vipView = vipView;
        
        //5.职业
        UILabel *professionLabel = [[UILabel alloc] init];
        professionLabel.text = @"摄影师";
        professionLabel.font = [UIFont systemFontOfSize:13];
        professionLabel.top = vipView.bottom + mineMargin;
        professionLabel.left = 0;
//        professionLabel.backgroundColor = [UIColor redColor];
        professionLabel.size = CGSizeMake(self.width, 15);
        professionLabel.textColor = [UIColor whiteColor];
        professionLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:professionLabel];
        self.professionLabel = professionLabel;
        
        //6.描述
        UILabel *descLabel = [[UILabel alloc] init];
        descLabel.text = @"24岁，白羊座，168cm，爱潜水，爱阅读，爱旅行";
        descLabel.font = [UIFont systemFontOfSize:13];
        descLabel.top = professionLabel.bottom + mineMargin;
        descLabel.left = 0;
        //        professionLabel.backgroundColor = [UIColor redColor];
        descLabel.size = CGSizeMake(self.width, 15);
        descLabel.textColor = [UIColor whiteColor];
        descLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:descLabel];
        self.descLabel = descLabel;
        
        //7.两个切换按钮的容器
        UIView *centerAndFootMapView = [[UIView alloc] init];
        centerAndFootMapView.left = 10;
        centerAndFootMapView.width = self.width - centerAndFootMapView.left * 2;
        centerAndFootMapView.top = descLabel.bottom + mineMargin;
        centerAndFootMapView.height = self.height - descLabel.bottom - mineMargin;
        centerAndFootMapView.layer.cornerRadius = 5;
        centerAndFootMapView.layer.masksToBounds = YES;
        
//        centerAndFootMapView.backgroundColor = [UIColor colorWithRed:161 / 255.0 green:152 / 255.0 blue:111 / 255.0 alpha:1.0];
        [self addSubview:centerAndFootMapView];

        //8.我的中心
        UIButton *myCenterButton = [UIButton buttonWithType:UIButtonTypeCustom];
        myCenterButton.size = CGSizeMake(centerAndFootMapView.width * 0.5, centerAndFootMapView.height);
        myCenterButton.origin = CGPointMake(0, 0);
        myCenterButton.tag = KMineHeadViewChangeType;
        [myCenterButton setTitle:@"我的中心" forState:UIControlStateNormal];
        [myCenterButton addTarget:self action:@selector(centerAndFootAction:) forControlEvents:UIControlEventTouchUpInside];
        [centerAndFootMapView addSubview:myCenterButton];
        self.myCenterButton = myCenterButton;
        myCenterButton.backgroundColor = [UIColor whiteColor];
        [myCenterButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        //9.我的足迹
        UIButton *myFootButton = [UIButton buttonWithType:UIButtonTypeCustom];
        myFootButton.size = CGSizeMake(centerAndFootMapView.width * 0.5, centerAndFootMapView.height);
        myFootButton.origin = CGPointMake(myCenterButton.right, 0);
        myFootButton.tag = KMineHeadViewChangeType + 1;
        [myFootButton addTarget:self action:@selector(centerAndFootAction:) forControlEvents:UIControlEventTouchUpInside];
        [myFootButton setTitle:@"我的足迹" forState:UIControlStateNormal];
        [centerAndFootMapView addSubview:myFootButton];
        self.myFootButton = myFootButton;
        myFootButton.backgroundColor = kMineChangeButtonNormalColor;
        [myFootButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return self;
}

- (void)centerAndFootAction:(UIButton *)button
{
    NSLog(@"button点击啦！！！！");
    //让两个tableView的隐藏相反一下
    self.headChangeBlock(button);
//    if (button.tag == KMineHeadViewChangeType) {
//        //是center
//    }else if(button.tag == KMineHeadViewChangeType + 1)
//    {
//        
//    }
}
/**
 *  model的赋值，数据的赋值
 */
- (void)setUserModel:(MineUserModel *)userModel
{
    if (_userModel != userModel) {
        _userModel = userModel;
        
        //icon头像
        SDWebImageOptions sdWebImageOptions = SDWebImageRetryFailed | SDWebImageLowPriority;
        [self.iconButton sd_setBackgroundImageWithURL:[NSURL URLWithString:userModel.faceImg] forState:UIControlStateNormal placeholderImage:nil options:sdWebImageOptions];
        
        
        
    }
}


@end
