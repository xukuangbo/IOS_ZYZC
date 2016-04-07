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
        
        //4.加V用户
        UIImageView *vipView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ico_renzheng"]];
        vipView.origin = CGPointMake(sexView.right, nameLabel.top);
        vipView.centerY = nameLabel.centerY;
        [self addSubview:vipView];
        
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
        
        
        UIView *centerAndFootMapView = [[UIView alloc] init];
        centerAndFootMapView.left = 10;
        centerAndFootMapView.width = self.width - centerAndFootMapView.left * 2;
        centerAndFootMapView.top = descLabel.bottom + mineMargin;
        centerAndFootMapView.height = 20;
        centerAndFootMapView.backgroundColor = [UIColor redColor];
        [self addSubview:centerAndFootMapView];
        
        
        
        
        
//        UIButton *myCenterButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        myCenterButton.size = CGSizeMake(100, 50);
//        myCenterButton.bottom = self.height - 40;
//        myCenterButton.backgroundColor = [UIColor blueColor];
//        myCenterButton.left = 40;
//        [myCenterButton setTitle:@"我的中心" forState:UIControlStateNormal];
//        [self addSubview:myCenterButton];
//        
//        UIButton *myFootButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        myFootButton.size = CGSizeMake(100, 50);
//        myFootButton.bottom = self.height - 40;
//        myFootButton.backgroundColor = [UIColor blueColor];
//        myFootButton.right = self.width - 40;
//        [myFootButton setTitle:@"我的足迹" forState:UIControlStateNormal];
//        [self addSubview:myFootButton];
       
        
    }
    return self;
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
