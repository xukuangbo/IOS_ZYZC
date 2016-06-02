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
    
    CGFloat noContentHeight = descLabelBottom + TacticTableViewCellMargin;
    //视频
    CGFloat flashViewX = TacticTableViewCellMargin;
    CGFloat flashViewW = KSCREEN_W - TacticTableViewCellMargin * 2;
    CGFloat flashViewY = CGRectGetMaxY(self.descViewF) + TacticTableViewCellMargin;
    if (tacticSingleModel.videoUrl && ![tacticSingleModel.videoUrl isEqualToString:@""]) {//有视频
        
        CGFloat flashViewH = oneViewMapHeight;
        self.flashViewF = CGRectMake(flashViewX, flashViewY, flashViewW, flashViewH);
        
        CGFloat flashPlayButtonX = TacticTableViewCellMargin;
        CGFloat flashPlayButtonY = descLabelBottom + TacticTableViewCellTextMargin;
        CGFloat flashPlayButtonW = flashViewW - TacticTableViewCellMargin * 2;
        CGFloat flashPlayButtonH = oneViewHeight;
        self.flashPlayButtonF = CGRectMake(flashPlayButtonX, flashPlayButtonY, flashPlayButtonW, flashPlayButtonH);
    }else{
        
        CGFloat flashViewH = noContentHeight;
        self.flashViewF = CGRectMake(flashViewX, flashViewY, flashViewW, flashViewH);
    }
    
    
    //长图
    CGFloat pictureViewX = TacticTableViewCellMargin;
    CGFloat pictureViewY = CGRectGetMaxY(self.flashViewF) + TacticTableViewCellMargin;
    CGFloat pictureViewW = KSCREEN_W - TacticTableViewCellMargin * 2;
    if(tacticSingleModel.glid){//有长图
        
        CGFloat pictureViewH = oneViewMapHeight;
        self.pictureViewF = CGRectMake(pictureViewX, pictureViewY, pictureViewW, pictureViewH);
        
        CGFloat pictureShowButtonX = TacticTableViewCellMargin;
        CGFloat pictureShowButtonY = descLabelBottom + TacticTableViewCellTextMargin;
        CGFloat pictureShowButtonW = pictureViewW - TacticTableViewCellMargin * 2;
        CGFloat pictureShowButtonH = oneViewHeight;
        self.pictureShowButtonF = CGRectMake(pictureShowButtonX, pictureShowButtonY, pictureShowButtonW, pictureShowButtonH);
        
    }else{//无长图
        self.pictureViewF = CGRectMake(pictureViewX, pictureViewY, pictureViewW, noContentHeight);
    }
    
    //众游小贴士
    CGFloat tipsViewX = TacticTableViewCellMargin;
    CGFloat tipsViewW = KSCREEN_W - TacticTableViewCellMargin * 2;
    CGFloat tipsViewY = CGRectGetMaxY(self.pictureViewF) + TacticTableViewCellMargin;
    if(tacticSingleModel.tips){//有贴士
        
        CGFloat tipsViewH = oneViewMapHeight;
        self.tipsViewF = CGRectMake(tipsViewX, tipsViewY, tipsViewW, tipsViewH);
        
        CGFloat tipsShowButtonX = TacticTableViewCellMargin;
        CGFloat tipsShowButtonY = descLabelBottom + TacticTableViewCellTextMargin;
        CGFloat tipsShowButtonW = tipsViewW - TacticTableViewCellMargin * 2;
        CGFloat tipsShowButtonH = oneViewHeight;
        self.tipsShowButtonF = CGRectMake(tipsShowButtonX, tipsShowButtonY, tipsShowButtonW, tipsShowButtonH);
    }else{
        
        self.tipsViewF = CGRectMake(tipsViewX, tipsViewY, tipsViewW, noContentHeight);
    }
    
    //必玩景点
    CGFloat mustPlayViewY = CGRectGetMaxY(self.tipsViewF) + TacticTableViewCellMargin;
    CGFloat mustPlayViewX = TacticTableViewCellMargin;
    CGFloat mustPlayViewW = KSCREEN_W - TacticTableViewCellMargin * 2;
    if(tacticSingleModel.mgViews.count > 0){//有必玩景点
        
        CGFloat mustPlayViewH = threeViewMapHeight;
        self.mustPlayViewF = CGRectMake(mustPlayViewX, mustPlayViewY, mustPlayViewW, mustPlayViewH);
        
        CGFloat mustPlayViewButtonX = TacticTableViewCellMargin;
        CGFloat mustPlayViewButtonY = descLabelBottom + TacticTableViewCellTextMargin;
        CGFloat mustPlayViewButtonW = mustPlayViewW - TacticTableViewCellMargin * 2;
        CGFloat mustPlayViewButtonH = threeViewHeight;
        self.mustPlayViewButtonF = CGRectMake(mustPlayViewButtonX, mustPlayViewButtonY, mustPlayViewButtonW, mustPlayViewButtonH);
        
    }else{
        self.mustPlayViewF = CGRectMake(mustPlayViewX, mustPlayViewY, mustPlayViewW, noContentHeight);
    }
    
    //特色美食
    CGFloat XXX = 0;
    CGFloat foodsViewX = TacticTableViewCellMargin;
    CGFloat foodsViewW = KSCREEN_W - TacticTableViewCellMargin * 2;
    CGFloat foodsViewY = CGRectGetMaxY(self.mustPlayViewF) + TacticTableViewCellMargin;
    if(tacticSingleModel.foods.count > 0){//有必玩景点
        
        CGFloat foodsViewH = threeViewMapHeight;
        self.foodsViewF = CGRectMake(foodsViewX, foodsViewY, foodsViewW, foodsViewH);
        
        CGFloat foodsPlayViewButtonX = TacticTableViewCellMargin;
        CGFloat foodsPlayViewButtonY = descLabelBottom + TacticTableViewCellTextMargin;
        CGFloat foodsPlayViewButtonW = foodsViewW - TacticTableViewCellMargin * 2;
        CGFloat foodsPlayViewButtonH = (KSCREEN_W - 10 * 6) / 3.0;
        self.foodsPlayViewButtonF = CGRectMake(foodsPlayViewButtonX, foodsPlayViewButtonY, foodsPlayViewButtonW, foodsPlayViewButtonH);
        
    }else{
        self.foodsViewF = CGRectMake(foodsViewX, foodsViewY, foodsViewW, noContentHeight);
    }
    
    XXX = CGRectGetMaxY(self.foodsViewF);
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
