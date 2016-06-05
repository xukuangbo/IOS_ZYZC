//
//  PersonHeadView.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/6/3.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#define FOLLIOW_AND_BEFOLLOW(follow,befollow)  [NSString stringWithFormat:@"关注 %ld   ｜   粉丝 %ld",follow,befollow]

#import "PersonHeadView.h"
#import "FXBlurView.h"
#import "ZYZCRCManager.h"
@interface PersonHeadView ()
@property (nonatomic, strong) UIImageView *infoView;
@property (nonatomic, strong) UIImageView *faceImgView;
@property (nonatomic, strong) UILabel     *attentionLab;
@property (nonatomic, strong) UIView      *baseInfoView;
@property (nonatomic, strong) UIButton    *preButton;
@property (nonatomic, strong) UIView      *moveLineView;
@property (nonatomic, strong) UIButton    *addInterestBtn;
@property (nonatomic, strong) UIButton    *chatBtn;
@property (nonatomic, strong) FXBlurView *blurView;
@property (nonatomic, strong) ZYZCRCManager *RCManager;
@end

@implementation PersonHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame=CGRectMake(0, 0, KSCREEN_W, HEAD_VIEW_HEIGHT);
        [self configUI];
    }
    return self;
}
-(void)configUI
{
    //背景图
    _infoView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height-45)];
    _infoView.contentMode=UIViewContentModeScaleAspectFill;
    _infoView.layer.masksToBounds=YES;
    _infoView.backgroundColor=[UIColor ZYZC_BgGrayColor];
    _infoView.image=[UIImage imageNamed:@"icon_placeholder"];
    [self addSubview:_infoView];
    [self addFXBlurView];
    //头像
    CGFloat faceWidth=80*KCOFFICIEMNT;
    _faceImgView=[[UIImageView alloc]initWithFrame:CGRectMake((self.width-faceWidth)/2, 64, faceWidth, faceWidth)];
    _faceImgView.image=[UIImage imageNamed:@"icon_placeholder"];
    _faceImgView.layer.cornerRadius=KCORNERRADIUS;
    _faceImgView.layer.masksToBounds=YES;
    _faceImgView.layer.borderWidth=2;
    _faceImgView.layer.borderColor=[UIColor whiteColor].CGColor;
    [self addSubview:_faceImgView];
    
    //基本信息
    _baseInfoView=[[UIView alloc]initWithFrame:CGRectMake(0, _faceImgView.bottom+KEDGE_DISTANCE, self.width, _infoView.bottom-30-_faceImgView.bottom-3*KEDGE_DISTANCE)];
    [self addSubview:_baseInfoView];
    
}

-(void)addFXBlurView
{
    if (_blurView) {
        [_blurView removeFromSuperview];
    }
    //创建毛玻璃
    _blurView = [[FXBlurView alloc] initWithFrame:_infoView.bounds];
    [_blurView setDynamic:NO];
    _blurView.blurRadius=10;
    [self addSubview:_blurView];
    UIView *greenView=[[UIView alloc]initWithFrame:_blurView.bounds];
    greenView.backgroundColor=[UIColor ZYZC_MainColor];
    greenView.alpha=0.6;
    [_blurView addSubview:greenView];
    [self insertSubview:_blurView atIndex:1];
    
}

-(void)setUserModel:(UserModel *)userModel
{
    _userModel=userModel;
    NSArray *textArr=nil;
    [_faceImgView sd_setImageWithURL:[NSURL URLWithString:userModel.faceImg]];
    [_infoView sd_setImageWithURL:[NSURL URLWithString:userModel.faceImg] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
         [self addFXBlurView];
    }];

    //名字
    UIFont *font=[UIFont boldSystemFontOfSize:22];
    CGFloat nameWidth=[ZYZCTool calculateStrLengthByText:userModel.userName andFont:font andMaxWidth:self.width].width;
    if (nameWidth>self.width-40) {
        nameWidth=self.width-40;
    }
    UILabel *nameLab=[self creatLabWithFrame:CGRectMake(self.width/2-(nameWidth+20)/2, 0, nameWidth, 30) andText:userModel.userName  andTextColor:[UIColor whiteColor] andFont:font andTextAlignment:NSTextAlignmentRight];
    [_baseInfoView addSubview:nameLab];
    
    //性别
    UIImageView *sexImg=[[UIImageView alloc]initWithFrame:CGRectMake(nameLab.right, nameLab.top+5, 20, 20)];
    if ([userModel.sex isEqualToString:@"1"]) {
        textArr=@[@"他发起的",@"他参与的",@"他推荐的"];
        sexImg.image=[UIImage imageNamed:@"btn_sex_mal"];
        
    }
    else if([userModel.sex isEqualToString:@"2"])
    {
        textArr=@[@"她发起的",@"她参与的",@"她推荐的"];
        sexImg.image=[UIImage imageNamed:@"btn_sex_fem"];
    }
    [_baseInfoView addSubview:sexImg];
    
    //关注和粉丝
    NSString *attentionText=FOLLIOW_AND_BEFOLLOW([_meGzAll integerValue], [_gzMeAll integerValue]);
    _attentionLab=[self creatLabWithFrame:CGRectMake(KEDGE_DISTANCE, nameLab.bottom, self.width-2*KEDGE_DISTANCE, 15) andText:attentionText andTextColor:[UIColor whiteColor] andFont:[UIFont systemFontOfSize:13] andTextAlignment:NSTextAlignmentCenter];
    [_baseInfoView addSubview:_attentionLab];
    
    //基础信息
    NSString *personInfo=@"23岁、天枰座、50kg、170cm、单身";
    UILabel  *personInfoLab=[self creatLabWithFrame:CGRectMake(KEDGE_DISTANCE, _attentionLab.bottom+5, _attentionLab.width, 15) andText:personInfo andTextColor:[UIColor whiteColor] andFont:[UIFont systemFontOfSize:13] andTextAlignment:NSTextAlignmentCenter];
    [_baseInfoView addSubview:personInfoLab];
    
    //他发起，他参与，他推荐
    UIView *clickView=[[UIView alloc]initWithFrame:CGRectMake(0, _infoView.bottom, self.width, 45)];
    clickView.backgroundColor=[UIColor whiteColor];
    [self addSubview:clickView ];
    [clickView addSubview:[UIView lineViewWithFrame:CGRectMake(0, clickView.height-1, self.width, 1) andColor:nil]];
    
    CGFloat buttonWidth=70;
    CGFloat edg=(self.width-buttonWidth*3)/4;
    for (int i=0; i<3; i++) {
        UIButton *button=[self createButtonWithFrame:CGRectMake(edg+(buttonWidth+edg)*i,0, buttonWidth,clickView.height) andTag:KPERSON_PRODUCT_TYPE+i andNeedBorder:NO andText:textArr.count==3?textArr[i]:nil andTextColor:[UIColor ZYZC_TextGrayColor]];
        button.titleLabel.font=[UIFont systemFontOfSize:15];
        [clickView addSubview:button];
        if (i==0) {
            _preButton=button;
        }
    }
    _moveLineView=[UIView lineViewWithFrame:CGRectMake(_preButton.left,clickView.height-2 , buttonWidth, 2) andColor:[UIColor ZYZC_MainColor]];
    [clickView addSubview:_moveLineView];
    
    [self clickButton:_preButton];
    
}

-(void)setFriendship:(BOOL )friendship
{
    _friendship=friendship;
    //加关注
    _addInterestBtn=[self createButtonWithFrame:CGRectMake(30, _infoView.bottom-KEDGE_DISTANCE-30, 100, 30) andTag:AddInterest andNeedBorder:YES  andText:_friendship?@"取消关注":@"＋  关注" andTextColor:[UIColor whiteColor]];
    [self addSubview:_addInterestBtn];
    
    //留言
    _chatBtn=[self createButtonWithFrame:CGRectMake(self.width-130, _addInterestBtn.top, 100, 30) andTag:ChatType andNeedBorder:YES  andText:@"留言" andTextColor:[UIColor whiteColor]];
    [self addSubview:_chatBtn];

}

#pragma mark ---创建button
-(UIButton *)createButtonWithFrame:(CGRect)frame andTag:(NSInteger )tag andNeedBorder:(BOOL )needborder  andText:(NSString *)text andTextColor:(UIColor *)textColor
{
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=frame;
    button.tag=tag;
    [button setTitle:text forState:UIControlStateNormal];
    [button setTitleColor:textColor forState:UIControlStateNormal];
    if (needborder) {
        button.layer.cornerRadius=KCORNERRADIUS;
        button.layer.masksToBounds=YES;
        button.layer.borderWidth=1.5;
        button.layer.borderColor=[UIColor whiteColor].CGColor;
    }
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

#pragma mark --- 创建lable
-(UILabel *)creatLabWithFrame:(CGRect)frame andText:(NSString *)text andTextColor:(UIColor *)textColor andFont:(UIFont *)font andTextAlignment:(NSTextAlignment )alignment
{
    UILabel *lab=[[UILabel alloc]initWithFrame:frame];
    lab.text=text;
    lab.textColor=textColor;
    lab.font=font;
    lab.textAlignment=alignment;
    return lab;
}

#pragma mark --- button点击事件
-(void)clickButton:(UIButton *)button
{
    if (_preButton==button) {
        return;
    }
    //发布，参与，推荐
    if (button.tag>=PublishType&&button.tag<=RecommendType) {
        
        if (_changeProduct) {
            _changeProduct(button.tag);
        }

        if (_preButton&&_preButton!=button) {
            [_preButton setTitleColor:[UIColor ZYZC_TextGrayColor] forState:UIControlStateNormal];
        }
        [button setTitleColor:[UIColor ZYZC_MainColor] forState:UIControlStateNormal];
        _moveLineView.left=button.left;
        _preButton=button;
        
    }
    //添加关注／取消关注
    if (button.tag==AddInterest) {
        
        [self addOrDeleteFollow];
    }
    //留言
    else if(button.tag==ChatType)
    {
        NSLog(@"留言");
        [self chat];
    }
}

#pragma mark --- 留言
-(void)chat
{
    _RCManager=[ZYZCRCManager defaultManager];
    [_RCManager connectTarget:_userModel.openid andSuperViewController:self.viewController];
}

#pragma mark --- 添加关注／取消关注
-(void)addOrDeleteFollow{
    
     NSDictionary *params=@{@"openid":[ZYZCTool getUserId],@"friendsId":_userModel.userId};
    if (_friendship) {
        //取消关注
        [ZYZCHTTPTool postHttpDataWithEncrypt:YES andURL:UNFOLLOWUSER andParameters:params andSuccessGetBlock:^(id result, BOOL isSuccess)
        {
            NSLog(@"%@",result);
            if (isSuccess) {
            [_addInterestBtn setTitle:@"＋  关注" forState:UIControlStateNormal];
            }
            _gzMeAll=[NSNumber numberWithInteger:([_gzMeAll integerValue]-1)];
            _attentionLab.text=FOLLIOW_AND_BEFOLLOW([_meGzAll integerValue], [_gzMeAll integerValue]);
            _friendship=!_friendship;
        } andFailBlock:^(id failResult) {
            
        }];
        
    }
        //添加关注
    else
    {
        [ZYZCHTTPTool postHttpDataWithEncrypt:YES andURL:FOLLOWUSER andParameters:params andSuccessGetBlock:^(id result, BOOL isSuccess) {
            NSLog(@"%@",result);
            if (isSuccess) {
                [_addInterestBtn setTitle:@"取消关注" forState:UIControlStateNormal];
            }
            _gzMeAll=[NSNumber numberWithInteger:([_gzMeAll integerValue]+1)];
            _attentionLab.text=FOLLIOW_AND_BEFOLLOW([_meGzAll integerValue], [_gzMeAll integerValue]);
             _friendship=!_friendship;
        } andFailBlock:^(id failResult) {
            
        }];
    }
}



#pragma mark --- 控件随tableView的contentOffSet而改变
-(void)setTableOffSetY:(CGFloat)tableOffSetY
{
    _tableOffSetY=tableOffSetY;
    
    if (tableOffSetY>=-(HEAD_VIEW_HEIGHT)&&tableOffSetY<=64-HEAD_VIEW_HEIGHT) {
        CGFloat rate=MIN(1, (tableOffSetY+HEAD_VIEW_HEIGHT)/64);
        
        _faceImgView.alpha=1-rate;
    }
    
    if (tableOffSetY>=-(HEAD_VIEW_HEIGHT)&&tableOffSetY<=64+_faceImgView.height+KEDGE_DISTANCE-HEAD_VIEW_HEIGHT) {
        CGFloat rate=MIN(1, (tableOffSetY+HEAD_VIEW_HEIGHT)/(64+_faceImgView.height+KEDGE_DISTANCE));
        
        _baseInfoView.alpha=1-rate;
    }

}

@end
