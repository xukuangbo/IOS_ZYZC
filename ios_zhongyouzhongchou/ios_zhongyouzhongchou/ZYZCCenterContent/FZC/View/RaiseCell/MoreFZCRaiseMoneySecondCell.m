//
//  MoreFZCRaiseMoneySecondCell.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/3/22.
//  Copyright © 2016年 liuliang. All rights reserved.
//
#define kRaiseMoneySecondCellMargin 10
#import "MoreFZCRaiseMoneySecondCell.h"
#import "RaiseMoneySecondCellView.h"
#import "FZCContentEntryView.h"
@implementation MoreFZCRaiseMoneySecondCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor= [UIColor ZYZC_BgGrayColor];        //这里创建一个可以录音的view
        UIImageView *bgImageView = [[UIImageView alloc ] initWithFrame:CGRectMake(kRaiseMoneySecondCellMargin, 0, KSCREEN_W - kRaiseMoneySecondCellMargin * 2, RAISECECONDHEIGHT)];
//        bgImageView.height = 250;
        [self.contentView addSubview:bgImageView];
        bgImageView.userInteractionEnabled = YES;
        bgImageView.image = KPULLIMG(@"tab_bg_boss0", 10, 0, 10, 0);
        //创建内容
        [self createContentView:bgImageView];
        
        
        
    }
    return self;
}

/**
 *  创建内容
 */
- (void)createContentView:(UIView *)recordView
{
    //1.描述内容
    UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(kRaiseMoneySecondCellMargin, 20, 100, 30)];
    descLabel.textColor = [UIColor ZYZC_TextGrayColor];
    [recordView addSubview:descLabel];
    descLabel.text = @"众筹目的描述";
    [descLabel sizeToFit];
    self.discLab=descLabel;
    //2.虚线内容
    UIView *lianView  = [UIView lineViewWithFrame:CGRectMake(descLabel.left, descLabel.bottom + kRaiseMoneySecondCellMargin, KSCREEN_W - 2 * descLabel.left, 1) andColor:[UIColor ZYZC_BgGrayColor]];
    [recordView addSubview:lianView];
    
    
    FZCContentEntryView *contentEntryView = [[FZCContentEntryView alloc] initWithFrame:CGRectMake(kRaiseMoneySecondCellMargin, lianView.bottom, recordView.width - 2 * kRaiseMoneySecondCellMargin, recordView.height - lianView.bottom - kRaiseMoneySecondCellMargin)];
    [recordView addSubview:contentEntryView];
    self.contentEntryView = contentEntryView;
}

/**
 *  返回被选中的view
 */
- (UIView *)selectdView:(UIButton *)button
{
    for (RaiseMoneySecondCellView *subView in self.changeView.subviews) {
        if (subView.flag == button.tag) {
            return subView;
        }
    }
    return nil;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
