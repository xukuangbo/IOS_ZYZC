//
//  ZCPersonInfoController.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/3/17.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#define KGET_DETAIL_PRODUCT(openid,productId)  [NSString stringWithFormat:@"%@openid=%@&productId=%@",GETPRODUCTDETAIL,openid,productId]

#define BGIMAGEHEIGHT  200*KCOFFICIEMNT
#define BLURHEIGHT     44

#import "ZCPersonInfoController.h"

#import "ZCDetailFirstCell.h"
#import "ZCDetailTableHeadView.h"
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

#import "FXBlurView.h"

#import "ZCDetailModel.h"
#import "ZCCommentViewController.h"
#import "MBProgressHUD+MJ.h"
#import "WXApiShare.h"

@interface ZCPersonInfoController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView           *table;
@property (nonatomic, strong) UIImageView           *topImgView;
@property (nonatomic, strong) UIColor               *navColor;
@property (nonatomic, strong) FXBlurView            *blurView;
@property (nonatomic, strong) UIButton              *shareBtn;
@property (nonatomic, strong) UIButton              *collectionBtn;
@property (nonatomic, strong) UILabel               *travelThemeLab;
@property (nonatomic, strong) ZCDetailTableHeadView *headView;

@property (nonatomic, assign) ZCDetailContentType   contentType;

@property (nonatomic, strong) ZCDetailModel         *detailModel;

@property (nonatomic, strong) ZCDetailProductModel * introFirstCellMdel;
@property (nonatomic, strong) NSMutableArray *detailDays;//行程安排数组

@property (nonatomic, strong) ZCDetailReturnFirstCellModel *returnFirstCellModel;

@property (nonatomic, strong) NSMutableArray *favoriteTravel;//猜你喜欢的旅游

@property (nonatomic, assign) BOOL hasCosponsor;//联合发起人
@property (nonatomic, assign) BOOL hasIntroGoal;//众筹目的
@property (nonatomic, assign) BOOL hasIntroGeneral;//目的地介绍
@property (nonatomic, assign) BOOL hasIntroMovie;//动画攻略
@property (nonatomic, assign) BOOL hasHotComment;//热门评论
@property (nonatomic, assign) BOOL hasInterestTravel;//兴趣标签匹配的旅游
@property (nonatomic, assign) BOOL getCollection;
@end

@implementation ZCPersonInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor ZYZC_BgGrayColor];
    _navColor=[UIColor ZYZC_NavColor];
     [self.navigationController.navigationBar cnSetBackgroundColor:[_navColor colorWithAlphaComponent:0]];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    self.navigationController.navigationBar.titleTextAttributes=
    @{NSForegroundColorAttributeName:[UIColor whiteColor],
      NSFontAttributeName:[UIFont boldSystemFontOfSize:18]};

    self.oneModel.zcType=DetailType;
    [self initData];
    [self getHttpData];
    [self setBackItem];
    [self configUI];
    [self createBottomView];

}

#pragma mark --- 返回控制器
-(void)pressBack
{
    [super pressBack];
    self.oneModel.zcType=AllList;
    [_shareBtn removeFromSuperview];
    [_collectionBtn removeFromSuperview];
    self.navigationController.navigationBar.titleTextAttributes=
    @{NSForegroundColorAttributeName:[UIColor whiteColor],
      NSFontAttributeName:[UIFont boldSystemFontOfSize:20]};
}

#pragma mark --- 初始化数据
-(void)initData
{
    _returnFirstCellModel= [[ZCDetailReturnFirstCellModel alloc]init];
    _detailDays=[NSMutableArray array];
    _favoriteTravel=[NSMutableArray array];
    self.contentType= IntroType;//展示介绍部分
    _hasCosponsor   = NO;//添加联和发起人项
    _hasIntroGoal   = NO;//添加众筹目的
    _hasIntroGeneral= NO;//添加目的地介绍
    _hasIntroMovie  = NO;//添加动画攻略
    _hasHotComment  = NO;//添加热门评论
    _hasInterestTravel=YES;//添加兴趣标签匹配的旅游

}

#pragma mark --- 获取数据
-(void)getHttpData
{
//    _productId=@154;
    NSLog(@"%@,%@",[ZYZCTool getUserId],_productId);
    NSString *urlStr=KGET_DETAIL_PRODUCT([ZYZCTool getUserId],_productId);
    NSLog(@"%@",urlStr);
    [ZYZCHTTPTool getHttpDataByURL:KGET_DETAIL_PRODUCT([ZYZCTool getUserId], _productId) withSuccessGetBlock:^(id result, BOOL isSuccess) {
        NSLog(@"%@",result);
        if (isSuccess) {
            _detailModel=[[ZCDetailModel alloc]mj_setKeyValues:result];
            _introFirstCellMdel=_detailModel.detailProductModel;
            NSArray *detailDays=_detailModel.detailProductModel.schedule;
            for (NSString *jsonStr in detailDays) {
                NSDictionary *dict=[ZYZCTool turnJsonStrToDictionary:jsonStr];
                MoreFZCTravelOneDayDetailMdel *oneSchedule=[MoreFZCTravelOneDayDetailMdel mj_objectWithKeyValues:dict];
                [_detailDays addObject:oneSchedule];
            }
            _hasIntroGoal=YES;
             _getCollection=[_detailModel.detailProductModel.Friend isEqual:@0];
            [_collectionBtn setImage: _getCollection?[UIImage imageNamed:@"icon_collection"]:[UIImage imageNamed:@"icon_collection_pre"] forState:UIControlStateNormal];
            [_table reloadData];
        }
    } andFailBlock:^(id failResult) {
        NSLog(@"%@",failResult);
    }];
}

#pragma mark --- 创建控件
-(void)configUI
{
    _table=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_W, KSCREEN_H-KTABBAR_HEIGHT) style:UITableViewStylePlain];
    _table.dataSource=self;
    _table.delegate=self;
    _table.showsVerticalScrollIndicator=NO;
    _table.contentInset=UIEdgeInsetsMake(BGIMAGEHEIGHT-64, 0, 0, 0);
    _table.tableFooterView=[[UIView alloc]init];
    _table.backgroundColor=[UIColor ZYZC_BgGrayColor];
    _table.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_table];
    
    _topImgView=[[UIImageView alloc]initWithFrame:CGRectMake(0, -BGIMAGEHEIGHT,KSCREEN_W, BGIMAGEHEIGHT)];
    _topImgView.contentMode=UIViewContentModeScaleAspectFill;
    _topImgView.layer.masksToBounds=YES;
    [_topImgView sd_setImageWithURL:[NSURL URLWithString:_oneModel.product.headImage ] placeholderImage:[UIImage imageNamed:@"abc"]];
    [_table addSubview:_topImgView];
    
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
    
    //添加渐变条
    UIImageView *bgImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_W, 64)];
    bgImg.image=[UIImage imageNamed:@"Background"];
    [_topImgView addSubview:bgImg];
    
    //创建旅行主题标签
    _travelThemeLab=[[UILabel alloc]initWithFrame:CGRectMake(2*KEDGE_DISTANCE, 5, KSCREEN_W, 30)];
    _travelThemeLab.font=[UIFont boldSystemFontOfSize:20];
    _travelThemeLab.text=_oneModel.product.productName;
    _travelThemeLab.shadowOffset=CGSizeMake(1 , 1);
    _travelThemeLab.shadowColor=[UIColor ZYZC_TextBlackColor];
    _travelThemeLab.textColor=[UIColor whiteColor];
    [_blurView addSubview:_travelThemeLab];
    
    //导航栏添加分享
    _shareBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _shareBtn.frame=CGRectMake(KSCREEN_W-40, 0, 40, 44);
    [_shareBtn setImage:[UIImage imageNamed:@"icon_share"] forState:UIControlStateNormal];
    [_shareBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventAllEvents];
    [self.navigationController.navigationBar addSubview:_shareBtn];
    //导航栏添加收藏
    _collectionBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    _collectionBtn.frame=CGRectMake(_shareBtn.left-40, 0, 40, 44);
    [_collectionBtn setImage:[UIImage imageNamed:@"icon_collection"] forState:UIControlStateNormal];
    [_collectionBtn addTarget:self  action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:_collectionBtn];
}


#pragma mark --- tableView代理方法
-(NSInteger )numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger days=_detailDays.count;
    //第二组的cell数量
    NSInteger secondSectionCellNumber=
    (2*_hasIntroGoal+2*_hasIntroGeneral+2*_hasIntroMovie)*(self.contentType==IntroType?1:0)
    +2*days*(self.contentType==ArrangeType?1:0)
    +(2*_hasHotComment+2*_hasInterestTravel*(1+4))*(self.contentType==ReturnType?1:0);
    
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
             ZCOneProductCell *productCell=(ZCOneProductCell *)[self customTableView:tableView cellWithIdentifier:cellId01 andCellClass:[ZCOneProductCell class]];
            productCell.oneModel=_oneModel;
            return productCell;
        }
        //联和发起人
        else if (indexPath.row == 1+_hasCosponsor*2&&indexPath.row!=1)
        {
            NSString *cellId02=@"detailFirstCell";
            ZCDetailFirstCell *detailFirstCell=(ZCDetailFirstCell *)[self customTableView:tableView cellWithIdentifier:cellId02 andCellClass:[ZCDetailFirstCell class]];
            return detailFirstCell;
        }
        else
        {
            UITableViewCell *cell=[self createNormalCell];
            return cell;
        }
    }
    //第二组内容 indexPath.section==1
    else
    {
        ////查看介绍内容
        if (self.contentType==IntroType) {
            if(indexPath.row==0 && _hasIntroGoal)
            {
                NSString *introFirstCellId=@"introFirstCell";
                ZCDetailIntroFirstCell *introFirstCell=(ZCDetailIntroFirstCell *)[self customTableView:tableView cellWithIdentifier:introFirstCellId andCellClass:[ZCDetailIntroFirstCell class]];
                introFirstCell.layer.cornerRadius=KCORNERRADIUS;
                introFirstCell.cellModel=_introFirstCellMdel;
                return introFirstCell;
            }
            else if (indexPath.row == 0+2*_hasIntroGoal && _hasIntroGeneral)
            {
                NSString *introSecondCellId=@"introSecondCell";
                ZCDetailIntroSecondCell *introSecondCell=(ZCDetailIntroSecondCell *)[self customTableView:tableView cellWithIdentifier:introSecondCellId andCellClass:[ZCDetailIntroSecondCell class]];
                introSecondCell.goals=@[@"普吉岛",@"清迈",@"烧麦"];
                return introSecondCell;
            }
            else if (indexPath.row == 0 +2*_hasIntroGoal +2*_hasIntroGeneral && _hasIntroMovie)
            {
                NSString *introThirdCellId=@"introThirdCell";
                ZCDetailIntroThirdCell *introThirdCell=(ZCDetailIntroThirdCell *)[self customTableView:tableView cellWithIdentifier:introThirdCellId andCellClass:[ZCDetailIntroThirdCell class]];
                return introThirdCell;
                
            }
            else
            {
                UITableViewCell *cell=[self createNormalCell];
                return cell;
            }
        }
        //查看行程内容
        else if (self.contentType == ArrangeType)
        {
            if (indexPath.row%2==0) {
                NSString *arrangeCellId=[NSString stringWithFormat:@"arrangeCell%zd",indexPath.row/2];
                ZCDetailArrangeFirstCell *arrangeCell=(ZCDetailArrangeFirstCell *)[self customTableView:tableView cellWithIdentifier:arrangeCellId andCellClass:[ZCDetailArrangeFirstCell class]];
                arrangeCell.faceImg=_oneModel.user.faceImg;
                arrangeCell.oneDaydetailModel=_detailDays[indexPath.row/2];
                return arrangeCell;
            }
            else{
                UITableViewCell *cell=[self createNormalCell];
                return cell;
            }
        }
        //查看回报内容
        else
        {
            if (indexPath.row==0) {
                NSString *returnFirstCellId=@"returnFirstCell";
                ZCDetailReturnFirstCell *returnFirstCell=(ZCDetailReturnFirstCell *)[self customTableView:tableView cellWithIdentifier:returnFirstCellId andCellClass:[ZCDetailReturnFirstCell class]];
                returnFirstCell.cellModel=_returnFirstCellModel;
                return returnFirstCell;
            }
            else if (indexPath.row==2*_hasHotComment &&indexPath.row !=0)
            {
                NSString *returnSecondCellId=@"returnSecondCell";
                ZCDetailReturnSecondCell *returnSecondCell=(ZCDetailReturnSecondCell *)[self customTableView:tableView cellWithIdentifier:returnSecondCellId andCellClass:[ZCDetailReturnSecondCell class]];
                returnSecondCell.contentView.backgroundColor=[UIColor greenColor];
                return returnSecondCell;
            }
            else if (indexPath.row ==2*_hasHotComment+2*_hasInterestTravel &&indexPath.row!=0)
            {
                NSString *returnThirdCellId=@"returnThirdCell";
                ZCDetailReturnThridCell *returnThirdCell=(ZCDetailReturnThridCell *)[self customTableView:tableView cellWithIdentifier:returnThirdCellId andCellClass:[ZCDetailReturnThridCell class]];
                 returnThirdCell.contentView.backgroundColor=[UIColor greenColor];
                return returnThirdCell;
            }
            else if (indexPath.row ==2*_hasHotComment +2*(1+(indexPath.row-2)/2)*_hasInterestTravel &&indexPath.row!=0)
            {
                NSString *returnFourthCellId=@"returnFourthCell";
                ZCDetailReturnFourthCell *returnFourthCell=(ZCDetailReturnFourthCell *)[self customTableView:tableView cellWithIdentifier:returnFourthCellId andCellClass:[ZCDetailReturnFourthCell class]];
                 returnFourthCell.contentView.backgroundColor=[UIColor yellowColor];
                return returnFourthCell;
            }
            
            UITableViewCell *cell=[self createNormalCell];
            return cell;
        }
    }
}

#pragma mark --- 创建自定义cell
-(UITableViewCell *)customTableView:(UITableView *)tableView cellWithIdentifier:(NSString *)cellId andCellClass:(id)cellClass
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell=[[cellClass alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    return cell;
}

#pragma mark --- 创建普通cell
-(UITableViewCell *)createNormalCell
{
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.contentView.backgroundColor=[UIColor ZYZC_BgGrayColor];
    return cell;
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
                return _introFirstCellMdel.introFirstCellHeight;
            }
            else if (indexPath.row == 0+2*_hasIntroGoal && _hasIntroGeneral)
            {
                return ZCDETAILINTRO_SECONDCELL_HEIGHT;
            }
            else if (indexPath.row == 0+2*_hasIntroGoal +2*_hasIntroGeneral && _hasIntroMovie)
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
            if (indexPath.row ==0) {
                return _returnFirstCellModel.cellHeight;
            }
            else if (indexPath.row==2*_hasHotComment &&indexPath.row !=0)
            {
                return 100;
            }
            else if (indexPath.row ==2*_hasHotComment+2*_hasInterestTravel &&indexPath.row!=0)
            {
                return 100;
            }
            else if (indexPath.row ==2*_hasHotComment +2*(1+(indexPath.row-2)/2)*_hasInterestTravel &&indexPath.row!=0)
            {
                return 100;
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
                CGPoint offSet=weakSelf.table.contentOffset;
                if (offSet.y>offSetY) {
                    changeOffSet=YES;
                }
                [weakSelf.table reloadData];
                if (changeOffSet) {
                    weakSelf.table.contentOffset=CGPointMake(0, offSetY);
                }
                else
                {
                    weakSelf.table.contentOffset=offSet;
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

#pragma mark --- tableView的滑动效果
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    //图片拉伸效果
    if (scrollView==self.table) {
        CGFloat offsetY = scrollView.contentOffset.y;
        if (offsetY <= -BGIMAGEHEIGHT)
        {
            CGRect frame = _topImgView.frame;
            frame.origin.y = offsetY;
            frame.size.height = -offsetY;
            _topImgView.frame = frame;
            _blurView.top=_topImgView.height-BLURHEIGHT;
        }
        
        //导航栏颜色渐变
        CGFloat height=BGIMAGEHEIGHT;
        if (offsetY >= -height) {
            CGFloat alpha = MIN(1, (height + offsetY)/height);
            [self.navigationController.navigationBar cnSetBackgroundColor:[_navColor colorWithAlphaComponent:alpha]];
        } else {
            [self.navigationController.navigationBar cnSetBackgroundColor:[_navColor colorWithAlphaComponent:0]];
        }
        
        //设置导航栏title
        if ((height + offsetY)/height>=1) {
            scrollView.contentInset=UIEdgeInsetsMake(64, 0, 0, 0);
             self.title= _travelThemeLab.text;
            if (_travelThemeLab.text.length>8) {
                self.title=[NSString stringWithFormat:@"%@...",[_travelThemeLab.text substringToIndex:7]];
            }
        }
        else
        {
            self.title=nil;
            scrollView.contentInset=UIEdgeInsetsMake(BGIMAGEHEIGHT, 0, 0, 0);
        }
    }
}

#pragma mark --- 创建底部点击按钮
-(void)createBottomView
{
    UIView *bottomView=[[UIView alloc]initWithFrame:CGRectMake(0, KSCREEN_H-KTABBAR_HEIGHT , KSCREEN_W, KTABBAR_HEIGHT)];
    bottomView.backgroundColor=[UIColor ZYZC_TabBarGrayColor];
    [self.view addSubview:bottomView];
    
    [bottomView addSubview:[UIView lineViewWithFrame:CGRectMake(0, 0, KSCREEN_W, 0.5) andColor:[UIColor lightGrayColor]]];
    
    NSArray *titleArr=@[@"评论",@"支持",@"推荐"];
    CGFloat btn_width=KSCREEN_W/3;
    for (int i=0; i<3; i++) {
        UIButton *sureBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        sureBtn.frame=CGRectMake(btn_width*i, KTABBAR_HEIGHT/2-20, btn_width, 40);
        [sureBtn setTitle:titleArr[i] forState:UIControlStateNormal];
        [sureBtn setTitleColor:[UIColor ZYZC_TextGrayColor] forState:UIControlStateNormal];
        sureBtn.titleLabel.font=[UIFont systemFontOfSize:20];
        sureBtn.layer.cornerRadius=KCORNERRADIUS;
        sureBtn.layer.masksToBounds=YES;
        [sureBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        sureBtn.tag=KZCDETAIL_ATTITUDETYPE+i;
        if (sureBtn.tag!=KZCDETAIL_ATTITUDETYPE) {
             [sureBtn addSubview:[UIView lineViewWithFrame:CGRectMake(0, 7, 1, sureBtn.height-2*7) andColor:[UIColor ZYZC_TextGrayColor]]];
        }
        [bottomView addSubview:sureBtn];
    }
}

#pragma mark --- 底部按钮点击事件
-(void)clickBtn:(UIButton *)sender
{
    switch (sender.tag) {
        case CommentType:
            [self comment];
            //评论
            break;
        case SupportType:
            [self support];
            //支持
            break;
        case RecommendType:
            //推荐
            break;
        default:
            break;
    }
    
    if (sender==_shareBtn) {
        //分享
        [self share];
    }
    if (sender==_collectionBtn) {
        //收藏
        [self collection];
    }
}

#pragma mark --- 分享
-(void)share
{
    __weak typeof (&*self)weakSelf=self;
    __block NSString *url=[NSString stringWithFormat:@"http://www.sosona.com/pay/crowdfundingDetail?pid=%@",_productId];

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    alertController.view.tintColor=[UIColor ZYZC_MainColor];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *shareToZoneAction = [UIAlertAction actionWithTitle:@"分享到微信朋友圈" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
    {
        NSLog(@"%@",weakSelf.oneModel.product.productName);
        [WXApiShare shareScene:YES withTitle:@"众游" andDesc:weakSelf.oneModel.product.productName andThumbImage:nil andWebUrl:url];
    }];
    
    UIAlertAction *shareToFriendAction = [UIAlertAction actionWithTitle:@"分享到微信好友" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
    {
        [WXApiShare shareScene:NO withTitle:@"众游" andDesc:weakSelf.oneModel.product.productName andThumbImage:nil andWebUrl:url];
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:shareToZoneAction];
    [alertController addAction:shareToFriendAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark --- 收藏/取消收藏
-(void)collection
{
    
    NSDictionary *parameters=@{@"openid":[ZYZCTool getUserId],@"friendsId":_productId};
    NSString *url=_getCollection?FOLLOWPRODUCT:UNFOLLOWPRODUCT;
    
    [ZYZCHTTPTool postHttpDataWithEncrypt:YES andURL:url andParameters:parameters andSuccessGetBlock:^(id result, BOOL isSuccess) {
        _getCollection?[MBProgressHUD showSuccess:ZYLocalizedString(@"collection_success")]:[MBProgressHUD showSuccess:ZYLocalizedString(@"collection_fail")];
        [_collectionBtn setImage:_getCollection?[UIImage imageNamed:@"icon_collection_pre"]:[UIImage imageNamed:@"icon_collection"] forState:UIControlStateNormal];
        _getCollection=!_getCollection;
        
    } andFailBlock:^(id failResult) {
        NSLog(@"%@",failResult);
    }];
}

#pragma mark --- 评论
-(void)comment
{
    ZCCommentViewController *commentVC=[[ZCCommentViewController alloc]init];
    commentVC.productId=_oneModel.product.productId;
    commentVC.user=_oneModel.user;
    commentVC.title=@"评论";
    [self.navigationController pushViewController:commentVC animated:YES];
    
}
#pragma mark --- 支持
-(void)support
{
    UIButton *supportBtn=(UIButton *)[_headView viewWithTag:ReturnType];
    [_headView getContent:supportBtn];
    [_table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar cnSetBackgroundColor:[UIColor ZYZC_NavColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
