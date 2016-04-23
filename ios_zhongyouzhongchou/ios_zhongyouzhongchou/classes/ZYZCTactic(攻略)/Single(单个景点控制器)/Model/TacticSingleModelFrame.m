//
//  TacticSingleModelFrame.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/4/22.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "TacticSingleModelFrame.h"
#import "TacticSingleModel.h"
#import "UIView+TacticMapView.h"
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
        CGFloat flashViewH = oneViewHeight;
        self.flashViewF = CGRectMake(flashViewX, flashViewY, flashViewW, flashViewH);
        
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
        CGFloat pictureViewH = oneViewHeight;
        
        self.pictureViewF = CGRectMake(pictureViewX, pictureViewY, pictureViewW, pictureViewH);
        
        tipsViewY = CGRectGetMaxY(self.pictureViewF) + TacticTableViewCellMargin;
        
    }else{//无长图
        tipsViewY = CGRectGetMaxY(self.flashViewF);
        self.pictureViewF = CGRectMake(0, pictureViewY, 0, 0);
    }
    
    //众游小贴士
//    CGFloat must
    if(tacticSingleModel.tips){//有贴士
        CGFloat tipsViewX = TacticTableViewCellMargin;
        CGFloat tipsViewW = KSCREEN_W - TacticTableViewCellMargin * 2;
        CGFloat tipsViewH = oneViewHeight;
        
        self.tipsViewF = CGRectMake(tipsViewX, tipsViewY, tipsViewW, tipsViewH);
        
//        tipsViewY = CGRectGetMaxY(self.pictureViewF);
    }else{
        self.tipsViewF = CGRectMake(0, tipsViewY, 0, 0);
    }
    
    //必玩景点
    
}
@end
