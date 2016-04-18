//
//  GoalSecondCell.h
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/3/18.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "MoreFZCBaseTableViewCell.h"
#define SECONDCELLHEIGHT 65+125*KCOFFICIEMNT
@interface GoalSecondCell : MoreFZCBaseTableViewCell<UITextFieldDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) UIImagePickerController *imagePicker;
@property (nonatomic, strong) UIImageView *frameImg;
@property (nonatomic, strong) UITextField *textField;

@end
