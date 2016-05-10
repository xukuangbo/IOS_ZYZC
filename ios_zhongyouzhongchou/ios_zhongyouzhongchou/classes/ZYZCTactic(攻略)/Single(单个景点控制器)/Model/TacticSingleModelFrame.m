//
//  TacticSingleModelFrame.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/4/22.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "TacticSingleModelFrame.h"
#import "TacticSingleModel.h"
#import "TacticCustomMapView.h"
@implementation TacticSingleModelFrame


- (void)setTacticSingleModel:(TacticSingleModel *)tacticSingleModel
{
    _tacticSingleModel = tacticSingleModel;
    
    self.descViewF = CGRectMake(TacticTableViewCellMargin, TacticTableViewCellMargin, KSCREEN_W - TacticTableViewCellMargin * 2, 120);
    
    //视频
    CGFloat pictureViewY = 0;
    CGFloat flashViewY = CGRectGetMaxY(self.descViewF) + TacticTableViewCellMargin;
    if (tacticSingleModel.videoUrl && ![tacticSingleModel.videoUrl isEqualToString:@""]) {//有视频
        CGFloat flashViewX = TacticTableViewCellMargin;
        CGFloat flashViewW = KSCREEN_W - TacticTableViewCellMargin * 2;
        CGFloat flashViewH = oneViewMapHeight;
        self.flashViewF = CGRectMake(flashViewX, flashViewY, flashViewW, flashViewH);
        
        CGFloat flashPlayButtonX = TacticTableViewCellMargin;
        CGFloat flashPlayButtonY = descLabelBottom + TacticTableViewCellTextMargin;
        CGFloat flashPlayButtonW = flashViewW - TacticTableViewCellMargin * 2;
        CGFloat flashPlayButtonH = oneViewHeight;
        self.flashPlayButtonF = CGRectMake(flashPlayButtonX, flashPlayButtonY, flashPlayButtonW, flashPlayButtonH);
        
        pictureViewY = CGRectGetMaxY(self.flashViewF) + TacticTableViewCellMargin;
    }else{
        self.flashViewF = CGRectMake(0, flashViewY, 0, 0);
        pictureViewY = CGRectGetMaxY(self.descViewF);
    }
    
    //长图
    CGFloat tipsViewY = 0;
    if(tacticSingleModel.glid){//有长图
        CGFloat pictureViewX = TacticTableViewCellMargin;
        CGFloat pictureViewW = KSCREEN_W - TacticTableViewCellMargin * 2;
        CGFloat pictureViewH = oneViewMapHeight;
        self.pictureViewF = CGRectMake(pictureViewX, pictureViewY, pictureViewW, pictureViewH);
        
        CGFloat pictureShowButtonX = TacticTableViewCellMargin;
        CGFloat pictureShowButtonY = descLabelBottom + TacticTableViewCellTextMargin;
        CGFloat pictureShowButtonW = pictureViewW - TacticTableViewCellMargin * 2;
        CGFloat pictureShowButtonH = oneViewHeight;
        self.pictureShowButtonF = CGRectMake(pictureShowButtonX, pictureShowButtonY, pictureShowButtonW, pictureShowButtonH);
        
        tipsViewY = CGRectGetMaxY(self.pictureViewF) + TacticTableViewCellMargin;
        
    }else{//无长图
        tipsViewY = CGRectGetMaxY(self.flashViewF) +TacticTableViewCellMargin;
        self.pictureViewF = CGRectMake(0, pictureViewY, 0, 0);
    }
    
    //众游小贴士
    CGFloat mustPlayViewY = 0;
    if(tacticSingleModel.tips){//有贴士
        CGFloat tipsViewX = TacticTableViewCellMargin;
        CGFloat tipsViewW = KSCREEN_W - TacticTableViewCellMargin * 2;
        CGFloat tipsViewH = oneViewMapHeight;
        
        self.tipsViewF = CGRectMake(tipsViewX, tipsViewY, tipsViewW, tipsViewH);
        
        CGFloat tipsShowButtonX = TacticTableViewCellMargin;
        CGFloat tipsShowButtonY = descLabelBottom + TacticTableViewCellTextMargin;
        CGFloat tipsShowButtonW = tipsViewW - TacticTableViewCellMargin * 2;
        CGFloat tipsShowButtonH = oneViewHeight;
        self.tipsShowButtonF = CGRectMake(tipsShowButtonX, tipsShowButtonY, tipsShowButtonW, tipsShowButtonH);
        
        mustPlayViewY = CGRectGetMaxY(self.tipsViewF) + TacticTableViewCellMargin;
    }else{
        self.tipsViewF = CGRectMake(0, tipsViewY, 0, 0);
        mustPlayViewY = CGRectGetMaxY(self.pictureShowButtonF) + TacticTableViewCellMargin;
    }
    
    //必玩景点
    CGFloat foodsY = 0;
    if(tacticSingleModel.mgViews.count > 0){//有必玩景点
        CGFloat mustPlayViewX = TacticTableViewCellMargin;
        CGFloat mustPlayViewW = KSCREEN_W - TacticTableViewCellMargin * 2;
        CGFloat mustPlayViewH = threeViewMapHeight;
        
        self.mustPlayViewF = CGRectMake(mustPlayViewX, mustPlayViewY, mustPlayViewW, mustPlayViewH);
        
        CGFloat mustPlayViewButtonX = TacticTableViewCellMargin;
        CGFloat mustPlayViewButtonY = descLabelBottom + TacticTableViewCellTextMargin;
        CGFloat mustPlayViewButtonW = mustPlayViewW - TacticTableViewCellMargin * 2;
        CGFloat mustPlayViewButtonH = threeViewHeight;
        self.mustPlayViewButtonF = CGRectMake(mustPlayViewButtonX, mustPlayViewButtonY, mustPlayViewButtonW, mustPlayViewButtonH);
        
        foodsY = CGRectGetMaxY(self.mustPlayViewF) + TacticTableViewCellMargin;
    }else{
        self.mustPlayViewF = CGRectMake(0, mustPlayViewY, 0, 0);
        foodsY = CGRectGetMaxY(self.tipsViewF) + TacticTableViewCellMargin;
    }
    
    //特色美食
    CGFloat XXX = 0;
    if(tacticSingleModel.foods.count > 0){//有必玩景点
        CGFloat foodsViewX = TacticTableViewCellMargin;
        CGFloat foodsViewW = KSCREEN_W - TacticTableViewCellMargin * 2;
        CGFloat foodsViewH = threeViewMapHeight;
        
        self.foodsViewF = CGRectMake(foodsViewX, foodsY, foodsViewW, foodsViewH);
        
        CGFloat foodsPlayViewButtonX = TacticTableViewCellMargin;
        CGFloat foodsPlayViewButtonY = descLabelBottom + TacticTableViewCellTextMargin;
        CGFloat foodsPlayViewButtonW = foodsViewW - TacticTableViewCellMargin * 2;
        CGFloat foodsPlayViewButtonH = (KSCREEN_W - 10 * 6) / 3.0;
        self.foodsPlayViewButtonF = CGRectMake(foodsPlayViewButtonX, foodsPlayViewButtonY, foodsPlayViewButtonW, foodsPlayViewButtonH);
        
        XXX = CGRectGetMaxY(self.foodsViewF);
    }else{
        self.foodsPlayViewButtonF = CGRectMake(0, mustPlayViewY, 0, 0);
        XXX = CGRectGetMaxY(self.mustPlayViewF);
    }
    
    self.realHeight = XXX + TacticTableViewCellMargin;
    
    //这里添加一个方法,返回一个字符串
    self.allString = [self returnStr:tacticSingleModel];
}

- (NSString *)returnStr:(TacticSingleModel *)tacticSingleModel
{
    NSString *str = [NSString string];
    if (tacticSingleModel.viewText) {//概况
        str = [str stringByAppendingString:[NSString stringWithFormat:@"概况:\n\t%@",tacticSingleModel.viewText]];
    }
    if (tacticSingleModel.weather) {//气候
        str = [str stringByAppendingString:[NSString stringWithFormat:@"\n\r气候:\n\t%@",tacticSingleModel.weather]];
    }
    if (tacticSingleModel.traffic) {//交通
        str = [str stringByAppendingString:[NSString stringWithFormat:@"\n\r交通:\n\t%@",tacticSingleModel.traffic]];
    }
    if (tacticSingleModel.stay) {//住宿
        str = [str stringByAppendingString:[NSString stringWithFormat:@"\n\r住宿:\n\t%@",tacticSingleModel.stay]];
    }
    if (tacticSingleModel.shopping) {//购物
        str = [str stringByAppendingString:[NSString stringWithFormat:@"\n\r购物:\n\t%@",tacticSingleModel.shopping]];
    }
    if (tacticSingleModel.language) {//语言
        str = [str stringByAppendingString:[NSString stringWithFormat:@"\n\r语言:\n\t%@",tacticSingleModel.language]];
    }
    if (tacticSingleModel.parities) {//汇率
        str = [str stringByAppendingString:[NSString stringWithFormat:@"\n\r汇率:\n\t%@",tacticSingleModel.parities]];
    }
    if (tacticSingleModel.visa) {//签证
        str = [str stringByAppendingString:[NSString stringWithFormat:@"\n\r签证:\n\t%@",tacticSingleModel.visa]];
    }
    

    return str;
}
@end
