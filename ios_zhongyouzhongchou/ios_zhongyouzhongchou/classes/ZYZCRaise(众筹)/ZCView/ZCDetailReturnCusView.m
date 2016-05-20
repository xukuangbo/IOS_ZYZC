//
//  ZCDetailReturnCusView.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/4/25.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#define HASSUPPORTPEOPLE(numberPeople) [NSString stringWithFormat:@"已支持:%d位",numberPeople]
#define SIGNUPPEOPLE(numberPeople) [NSString stringWithFormat:@"已报名:%d位",numberPeople]
#define LIMITSUPPORTPEOPLE(numberPeople) [NSString stringWithFormat:@"限额:%d位",numberPeople]

#import "ZCDetailReturnCusView.h"
#import "UIView+GetSuperTableView.h"
#import "ZYZCCusomMovieImage.h"
#import "ZCDetailIntroFirstCellVoiceShowView.h"
@interface ZCDetailReturnCusView ()
@property (nonatomic, copy  ) NSString *title;
@property (nonatomic, copy  ) NSString *text;
@property (nonatomic, assign) SupportMoneyType supportType;
@end

@implementation ZCDetailReturnCusView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initSupportViewByTop:(CGFloat   )top
                                andTitle:(NSString *)title
                                 andText:(NSString *)text
                          andSupportType:(SupportMoneyType )supportType
{
    self = [super init];
    if (self) {
        self.frame=CGRectMake(2*KEDGE_DISTANCE, top, KSCREEN_W-4*KEDGE_DISTANCE, 0);
        _title=title;
        _text=text;
        _supportType=supportType;
        [self confgUI];
    }
    return self;
}

-(void)confgUI
{
     //创建分割线
    UIView *lineView=[UIView lineViewWithFrame:CGRectMake(0, 0, self.width, 1) andColor:nil];
    [self addSubview:lineView];
    if (_supportType==SuppurtOneYuan) {
        lineView.hidden=YES;
    }
    //支持按钮
//    UIButton *supportBtn=[self createBtnByFrame:CGRectMake(self.width-40, lineView.bottom, 40, 40) andSupportType:_supportType];
//    [self addSubview:supportBtn];
    //标题
    CGFloat titleWidth=[ZYZCTool calculateStrLengthByText:_title andFont:[UIFont systemFontOfSize:15] andMaxWidth:self.width].width;
    _titleLab=[[UILabel alloc]initWithFrame:CGRectMake(0, lineView.bottom+KEDGE_DISTANCE, titleWidth, 20)];
    _titleLab.text=_title;
    _titleLab.font=[UIFont systemFontOfSize:15];
    _titleLab.textColor=[UIColor ZYZC_RedTextColor];
    [self addSubview:_titleLab];
    
    //如果是支持任意金额，添加金额输入框
    if (_supportType==SuppurtAnyYuan) {
        _moneyTextField=[[UITextField alloc]initWithFrame:CGRectMake(_titleLab.right, _titleLab.top-2, 80, _titleLab.height+4)];
        _moneyTextField.delegate=self;
        _moneyTextField.placeholder=@"¥";
        _moneyTextField.backgroundColor= [UIColor ZYZC_TabBarGrayColor];
        _moneyTextField.font=[UIFont systemFontOfSize:14];
        [self addSubview:_moneyTextField];
        UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(_moneyTextField.right, _titleLab.top, 20, _titleLab.height)];
        lab.text=@"元";
        lab.textColor=[UIColor ZYZC_TextBlackColor];
        lab.font=[UIFont systemFontOfSize:15];
        [self addSubview:lab];
        
    }
    //内容介绍
    CGFloat textWidth =self.width-30;
    CGFloat textHeight=[ZYZCTool calculateStrByLineSpace:10.0 andString:_text andFont:[UIFont systemFontOfSize:15] andMaxWidth:self.width-50].height;
    _textOpenHeight=textHeight;
    if (textHeight>75) {
        _textNormalHeight=75;
        textHeight=75;
        //添加更多按钮
        _moreTextBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _moreTextBtn.frame=CGRectMake(self.width-40, 90, 40, 30);
        [_moreTextBtn setImage:[UIImage imageNamed:@"btn_xxd"] forState:UIControlStateNormal];
        _moreTextBtn.tag=_supportType;
        _moreTextBtn.imageEdgeInsets=UIEdgeInsetsMake(0, 26, 0, 0);
        [_moreTextBtn addTarget:self action:@selector(openMoreText:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_moreTextBtn];
    }
    //添加内容标签
    _textLab=[[UILabel alloc]initWithFrame:CGRectMake(0, _titleLab.bottom+KEDGE_DISTANCE, textWidth, textHeight)];
    _textLab.font=[UIFont systemFontOfSize:15];
    _textLab.numberOfLines=3;
    _textLab.attributedText=[ZYZCTool setLineDistenceInText:_text];
    _textLab.textColor=[UIColor ZYZC_TextBlackColor];
    [self addSubview:_textLab];
    
    //如果是回报支持添加对应的文字，语音，视屏描述
    if (_supportType==SuppurtReturnMoney) {
        _WSMView=[[UIView alloc]initWithFrame:CGRectMake(0, _textLab.bottom+KEDGE_DISTANCE, self.width, 0)];
        [self addSubview:_WSMView];
    }
    //添加已支持多少位标签
    _hasSupportPeopleLab=[[UILabel alloc]initWithFrame:CGRectMake(0, _textLab.bottom+KEDGE_DISTANCE, 100, 20)];
    _hasSupportPeopleLab.font=[UIFont systemFontOfSize:13];
    _hasSupportPeopleLab.textColor=[UIColor ZYZC_TextBlackColor];
    _hasSupportPeopleLab.attributedText=[self customStringByString:HASSUPPORTPEOPLE(0)];
    [self addSubview:_hasSupportPeopleLab];
    
    //如果是回报支持、一起游 添加限额人数
    if (_supportType==SuppurtReturnMoney||_supportType==SuppurtTogetherMoney) {
        _limitPeopleLab=[[UILabel alloc]initWithFrame:CGRectMake(0, _hasSupportPeopleLab.top, 80, 20)];
        _limitPeopleLab.font=[UIFont systemFontOfSize:13];
        _limitPeopleLab.textColor=[UIColor ZYZC_TextBlackColor];
         _limitPeopleLab.attributedText=[self customStringByString:LIMITSUPPORTPEOPLE(0)];
        [self addSubview:_limitPeopleLab];
        [_limitPeopleLab addSubview:[UIView lineViewWithFrame:CGRectMake(_limitPeopleLab.right-1, 2.5, 1, 15) andColor:nil]];
        
        _hasSupportPeopleLab.left=_limitPeopleLab.right+30;
    }
    
    //添加承载支持人头像视图
    _peopleIconsView=[[UIView alloc]initWithFrame:CGRectMake(0, _hasSupportPeopleLab.bottom+KEDGE_DISTANCE, self.width, 1)];
    [self addSubview:_peopleIconsView];
    
    self.height=_peopleIconsView.bottom;
    
}

//#pragma mark --- 创建支持按钮
//-(UIButton *)createBtnByFrame:(CGRect )frame andSupportType:(SupportMoneyType )supportMoneyType
//{
//    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame=frame;
//    btn.tag=(NSInteger)supportMoneyType;
//    [btn setImage:[UIImage imageNamed:@"Butttn_support"] forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(supportMoney:) forControlEvents:UIControlEventTouchUpInside];
//    return  btn;
//}

#pragma mark --- 展开更多内容
-(void)openMoreText:(UIButton *)sender
{
    _isOpenText=!_isOpenText;
    if (_isOpenText) {
        _textLab.numberOfLines=0;
        _textLab.height=_textOpenHeight;
        _moreTextBtn.top=15+_textOpenHeight;
        [_moreTextBtn setImage:[UIImage imageNamed:@"btn_up"] forState:UIControlStateNormal];
        
        _hasSupportPeopleLab.top=_textLab.bottom+KEDGE_DISTANCE;
        _peopleIconsView.top=_hasSupportPeopleLab.bottom+KEDGE_DISTANCE;
        self.height=_peopleIconsView.bottom+KEDGE_DISTANCE;
    }
    else
    {
        _textLab.numberOfLines=3;
        _textLab.height=_textNormalHeight;
        _moreTextBtn.top=15+_textNormalHeight;
         [_moreTextBtn setImage:[UIImage imageNamed:@"btn_xxd"] forState:UIControlStateNormal];
        _hasSupportPeopleLab.top=_textLab.bottom+KEDGE_DISTANCE;
        _peopleIconsView.top=_hasSupportPeopleLab.bottom+KEDGE_DISTANCE;
        self.height=_peopleIconsView.bottom+KEDGE_DISTANCE;
    }

    [self.getSuperTableView reloadData];
}


//#pragma mark --- 支持金额
//-(void)supportMoney:(UIButton *)sender
//{
//    [sender setImage:[UIImage imageNamed:@"Butttn_support_pre"] forState:UIControlStateNormal];
//}

#pragma mark --- 限额人数
-(void)setLimitNumber:(NSInteger)limitNumber
{
    _limitNumber=limitNumber;
   _limitPeopleLab.attributedText=[self customStringByString:LIMITSUPPORTPEOPLE((int)limitNumber)];
}

#pragma mark --- 支持人数
-(void)setSupportNumber:(NSInteger)supportNumber
{
    _supportNumber=supportNumber;
    if(supportNumber)
    {
        NSInteger number=5;
        if (_supportType==SuppurtTogetherMoney) {
            _hasSupportPeopleLab.attributedText=[self customStringByString:SIGNUPPEOPLE((int)supportNumber)];
        }
        else{
            _hasSupportPeopleLab.attributedText=[self customStringByString:HASSUPPORTPEOPLE((int)supportNumber)];
        }
        _peopleIconsView.height=(self.width-50-number*5*KCOFFICIEMNT)/number;
        //移除图像
        NSArray *views=[_peopleIconsView subviews];
        for (NSInteger i=views.count-1; i>=0; i--) {
            [views[i] removeFromSuperview];
        }
        //添加头像
        for (NSInteger i=0; i<number; i++) {
            ZCDetailCustomButton *btn=[ZCDetailCustomButton buttonWithType:UIButtonTypeCustom];
            btn.frame=CGRectMake((_peopleIconsView.height+5*KCOFFICIEMNT)*i, 0, _peopleIconsView.height, _peopleIconsView.height);
            [btn setBackgroundImage:[UIImage imageNamed:@"jd_o"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(detailInfo:) forControlEvents:UIControlEventTouchUpInside];
            [_peopleIconsView addSubview:btn];
        }
        
        //添加更多按钮
        UIButton *moreBtn=[ZYZCTool getCustomBtnByTilte:@"更多" andImageName:@"btn_rig_mor" andtitleFont:[UIFont systemFontOfSize:15]];
        moreBtn.tag=_supportType;
        moreBtn.frame=CGRectMake(self.width-50, 0, 50, _peopleIconsView.height ) ;
        [moreBtn setTitleColor:[UIColor ZYZC_TextGrayColor04] forState:UIControlStateNormal];
        [moreBtn addTarget:self action:@selector(getMorePeople:) forControlEvents:UIControlEventTouchUpInside];
        [_peopleIconsView addSubview:moreBtn];

        self.height=_peopleIconsView.bottom;
    }
}

#pragma mark --- 是否有视屏
-(void)setHasMovie:(BOOL)hasMovie
{
    _hasMovie=hasMovie;
    static BOOL getMovie=NO;
    if (hasMovie) {
        if (!getMovie) {
            ZYZCCusomMovieImage *movieView=[[ZYZCCusomMovieImage alloc]initWithFrame:CGRectMake(0, 0, self.width, self.width*5/8)];
            [_WSMView addSubview:movieView];
            _WSMView.height=movieView.bottom+KEDGE_DISTANCE;
            [self changViewsFrame];
        }
    }
    getMovie=YES;
}

#pragma mark --- 是否有语音
-(void)setHasVoice:(BOOL)hasVoice
{
    _hasVoice=hasVoice;
    static BOOL getVoice=NO;
    if (!getVoice) {
        if (hasVoice) {
            ZCDetailIntroFirstCellVoiceShowView *voiceView=[[ZCDetailIntroFirstCellVoiceShowView alloc]initWithFrame:CGRectMake(0, _WSMView.height, self.width, 40)];
            voiceView.voiceTime=50;
            [_WSMView addSubview:voiceView];
            _WSMView.height=voiceView.bottom+KEDGE_DISTANCE;
            [self changViewsFrame];
        }
    }
    getVoice=YES;
}
#pragma mark --- 是否有文字
-(void)setHasWord:(BOOL)hasWord
{
    _hasWord=hasWord;
    static BOOL getWord=NO;
    if (!getWord) {
        if (hasWord) {
            NSString *str=@"煎饼果子来一套煎饼果子来一套煎饼果子来一套煎饼果子来一套煎饼果子来一套煎饼果子来一套";
            CGFloat wordHeight=[ZYZCTool calculateStrByLineSpace:10.0 andString:str andFont:[UIFont systemFontOfSize:15] andMaxWidth:self.width].height;
            UILabel *wordView=[[UILabel alloc]initWithFrame:CGRectMake(0, _WSMView.height, self.width, wordHeight)];
            wordView.font=[UIFont systemFontOfSize:15];
            wordView.numberOfLines=0;
            wordView.attributedText=[ZYZCTool setLineDistenceInText:str];
            wordView.textColor=[UIColor ZYZC_TextBlackColor];
            [_WSMView addSubview:wordView];
            _WSMView.height=wordView.bottom+KEDGE_DISTANCE;
            [self changViewsFrame];
        }
    }
    getWord=YES;
}

-(void)changViewsFrame
{
    _limitPeopleLab.top=_WSMView.bottom;
    _hasSupportPeopleLab.top=_limitPeopleLab.top;
    _peopleIconsView.top=_hasSupportPeopleLab.bottom+KEDGE_DISTANCE;
    self.height=_peopleIconsView.bottom;
}

#pragma mark --- 进入更多人数内容展示页
-(void)getMorePeople:(UIButton *)sender
{
    UIView *bgView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_W, KSCREEN_H)];
    bgView.backgroundColor=[UIColor blackColor];
    bgView.alpha=0.4;
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:bgView];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backFromTotalPeopleView:)];
    [bgView addGestureRecognizer:tap];
    
    //添加展示所有支持者视图
    _totalPeopleView=[[ZCTotalPeopleView alloc]initWithFrame:CGRectMake(0, KSCREEN_H, KSCREEN_W, 0) andSupportType:_supportType];
    
    __weak typeof (&*self)weakSelf=self;
    _totalPeopleView.backToView=^()
    {
        [weakSelf backFromTotalPeopleView:tap];
    };
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:_totalPeopleView];
    
    [UIView animateWithDuration:0.1 animations:^{
        weakSelf.totalPeopleView.top=KSCREEN_H-weakSelf.totalPeopleView.height;
    }];
    
}
#pragma mark --- 退出展示所有支持者视图
-(void)backFromTotalPeopleView:(UITapGestureRecognizer *)tap
{
    UIView *view=tap.view;
    [view removeFromSuperview];
    
    __weak typeof (&*self)weakSelf=self;
     [UIView animateWithDuration:0.1 animations:^{
         weakSelf.totalPeopleView.top=KSCREEN_H;
     } completion:^(BOOL finished) {
         [weakSelf.totalPeopleView removeFromSuperview];
     }];

}



#pragma mark --- 查看某人众筹详情
-(void)detailInfo:(ZCDetailCustomButton *)sender
{
    
}

#pragma mark --- textField代理方法
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return [self validateNumber:string];
}

- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField endEditing:YES];
    return YES;
}

#pragma mark --- 改变文字样式
-(NSAttributedString *)customStringByString:(NSString *)str
{
    NSMutableAttributedString *attrStr=[[NSMutableAttributedString alloc]initWithString:str];
    NSRange range1=[str rangeOfString:@":"];
    
    NSRange range2=[str rangeOfString:@"位"];
    
    if (str.length) {
        [attrStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:NSMakeRange(range1.location+1, range2.location-range1.location-1)];
        [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(range1.location+1, range2.location-range1.location-1)];
    }
    return  attrStr;
}

@end
