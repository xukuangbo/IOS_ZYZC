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
    if (!_addView) {
        _addView=[[AddDetailView alloc]initWithFrame:CGRectMake(2*KEDGE_DISTANCE, self.titleLab.bottom+10, KSCREEN_W-4*KEDGE_DISTANCE , TRAVELOPENHEIGHT-KEDGE_DISTANCE)];
        [self.contentView addSubview:_addView];
    }
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

-(void)setSoundFileName:(NSString *)soundFileName
{
    _soundFileName=soundFileName;
    _contentEntryView.soundFileName=soundFileName;
}

#pragma mark --- 存储数据到模型中
-(void)saveTravelOneDayDetailData
{
    AddSceneView *sceneContentView=[_addView viewWithTag:SceneContentType];
    //保存景点描述文字
    _oneDetailModel.siteDes=sceneContentView.placeholdLab.text;
    //保存景点图库标示符
    _oneDetailModel.sitesArr=sceneContentView.siteTagArr;
    
    AddSceneView *trafficContentView=[_addView viewWithTag:TrafficContentType];
    //保存交通描述文字
    _oneDetailModel.trafficDes=trafficContentView.placeholdLab.text;
    
    AddSceneView *accommodateContentView=[_addView viewWithTag:AccommodateContentType];
    //保存住宿描述文字
    _oneDetailModel.accommodateDes=accommodateContentView.placeholdLab.text;
    
     AddSceneView *foodContentView=[_addView viewWithTag:FoodContentType];
    //保存餐饮描述文字
    _oneDetailModel.foodDes=foodContentView.placeholdLab.text;
    //保存当日旅游文字描述
    _oneDetailModel.travelDes=@"";
    //保存当日旅游语音描述
    _oneDetailModel.voiceUrl=nil;
    //保存当日旅游视屏描述
    _oneDetailModel.movieUrl=nil;
}

@end
