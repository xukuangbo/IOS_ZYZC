//
//  UIView+TacticMapView.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/4/22.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "UIView+TacticMapView.h"

@implementation UIView (TacticMapView)
/**
 *  创建一个容器view
 */
+ (UIImageView *)viewWithIndex:(NSInteger)index frame:(CGRect)rect Title:(NSString *)title desc:(NSString *)desc
{
    CGFloat margin = 10;
    UIImageView *mapView = [[UIImageView alloc ] initWithFrame:rect];
    mapView.userInteractionEnabled = YES;
    mapView.image = KPULLIMG(@"tab_bg_boss0", 5, 0, 5, 0);
    //    mapView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255) / 255.0 green:arc4random_uniform(255) / 255.0 blue:arc4random_uniform(255) / 255.0 alpha:1.0];
    mapView.layer.shadowOffset = CGSizeMake(5.0f, 5.0f);
    mapView.layer.shadowColor = [UIColor redColor].CGColor;
    mapView.backgroundColor = [UIColor whiteColor];
    mapView.layer.cornerRadius = 5;
    mapView.layer.masksToBounds = YES;
    //创建绿线
    CGFloat lineHeight = 15;
    [mapView addSubview:[UIView lineViewWithFrame:CGRectMake(margin , margin, 2, lineHeight) andColor:[UIColor ZYZC_MainColor]]];
    //创建标题
    CGFloat titleLabelX = margin * 2;
    CGFloat titleLabelY = margin;
    CGFloat titleLabelW = 150;
    CGFloat titleLabelH = lineHeight;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH)];
    titleLabel.text = title;
    titleLabel.textColor = [UIColor colorWithRed:84/256.0 green:84/256.0 blue:84/256.0 alpha:1];
    titleLabel.font = titleFont;
    [mapView addSubview:titleLabel];
    
    //创建向右的箭头
    CGFloat rightButtonW = 60;
    CGFloat rightButtonH = 15;
    CGFloat rightButtonX = mapView.width - margin - rightButtonW;
    CGFloat rightButtonY = margin;
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(rightButtonX, rightButtonY, rightButtonW, rightButtonH);
    [rightButton setImage:[UIImage imageNamed:@"btn_rig_mor"] forState:UIControlStateNormal];
    [rightButton setTitle:@"更多" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor ZYZC_TextGrayColor] forState:UIControlStateNormal];
    rightButton.titleLabel.font = descFont;
    
    //得出文字的宽度,交换两个的位置
    CGSize rightButtonTitleSize = [ZYZCTool calculateStrLengthByText:@"更多" andFont:descFont andMaxWidth:MAXFLOAT];
    CGFloat labelWidth = rightButtonTitleSize.width + 2;
    rightButton.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth, 0, -labelWidth);
    CGFloat imageWith = rightButton.currentImage.size.width + 2;
    rightButton.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWith, 0, imageWith);
    
    [mapView addSubview:rightButton];
    //创建描述
    CGFloat descLabelX = margin * 2;
    CGFloat descLabelY = titleLabel.bottom + 4;
    CGFloat descLabelW = 250;
    CGFloat descLabelH = lineHeight;
    UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(descLabelX, descLabelY, descLabelW, descLabelH)];
    
    descLabel.text = desc;
    descLabel.font = descFont;
    descLabel.textColor = [UIColor ZYZC_TextGrayColor];
    [mapView addSubview:descLabel];
    
//    NSLog(@"$$$$$$$%f",descLabel.bottom);
    
    return mapView;
}
@end
