//
//  WordView.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/3/31.
//  Copyright © 2016年 liuliang. All rights reserved.
//
#define TEXT_PLACEHOLDER @"编写众筹描述"
#define IMGDESBTN_WIDTH 63

#import "WordView.h"
#import "UIView+GetSuperTableView.h"
#import "UIView+ViewController.h"
#import "WordEditViewController.h"

@implementation WordView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)configUI
{
    self.backgroundColor=[UIColor whiteColor];
    _textView=[[UITextView alloc]init];
    _textView.editable=NO;
    _textView.font=[UIFont systemFontOfSize:15];
    _textView.layer.cornerRadius=KCORNERRADIUS;
    _textView.layer.masksToBounds=YES;
    _textView.textColor=[UIColor ZYZC_TextBlackColor];
    _textView.backgroundColor=[UIColor ZYZC_BgGrayColor01];
    _textView.contentInset = UIEdgeInsetsMake(-8, 0, 8, 0);
    _textView.frame=CGRectMake(KEDGE_DISTANCE, KEDGE_DISTANCE, self.width-2*KEDGE_DISTANCE, self.height-2*KEDGE_DISTANCE);
    [self addSubview:_textView];

    _placeHolderLab=[[UILabel alloc]initWithFrame:CGRectMake(0, 8, self.width, 20)];
    _placeHolderLab.text=TEXT_PLACEHOLDER;
    _placeHolderLab.font=[UIFont systemFontOfSize:15];
    _placeHolderLab.textColor=[UIColor ZYZC_TextGrayColor02];
    [_textView addSubview:_placeHolderLab];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapHappen:)];
    [_textView addGestureRecognizer:tap];
    
}

#pragma mark --- 添加图片描述
-(void)addDesImg
{
    
}

#pragma mark --- tap点击事件
-(void)tapHappen:(UITapGestureRecognizer *)tap
{
    WordEditViewController *wordEditVC=[[WordEditViewController alloc]init];
    wordEditVC.myTitle=@"文字描述";
    wordEditVC.preText=_textView.text;
    __weak typeof (&*self)weakSelf=self;
    wordEditVC.textBlock=^(NSString *textStr)
    {
        if (textStr.length) {
            weakSelf.placeHolderLab.hidden=YES;
            
        }
        else
        {
            weakSelf.placeHolderLab.hidden=NO;
            textStr=nil;
        }
        weakSelf.textView.text=textStr;
        //文字描述存入单例中
        MoreFZCDataManager *manager=[MoreFZCDataManager sharedMoreFZCDataManager];
        //筹旅费文字描述
        if([weakSelf.contentBelong isEqualToString:RAISEMONEY_CONTENTBELONG])
        {
            manager.raiseMoney_wordDes=textStr;
        }
        //回报1文字描述
        else if ([weakSelf.contentBelong isEqualToString:RETURN_01_CONTENTBELONG])
        {
            manager.return_wordDes=textStr;
        }
        //回报2文字描述
        else if ([weakSelf.contentBelong isEqualToString:RETURN_02_CONTENTBELONG])
        {
            manager.return_wordDes01=textStr;
        }
        //行程文字描述
        for (int i=0; i<manager.travelDetailDays.count; i++) {
            if ([weakSelf.contentBelong isEqualToString:TRAVEL_CONTENTBELONG(i+1)]) {
                MoreFZCTravelOneDayDetailMdel *model=manager.travelDetailDays[i];
                model.wordDes=textStr;
                break;
            }
        }
        
    };

    [self.viewController presentViewController:wordEditVC animated:YES completion:nil];
}

@end













