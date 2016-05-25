//
//  MinePersonSetUpFirstCell.h
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/5/24.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SetUpFirstCellBottomMargin 5
#define SetUpFirstCellTopMargin 10
#define SetUpFirstCellLabelHeight 34
#define SetUpFirstCellBgHeight (SetUpFirstCellLabelHeight * 7 + KEDGE_DISTANCE * 2)
#define SetUpFirstCellRowHeight (SetUpFirstCellBgHeight + SetUpFirstCellTopMargin + SetUpFirstCellBottomMargin)
@interface MinePersonSetUpFirstCell : UITableViewCell
/**
 *  姓名标题
 */
@property (nonatomic, weak) UILabel *nameTitle;

/**
 *  姓名点击输入框
 */
@property (nonatomic, weak) UITextField *nameTextField;

/**
 *  生日点击选择框
 */
@property (nonatomic, weak) UIButton *birthButton;
/**
 *  省会点击选择框
 */
@property (nonatomic, weak) UIButton *proviceButton;
/**
 *  身高点击选择框
 */
@property (nonatomic, weak) UIButton *heightButton;
/**
 *  体重点击选择框
 */
@property (nonatomic, weak) UIButton *weightButton;
/**
 *  婚姻状况点击选择框
 */
@property (nonatomic, weak) UIButton *marryButton;
/**
 *  星座点击选择框
 */
@property (nonatomic, weak) UIButton *constellationButton;


@property (nonatomic, weak) UIImageView *bgImageView;
@end
