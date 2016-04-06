//
//  ReturnThirdCell.h
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/3/24.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#define ReturnThirdCellMargin 10
#define ReturnThirdCellHeight 555  
#import <UIKit/UIKit.h>
#import "ReturnCellBaseBGView.h"
#import "FZCContentEntryView.h"
@interface ReturnThirdCell : UITableViewCell<UITextFieldDelegate>
@property (nonatomic, weak) ReturnCellBaseBGView *bgImageView;
/**
 *  人数输入框
 */
@property (nonatomic, weak) UITextField *peopleTextfiled;
/**
 *  金钱输入框
 */
@property (nonatomic, weak) UITextField *moneyTextFiled;
@property (nonatomic, assign) BOOL open;

/**
 *  人数设置view
 */
@property (nonatomic, weak) UIView *peopleView;
/**
 *  语音输入view
 */
@property (nonatomic, weak) FZCContentEntryView *entryView;

- (void)reloadManagerData;
@end
