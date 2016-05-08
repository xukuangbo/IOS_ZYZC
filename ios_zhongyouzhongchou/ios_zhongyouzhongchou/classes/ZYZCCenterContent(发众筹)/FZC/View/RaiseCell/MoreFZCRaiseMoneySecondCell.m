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
    
    
   _contentEntryView = [[FZCContentEntryView alloc] initWithFrame:CGRectMake(kRaiseMoneySecondCellMargin, lianView.bottom, recordView.width - 2 * kRaiseMoneySecondCellMargin, recordView.height - lianView.bottom - kRaiseMoneySecondCellMargin)];
    _contentEntryView.contentBelong=RAISEMONEY_CONTENTBELONG;
    [recordView addSubview:_contentEntryView];

    [self initDataToContentEntryView:_contentEntryView];
}

#pragma mark --- 加载初始化数据
-(void)initDataToContentEntryView:(FZCContentEntryView *)contentEntryView
{
    MoreFZCDataManager *manager=[MoreFZCDataManager sharedMoreFZCDataManager];
    
    WordView *wordView=(WordView *)[contentEntryView viewWithTag:WordViewType];
    if (manager.raiseMoney_wordDes.length) {
        wordView.textView.text=manager.raiseMoney_wordDes;
        wordView.placeHolderLab.hidden=YES;
    }
    
    SoundView *soundView=(SoundView *)[contentEntryView viewWithTag:SoundViewType];
    if (manager.raiseMoney_voiceUrl.length) {
        soundView.soundFileName=manager.raiseMoney_voiceUrl;
        soundView.soundProgress=0;
    }
    
    MovieView *movieView=(MovieView *)[contentEntryView viewWithTag:MovieViewType];
    if (manager.raiseMoney_movieImg.length) {
        movieView.movieImg.image=[UIImage imageWithContentsOfFile:KMY_ZHONGCHOU_DOCUMENT_PATH(manager.raiseMoney_movieImg)];
        movieView.movieImgFileName=manager.raiseMoney_movieImg;
        movieView.movieFileName=manager.raiseMoney_movieUrl;
        movieView.turnImageView.hidden=NO;
    }
}
//-(void)setContentBelong:(NSString *)contentBelong
//{
//    MoreFZCDataManager *manager=[MoreFZCDataManager sharedMoreFZCDataManager];
//
//    if([self.contentBelong isEqualToString:RAISEMONEY_CONTENTBELONG])
//    {
//        if (manager.raiseMoney_wordDes.length) {
//            _textView.text=manager.raiseMoney_wordDes;
//            _placeHolderLab.hidden=YES;
//        }
//    }
//    //回报1文字描述
//    else if ([self.contentBelong isEqualToString:RETURN_01_CONTENTBELONG])
//    {
//        if (manager.return_wordDes.length) {
//            _textView.text=manager.return_wordDes;
//            _placeHolderLab.hidden=YES;
//        }
//    }
//    //回报2文字描述
//    else if ([self.contentBelong isEqualToString:RETURN_02_CONTENTBELONG])
//    {
//        if (manager.return_wordDes01.length) {
//            _textView.text=manager.return_wordDes01;
//            _placeHolderLab.hidden=YES;
//        }
//
//    }
//
//}


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
