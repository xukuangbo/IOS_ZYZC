//
//  ZCProductDetailTableView.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/6/9.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "ZCProductDetailTableView.h"

#import "FXBlurView.h"
#import "ZCDetailFirstCell.h"
//介绍部分cells
#import "ZCDetailIntroFirstCell.h"
#import "ZCDetailIntroSecondCell.h"
#import "ZCDetailIntroThirdCell.h"
//行程部分cells
#import "ZCDetailArrangeFirstCell.h"
//回报部分cells
#import "ZCDetailReturnFirstCell.h"
#import "ZCDetailReturnSecondCell.h"
#import "ZCDetailReturnThridCell.h"
#import "ZCDetailReturnFourthCell.h"

#import "ZCCommentModel.h"
#import "ZCCommentViewController.h"
#import "ZYZCDataBase.h"


@interface ZCProductDetailTableView ()
@property (nonatomic, strong) FXBlurView            *blurView;     //毛玻璃
@property (nonatomic, strong) UILabel               *travelThemeLab;//主题名

@property (nonatomic, strong) ZCCommentList         *commentList;
@property (nonatomic, assign) ZCDetailContentType   contentType;

@property (nonatomic, assign) BOOL hasCosponsor;//标记是否有联合发起人
@property (nonatomic, assign) BOOL hasIntroGoal;//标记是否有众筹目的
@property (nonatomic, assign) BOOL hasIntroGeneral;//标记是否有目的地介绍
@property (nonatomic, assign) BOOL hasIntroMovie;//标记是否有动画攻略
@property (nonatomic, assign) BOOL hasSupportView;//标记是否有支持界面
@property (nonatomic, assign) BOOL hasHotComment;//标记是否有热门评论
@property (nonatomic, assign) BOOL hasInterestTravel;//标记是否有兴趣标签匹配的旅游

@end

@implementation ZCProductDetailTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self=[super initWithFrame:frame style:style]) {
        self.mj_header=nil;
        self.mj_footer=nil;
        _contentType=IntroType;
        _commentArr =[NSMutableArray array];
         self.contentInset=UIEdgeInsetsMake(BGIMAGEHEIGHT-64, 0, 0, 0);
        _topImgView=[[UIImageView alloc]initWithFrame:CGRectMake(0, -BGIMAGEHEIGHT,KSCREEN_W, BGIMAGEHEIGHT)];
        _topImgView.image=[UIImage imageNamed:@"image_placeholder"];
        _topImgView.contentMode=UIViewContentModeScaleAspectFill;
        _topImgView.layer.masksToBounds=YES;
        [self addSubview:_topImgView];
        
        //创建毛玻璃添加到顶部图片上
        _blurView = [[FXBlurView alloc] initWithFrame:CGRectMake(0, BGIMAGEHEIGHT-BLURHEIGHT, KSCREEN_W, BLURHEIGHT)];
        [_blurView setDynamic:YES];
        _blurView.alpha=0.9;
        [_topImgView addSubview:_blurView];
        //给毛玻璃润色
        UIView *blackView=[[UIView alloc]initWithFrame:_blurView.bounds];
        blackView.backgroundColor=[UIColor blackColor];
        blackView.alpha=0.3;
        [_blurView addSubview:blackView];
        
        //创建旅行主题标签
        _travelThemeLab=[[UILabel alloc]initWithFrame:CGRectMake(2*KEDGE_DISTANCE, 5, KSCREEN_W, 30)];
        _travelThemeLab.font=[UIFont boldSystemFontOfSize:20];
        _travelThemeLab.shadowOffset=CGSizeMake(1 , 1);
        _travelThemeLab.shadowColor=[UIColor ZYZC_TextBlackColor];
        _travelThemeLab.textColor=[UIColor whiteColor];
        [_blurView addSubview:_travelThemeLab];
        
        //添加banner
        UIImageView *bgImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_W, 64)];
        bgImg.image=[UIImage imageNamed:@"Background"];
        [_topImgView addSubview:bgImg];
    }
    return self;
}

-(void)setOneModel:(ZCOneModel *)oneModel
{
    _oneModel=oneModel;
    _travelThemeLab.text=oneModel.product.productName;
    [self reloadData];
}

-(void)setDetailModel:(ZCDetailModel *)detailModel
{
    _detailModel=detailModel;
    _hasIntroGoal=YES;
    _hasSupportView=YES;
    _hasInterestTravel=NO;
    [self reloadData];
}

-(void)setDetailDays:(NSArray *)detailDays
{
    _detailDays=detailDays;
}

#pragma mark --- 获取目的地及对应视屏
-(void)setProductDest:(NSString *)productDest
{
    _productDest=productDest;
    if (productDest.length) {
        NSArray *destArr=[ZYZCTool turnJsonStrToArray:productDest];
        //如果目的地是地名库中的目的地，则保存下来
        ZYZCDataBase *dataBase=[ZYZCDataBase sharedDBManager];
        _viewSpots=[NSMutableArray array];
        for (NSString *dest in destArr) {
            OneSpotModel *oneSportModel=[dataBase searchOneDataWithName:dest];
            if (oneSportModel) {
                [_viewSpots addObject:oneSportModel];
            }
        }
        //如果有地名库中的数据，获取目的地视屏
        if (_viewSpots.count) {
            _hasIntroGeneral=YES;
            // 获取景点视屏
            _spotVideos=[NSMutableArray array];
            for(OneSpotModel *oneSportModel in _viewSpots){
                NSNumber *viewId=oneSportModel.ID;
                [ZYZCHTTPTool getHttpDataByURL:[NSString stringWithFormat:@"%@viewId=%@",GET_SPOT_VIDEO,viewId] withSuccessGetBlock:^(id result, BOOL isSuccess)
                 {
                     if (isSuccess) {
                         ZCSpotVideoModel *spotVideo=[[ZCSpotVideoModel alloc]mj_setKeyValues:result[@"data"]];
                         if (spotVideo.videoUrl.length) {
                             spotVideo.spotName=oneSportModel.name;
                             [_spotVideos addObject:spotVideo];
                         } ;
                         if (_spotVideos.count) {
                             _hasIntroMovie=YES;
                             [self reloadData];
                         }
                     }
                 }
                andFailBlock:^(id failResult)
                 {
                 }];
            }
        }
    }
}

-(NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger days=_detailDays.count;
    //第二组的cell数量
    NSInteger secondSectionCellNumber=
    (2*_hasIntroGoal+2*_hasIntroGeneral+2*_hasIntroMovie*_spotVideos.count)*(self.contentType==IntroType?1:0)
    +2*days*(self.contentType==ArrangeType?1:0)
    +_hasSupportView*(2*_hasSupportView+2*_hasHotComment)*(self.contentType==ReturnType?1:0);
    
    if (section==0) {
        return 2 + 2*_hasCosponsor;
    }
    else
    {
        return  secondSectionCellNumber ;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        //个人信息展示
        if(indexPath.row==1)
        {
            NSString *cellId01=@"cellId01";
            ZYZCOneProductCell *productCell=(ZYZCOneProductCell *)[ZYZCOneProductCell customTableView:tableView cellWithIdentifier:cellId01 andCellClass:[ZYZCOneProductCell class]];
            productCell.productType=ZCDetailProduct;
            productCell.oneModel=_oneModel;
            return productCell;
        }
        //联和发起人(暂时没有)
        else if (indexPath.row == 1+_hasCosponsor*2&&indexPath.row!=1)
        {
            NSString *cellId02=@"detailFirstCell";
            ZCDetailFirstCell *detailFirstCell=(ZCDetailFirstCell *)[ZYZCBaseTableViewCell customTableView:tableView cellWithIdentifier:cellId02 andCellClass:[ZCDetailFirstCell class]];
            return detailFirstCell;
        }
        else
        {
            UITableViewCell *cell=[ZYZCBaseTableViewCell createNormalCell];
            return cell;
        }
    }
    //第二组内容 indexPath.section==1
    else if (indexPath.section==1)
    {
        ////查看介绍内容
        if (self.contentType==IntroType) {
            if(indexPath.row==0 && _hasIntroGoal)
            {
                NSString *introFirstCellId=@"introFirstCell";
                ZCDetailIntroFirstCell *introFirstCell=(ZCDetailIntroFirstCell *)[ZYZCBaseTableViewCell customTableView:tableView cellWithIdentifier:introFirstCellId andCellClass:[ZCDetailIntroFirstCell class]];
                introFirstCell.cellModel=_detailModel.detailProductModel;
                return  introFirstCell;
            }
            else if (indexPath.row == 0+2*_hasIntroGoal && _hasIntroGeneral)
            {
                NSString *introSecondCellId=@"introSecondCell";
                ZCDetailIntroSecondCell *introSecondCell=(ZCDetailIntroSecondCell *)[ZYZCBaseTableViewCell customTableView:tableView cellWithIdentifier:introSecondCellId andCellClass:[ZCDetailIntroSecondCell class]];
                introSecondCell.goals=_viewSpots;
                return introSecondCell;
            }
            else if (indexPath.row >=2*_hasIntroGoal +2*_hasIntroGeneral &&indexPath.row <=2*_hasIntroGoal +2*_hasIntroGeneral+2*_hasIntroMovie*_spotVideos.count&&(indexPath.row-(2*_hasIntroGoal +2*_hasIntroGeneral))%2==0&& _hasIntroMovie)
            {
                NSString *introThirdCellId=@"introThirdCell";
                ZCDetailIntroThirdCell *introThirdCell=(ZCDetailIntroThirdCell *)[ZYZCBaseTableViewCell customTableView:tableView cellWithIdentifier:introThirdCellId andCellClass:[ZCDetailIntroThirdCell class]];
                ZCSpotVideoModel *spotVideoModel=_spotVideos[(indexPath.row-2*_hasIntroGoal -2*_hasIntroGeneral)/2];
                introThirdCell.spotVideoModel=spotVideoModel;
                introThirdCell.subDesLab.text=SUBDES_FORMOVIE(spotVideoModel.spotName);
                return introThirdCell;
                
            }
            else
            {
                UITableViewCell *cell=[ZYZCBaseTableViewCell createNormalCell];
                return cell;
            }
        }
        //查看行程内容
        else if (self.contentType == ArrangeType)
        {
            if (indexPath.row%2==0) {
                NSString *arrangeCellId=[NSString stringWithFormat:@"arrangeCell%zd",indexPath.row/2];
                ZCDetailArrangeFirstCell *arrangeCell=(ZCDetailArrangeFirstCell *)[ZYZCBaseTableViewCell customTableView:tableView cellWithIdentifier:arrangeCellId andCellClass:[ZCDetailArrangeFirstCell class]];
                arrangeCell.faceImg=_oneModel.user.faceImg;
                arrangeCell.oneDaydetailModel=_detailDays[indexPath.row/2];
                return arrangeCell;
            }
            else{
                UITableViewCell *cell=[ZYZCBaseTableViewCell createNormalCell];
                return cell;
            }
        }
        //查看回报内容
        else
        {
            if (indexPath.row==0&&_hasSupportView) {
                NSString *returnFirstCellId=@"returnFirstCell";
                ZCDetailReturnFirstCell *returnFirstCell=(ZCDetailReturnFirstCell *)[ZYZCBaseTableViewCell customTableView:tableView cellWithIdentifier:returnFirstCellId andCellClass:[ZCDetailReturnFirstCell class]];
                returnFirstCell.cellModel=_detailModel.detailProductModel;
                return returnFirstCell;
            }
            else if (indexPath.row==2*_hasHotComment &&indexPath.row !=0)
            {
                NSString *returnSecondCellId=@"returnSecondCell";
                ZCDetailReturnSecondCell *returnSecondCell=(ZCDetailReturnSecondCell *)[ZYZCBaseTableViewCell customTableView:tableView cellWithIdentifier:returnSecondCellId andCellClass:[ZCDetailReturnSecondCell class]];
                returnSecondCell.commentModel=_commentArr.lastObject;
                return returnSecondCell;
            }
            UITableViewCell *cell=[ZYZCBaseTableViewCell createNormalCell];
            return cell;
        }
    }
    
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        
        if (indexPath.row ==1)
        {
            return PRODUCT_DETAIL_CELL_HEIGHT;
        }
        else if (indexPath.row==1+_hasCosponsor*2&&indexPath.row!=1)
        {
            return ZCDETAIL_FIRSTCELL_HEIGHT;
        }
        else
        {
            return KEDGE_DISTANCE;
        }
    }
    else
    {
        //介绍部分cells高度
        if (self.contentType == IntroType) {
            if (indexPath.row==0 && _hasIntroGoal) {
                return _detailModel.detailProductModel.introFirstCellHeight;
            }
            else if (indexPath.row == 0+2*_hasIntroGoal && _hasIntroGeneral)
            {
                return ZCDETAILINTRO_SECONDCELL_HEIGHT;
            }
            else if (_hasIntroMovie&&indexPath.row >=2*_hasIntroGoal +2*_hasIntroGeneral &&indexPath.row <=2*_hasIntroGoal +2*_hasIntroGeneral+2*_hasIntroMovie*_spotVideos.count&&(indexPath.row-(2*_hasIntroGoal +2*_hasIntroGeneral))%2==0)
            {
                return ZCDETAILINTRO_THIRDCELL_HEIGHT;
            }
            else
            {
                return KEDGE_DISTANCE;
            }
        }
        //行程部分cells高度
        else if (self.contentType == ArrangeType)
        {
            if (indexPath.row%2==0) {
                MoreFZCTravelOneDayDetailMdel *oneDetailModel=_detailDays[indexPath.row/2];
                return oneDetailModel.cellHeight;
            }
            else{
                return KEDGE_DISTANCE;
            }
        }
        //回报部分cells高度
        else
        {
            if (indexPath.row ==0&&_hasSupportView) {
                return _detailModel.detailProductModel.returnFirtCellHeight;
            }
            else if (indexPath.row==2*_hasHotComment &&indexPath.row !=0)
            {
                ZCCommentModel *commentModel=_commentArr.lastObject;
                return commentModel.cellHeight;
            }
            return KEDGE_DISTANCE;
        }
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==1) {
        if(!_headView){
            _headView=[[ZCDetailTableHeadView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_W,ZCDETAIL_SECONDSECTION_HEIGHT)];
        };
        __weak typeof (&*self)weakSelf=self;
        _headView.clickChangeContent=^(ZCDetailContentType contentType)
        {
            
            if (weakSelf.contentType!=contentType) {
                weakSelf.contentType=contentType;
                BOOL changeOffSet=NO;
                CGFloat offSetY=210+2*KEDGE_DISTANCE+_hasCosponsor*ZCDETAIL_FIRSTCELL_HEIGHT-64;
                CGPoint offSet=weakSelf.contentOffset;
                if (offSet.y>offSetY) {
                    changeOffSet=YES;
                }
                if(contentType==ReturnType&&weakSelf.productId)
                {
                    [weakSelf getHotComment];
                }
                [weakSelf reloadData];
                
                if (changeOffSet) {
                    weakSelf.contentOffset=CGPointMake(0, offSetY);
                }
                else
                {
                    weakSelf.contentOffset=offSet;
                }
            }
        };
        
        return _headView;
    }
    return nil;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==1) {
        return ZCDETAIL_SECONDSECTION_HEIGHT;
    }
    return 0.0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1&&self.contentType==ReturnType) {
        if (indexPath.row==2) {
            ZCCommentViewController *commentVC=[[ZCCommentViewController alloc]init];
            commentVC.productId=_oneModel.product.productId;
            commentVC.user=_oneModel.user;
            commentVC.title=@"评论";
            [self.viewController.navigationController pushViewController:commentVC animated:YES];
        }
    }
}

#pragma mark --- tableView的滑动
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //图片拉伸效果
     CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY <= -BGIMAGEHEIGHT)
    {
        CGRect frame = _topImgView.frame;
        frame.origin.y = offsetY;
        frame.size.height = -offsetY;
        _topImgView.frame = frame;
        _blurView.top=_topImgView.height-BLURHEIGHT;
    }
    //改变table的contentInset
    if (offsetY>-64) {
        self.contentInset=UIEdgeInsetsMake(64, 0, 0, 0);
    }
    else
    {
        self.contentInset=UIEdgeInsetsMake(BGIMAGEHEIGHT, 0, 0, 0);
    }

    if (self.scrollDidScrollBlock) {
        self.scrollDidScrollBlock(offsetY);
    }
}

#pragma mark --- 获取热门评论（目前只获取一个热门评论）
-(void)getHotComment
{
    NSDictionary  *parameters=@{@"openid":[ZYZCTool getUserId],
                                @"productId":_productId,
                                @"pageNO":@1,
                                @"pageSize":@1
                                };
    [ZYZCHTTPTool postHttpDataWithEncrypt:YES andURL:GET_COMMENT andParameters:parameters andSuccessGetBlock:^(id result, BOOL isSuccess) {
        [_commentArr removeAllObjects];
        if (isSuccess) {
            _commentList=[[ZCCommentList alloc]mj_setKeyValues:result];
            for(ZCCommentModel *commentModel in _commentList.commentList)
            {
                [_commentArr addObject:commentModel];
            }
            if (_commentArr.count) {
                _hasHotComment=YES;
                [self reloadData];
            }
        }
    } andFailBlock:^(id failResult) {

    }];
}



@end
