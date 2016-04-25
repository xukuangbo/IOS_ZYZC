//
//  ZCDetailArrangeFirstCell.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/4/23.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "ZCDetailArrangeFirstCell.h"

@interface ZCDetailArrangeFirstCell ()
@property (nonatomic ,assign ) BOOL isFirstConfigView;
@property (nonatomic ,strong ) NSMutableArray *viewHeights;
@end

@implementation ZCDetailArrangeFirstCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)configUI
{
    [super configUI];
    _isFirstConfigView=YES;
    //景点、交通、住宿、餐饮视图初始化高度数组
    _viewHeights=[NSMutableArray arrayWithArray:@[@0.0,@0.0,@0.0,@0.0]];
}

-(void)setOneDaydetailModel:(MoreFZCTravelOneDayDetailMdel *)oneDaydetailModel
{
    _oneDaydetailModel=oneDaydetailModel;
    self.hasMovie=YES;
    self.hasVoice=YES;
    self.hasWord =YES;
    self.hasSight=YES;
    self.hasTrans=YES;
    self.hasLive =YES;
    self.hasFood =YES;
    [self reloadDataByModel];
    CGFloat cellHeight=self.bgImg.height;
    
    self.titleLab.text=oneDaydetailModel.date;
    //添加景点、交通、住宿、餐饮描述
    
    //是否有对应适度的判断数组
    NSArray *hasViews=@[[NSNumber numberWithBool:self.hasSight],[NSNumber numberWithBool:self.hasTrans],[NSNumber numberWithBool:self.hasLive],[NSNumber numberWithBool:self.hasFood] ];

    
    //对应视图标题名数组
    NSArray *titleArr=@[@"景点:",@"交通:",@"住宿:",@"餐饮:"];
    
    NSString *sightText=@"        山东省的雷锋精神独立开发技术开发速度减肥开始放声大哭来说都是离开都是发生地方是亮的是发生地方就是";
    NSString *transText=@"        圣诞节啊空间受到法律开始的肌肤立刻圣诞节愤世嫉俗的离开方式及独领风骚的距离开始减肥了啊快放假放假啊啊季后赛大哥大姐哈哥啊撒上了扩大华师大大家哈空间大";
    NSString *liveText=@"        圣诞节啊空是德弗里斯的飞机失联开发建设路口发生的间啊快放假放假啊啊季后赛大哥大姐哈哥啊撒了扩大华师大大家哈空间大";
    NSString *foodText=@"        圣诞节啊空事都发生地方看间啊快放假放假啊啊季后赛大哥大姐哈哥啊撒上了扩大华师大大家哈空间大";
    //对应视图文字描述数组
    NSArray *textsArr=@[sightText,transText,liveText,foodText];
    
    NSArray *sightImgs=@[@"",@"",@"",@""];
    NSArray *transImgs=@[@"",@"",@""];
    NSArray *liveImgs= @[@"",@""];
    NSArray *foodImgs= @[@""];
    //对应视图图片数组
    NSArray *imgsArr =@[sightImgs,transImgs,liveImgs,foodImgs];
    
    if (_isFirstConfigView) {
        for (int i=0; i<4; i++) {
            if ([hasViews[i] boolValue]) {
                UIView *contentView=[self configViewByViewTop:self.bgImg.height+KEDGE_DISTANCE andtitle:titleArr[i] andText:textsArr[i] andImages:imgsArr[i]];
                [self addSubview:contentView];
                [_viewHeights replaceObjectAtIndex:i withObject:[NSNumber numberWithFloat:contentView.height]];
            }
        }
    }
    _isFirstConfigView=NO;
    
    self.bgImg.height=cellHeight+
    self.hasSight*([_viewHeights[0] floatValue]+KEDGE_DISTANCE)+
    self.hasTrans*([_viewHeights[1] floatValue]+KEDGE_DISTANCE)+
    self.hasLive *([_viewHeights[2] floatValue]+KEDGE_DISTANCE)+
    self.hasFood *([_viewHeights[3] floatValue]+KEDGE_DISTANCE);
    
    self.oneDaydetailModel.cellHeight=self.bgImg.height;
}

-(UIView *)configViewByViewTop:(CGFloat)top  andtitle:(NSString *)title andText:(NSString *)text andImages:(NSArray *)images
{
    //创建视图
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(2*KEDGE_DISTANCE, top,  KSCREEN_W-4*KEDGE_DISTANCE, 0)];
    view.backgroundColor=[UIColor whiteColor];
    //添加横线
    [view addSubview:[UIView lineViewWithFrame:CGRectMake(0, 0, view.width, 1) andColor:nil]];
    //标题
    UILabel *titleLab=[[UILabel alloc]initWithFrame:CGRectMake(0, KEDGE_DISTANCE, view.width, 20)];
    titleLab.text=title;
    titleLab.font=[UIFont boldSystemFontOfSize:15];
    [view addSubview:titleLab];
    //文字内容
    BOOL hasTextLab=(text!=nil && ![text isEqualToString:@""])?YES:NO;
    CGFloat textHeight=0.0;
    if (hasTextLab) {
        CGFloat labHeight= [ZYZCTool calculateStrByLineSpace:10.0 andString:text andFont:[UIFont systemFontOfSize:15] andMaxWidth:view.width].height;
        CGFloat labWidth =view.width;
        UILabel *textLab= [[UILabel alloc]initWithFrame:CGRectMake(0, titleLab.bottom+KEDGE_DISTANCE, labWidth, labHeight+10)];
        textLab.numberOfLines=0;
        textLab.attributedText=[ZYZCTool setLineDistenceInText:text];
        textLab.font=[UIFont systemFontOfSize:15];
        textLab.layer.cornerRadius=KCORNERRADIUS;
        textLab.layer.masksToBounds=YES;
        textLab.textColor=[UIColor ZYZC_TextBlackColor];
        textLab.backgroundColor=[UIColor ZYZC_BgGrayColor01];
        [view addSubview:textLab];
        textHeight=textLab.height;
    }
    //图片内容
    BOOL hasImages=images.count>0?YES:NO;
    CGFloat imagesHeight=0.0;
    if (hasImages) {
        CGFloat imgWidth=63;
        CGFloat imgHeight=imgWidth;
        CGFloat imgX=0;
        CGFloat imgY=KEDGE_DISTANCE;
        CGFloat imgEdg=5*KCOFFICIEMNT;
        
        UIView *imgsView=[[UIView alloc]initWithFrame:CGRectMake(0, titleLab.bottom+hasTextLab*(textHeight+KEDGE_DISTANCE), view.width, imgHeight)];
        [view addSubview:imgsView];
        imagesHeight=imgsView.height;
        
        for (int i = 0;i<images.count; i++) {
            UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(imgX+(imgWidth+imgEdg)*i, imgY, imgWidth, imgHeight)];
            img.image=[UIImage imageNamed:@"jd_f"];
            img.layer.cornerRadius=KCORNERRADIUS;
            img.layer.masksToBounds=YES;
            [imgsView addSubview:img];
        }
    }
    //计算视图高度
    view.height=titleLab.bottom+KEDGE_DISTANCE+hasTextLab*(textHeight+KEDGE_DISTANCE)+hasImages*(imagesHeight+KEDGE_DISTANCE);
    //对背景卡片高度重赋值
    self.bgImg.height=view.bottom;

    return view;
}

@end
