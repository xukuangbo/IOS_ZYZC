//
//  TravelSecondCell.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/3/25.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "TravelSecondCell.h"
@implementation TravelSecondCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)configUI
{
    _oneDetailModel=[[MoreFZCTravelOneDayDetailMdel alloc]init];
    [super configUI];
    self.bgImg.height=TRAVELSECONDCELLHEIGHT;
    self.titleLab.textColor=[UIColor blackColor];
    
    //详细行程按钮
    UIButton *detailBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    detailBtn.frame=CGRectMake(KSCREEN_W-2*KEDGE_DISTANCE-80, 15, 80, 25);
    detailBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [detailBtn setTitle:@"详细行程" forState:UIControlStateNormal];
    [detailBtn setTitleColor:[UIColor ZYZC_TextBlackColor] forState:UIControlStateNormal];
    detailBtn.layer.cornerRadius=KCORNERRADIUS;
    detailBtn.layer.masksToBounds=YES;
    detailBtn.layer.borderWidth=1;
    detailBtn.layer.borderColor=[UIColor ZYZC_MainColor].CGColor;
    [detailBtn addTarget:self action:@selector(clickDetailTravel) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:detailBtn];
    detailBtn.hidden=YES;
    
    _addView=[[AddDetailView alloc]initWithFrame:CGRectMake(2*KEDGE_DISTANCE, self.titleLab.bottom+10, KSCREEN_W-4*KEDGE_DISTANCE , TRAVELOPENHEIGHT-KEDGE_DISTANCE)];
    [self.contentView addSubview:_addView];
    _addView.hidden=YES;
    
    //添加录入内容
     _contentEntryView=[[FZCContentEntryView alloc]initWithFrame:CGRectMake(2*KEDGE_DISTANCE, self.topLineView.bottom, 0,0)];
    [self.contentView addSubview:_contentEntryView];
    
}
/**
 *  展开视图，添加详细行程
 */
-(void)getChangeHeightView
{
    //创建添加详细行程视图
    _addView.hidden=NO;
    self.bgImg.height+=TRAVELOPENHEIGHT;
    self.topLineView.top+=TRAVELOPENHEIGHT;
    self.contentEntryView.top+=TRAVELOPENHEIGHT;
}
/**
 *  收起视图，收起详细行程
 */
-(void)getNormalHeightView
{
    if (_addView) {
        _addView.hidden=YES;
    }
    
    self.bgImg.height-=TRAVELOPENHEIGHT;
    self.topLineView.top-=TRAVELOPENHEIGHT;
    self.contentEntryView.top-=TRAVELOPENHEIGHT;
}

#pragma mark --- 展开详细行程或关闭
-(void)clickDetailTravel
{
    _isOpenView=!_isOpenView;
    //刷新cell
    if (self.reloadTableBlock) {
        self.reloadTableBlock(_isOpenView);
    }
    if (_isOpenView) {
      [self getChangeHeightView];
    }
    else
    {
      [self getNormalHeightView];
    }
}


#pragma mark --- 记录FZCContentEntryView来源于行程
-(void)setContentBelong:(NSString *)contentBelong
{
    _contentBelong=contentBelong;
    _contentEntryView.contentBelong=contentBelong;
}

#pragma mark --- 加载数据
-(void)setOneDetailModel:(MoreFZCTravelOneDayDetailMdel *)oneDetailModel
{
    self.titleLab.text=[NSString stringWithFormat:@"第%.2zd天:",oneDetailModel.day];
    
    AddSceneView *sceneContentView=[_addView viewWithTag:SceneContentType];
    if(oneDetailModel.siteDes.length)
    {
        sceneContentView.textView.text=oneDetailModel.siteDes;
        sceneContentView.placeholdLab.hidden=YES;
    }
    
    AddSceneView *trafficContentView=[_addView viewWithTag:TrafficContentType];
    if(oneDetailModel.trafficDes.length)
    {
        trafficContentView.textView.text=oneDetailModel.trafficDes;;
        trafficContentView.placeholdLab.hidden=YES;
    }
    
    AddSceneView *accommodateContentView=[_addView viewWithTag:AccommodateContentType];
    if (oneDetailModel.liveDes.length) {
        accommodateContentView.textView.text=oneDetailModel.liveDes;
        accommodateContentView.placeholdLab.hidden=YES;
    }

    AddSceneView *foodContentView=[_addView viewWithTag:FoodContentType];
    if (oneDetailModel.foodDes.length) {
        foodContentView.textView.text=oneDetailModel.foodDes;
        foodContentView.placeholdLab.hidden=YES;
    }
    
    WordView *wordView=(WordView *)[_contentEntryView viewWithTag:WordViewType];
    if (oneDetailModel.wordDes.length) {
        wordView.textView.text=oneDetailModel.wordDes;
        wordView.placeHolderLab.hidden=YES;
    }
    
    SoundView *soundView=(SoundView *)[_contentEntryView viewWithTag:SoundViewType];
    if (oneDetailModel.voiceUrl.length) {
        soundView.soundFileName=oneDetailModel.voiceUrl;
        soundView.soundProgress=0;
    }
    
    MovieView *movieView=(MovieView *)[_contentEntryView viewWithTag:MovieViewType];
    if (oneDetailModel.voiceUrl.length) {
        soundView.soundFileName=oneDetailModel.voiceUrl;
        soundView.soundProgress=0;
    }
    if (oneDetailModel.movieImg.length) {
        movieView.movieImg.image=[UIImage imageWithContentsOfFile:oneDetailModel.movieImg];
        movieView.movieImgFileName=oneDetailModel.movieImg;
        movieView.movieFileName=oneDetailModel.movieUrl;
        movieView.turnImageView.hidden=NO;
    }

    
}

#pragma mark --- 存储数据到模型中
-(void)saveTravelOneDayDetailData
{
    AddSceneView *sceneContentView=[_addView viewWithTag:SceneContentType];
    //保存景点描述文字
    if (sceneContentView.textView.text.length) {
        _oneDetailModel.siteDes=sceneContentView.textView.text;
    }
//    //保存景点图库标示符
//    if (sceneContentView.siteTagArr.count) {
//        _oneDetailModel.sites=sceneContentView.siteTagArr;
//    }
    
    AddSceneView *trafficContentView=[_addView viewWithTag:TrafficContentType];
    //保存交通描述文字
    if (trafficContentView.textView.text.length) {
        _oneDetailModel.trafficDes=trafficContentView.textView.text;
    }
    AddSceneView *accommodateContentView=[_addView viewWithTag:AccommodateContentType];
    //保存住宿描述文字
    if (accommodateContentView.textView.text.length) {
         _oneDetailModel.liveDes=accommodateContentView.textView.text;
    }
     AddSceneView *foodContentView=[_addView viewWithTag:FoodContentType];
    //保存餐饮描述文字
    if (foodContentView.textView.text.length) {
        _oneDetailModel.foodDes=foodContentView.textView.text;
    }
    
    //保存当日旅游文字描述
    WordView *wordView=(WordView *)[_contentEntryView viewWithTag:WordViewType];
    if (wordView.textView.text.length) {
        _oneDetailModel.wordDes=wordView.textView.text;
    }
    //保存当日旅游语音描述
    SoundView *soundView=(SoundView *)[_contentEntryView viewWithTag:SoundViewType];
    _oneDetailModel.voiceUrl=soundView.soundFileName;
    //保存当日旅游视屏描述
    MovieView *movieView=(MovieView *)[_contentEntryView viewWithTag:MovieViewType];
    _oneDetailModel.movieUrl=movieView.movieFileName;
    //保存当日旅行视屏第一帧
    _oneDetailModel.movieImg=movieView.movieImgFileName;
}

@end
