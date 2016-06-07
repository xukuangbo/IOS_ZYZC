//
//  MinePersonDatePickerView.h
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/5/30.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SurebBock)(NSDate *);


@interface MinePersonDatePickerView : UIView

@property (nonatomic, copy) SurebBock sureBlock;


@end
