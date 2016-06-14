//
//  ZCProductDetailController.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/6/9.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#define KGET_DETAIL_PRODUCT(openid,productId)  [NSString stringWithFormat:@"%@openid=%@&productId=%@",GETPRODUCTDETAIL,openid,productId]



#import "ZCProductDetailController.h"

#import "ZCDetailBottomView.h"

#import "ZCCommentViewController.h"
#import "MBProgressHUD+MJ.h"

#import "WXApiShare.h"

@interface ZCProductDetailController ()
@property (nonatomic, strong) ZCProductDetailTableView    *table;
@property (nonatomic, strong) UIColor               *navColor;
@property (nonatomic, strong) UIButton              *shareBtn;
@property (nonatomic, strong) UIButton              *collectionBtn;
@property (nonatomic, strong) ZCDetailBottomView    *bottomView;

@property (nonatomic, strong) NSMutableArray   *detailDays;  //行程安排数组

@property (nonatomic, strong) NSMutableArray   *favoriteTravel;//猜你喜欢的旅游

//@property (nonatomic, assign) BOOL  paySupportMoney;   //标记：跳转到支持／付款

@property (nonatomic, assign) BOOL getCollection;//添加收藏与否
@property (nonatomic, assign) BOOL viewDidappear;//标记界面是否出现

@end

@implementation ZCProductDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _navColor=[UIColor ZYZC_NavColor];
    self.navigationController.navigationBar.titleTextAttributes=
    @{NSForegroundColorAttributeName:[UIColor whiteColor],
      NSFontAttributeName:[UIFont boldSystemFontOfSize:18]};
    [self setBackItem];
    [self configUI];
    //如果不是本地草稿，获取数据
    if (_detailProductType!=DraftDetailProduct) {
        [self getHttpData];
    }
}

#pragma mark --- 返回控制器
-(void)pressBack
{
    [super pressBack];
    [_shareBtn removeFromSuperview];
    self.navigationController.navigationBar.titleTextAttributes=
    @{NSForegroundColorAttributeName:[UIColor whiteColor],
      NSFontAttributeName:[UIFont boldSystemFontOfSize:20]};
}

#pragma mark --- 初始化数据
-(void)initData
{
    //旅行目的地
    _detailDays  =[NSMutableArray arrayWithArray:_schedule];
    if (_detailProductType==DraftDetailProduct) {
        _table.detailDays=_detailDays;
        _table.detailModel=_detailModel;
    }
}

#pragma mark --- 创建控件
-(void)configUI
{
    //创建table
    _table=[[ZCProductDetailTableView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_W, KSCREEN_H-KTABBAR_HEIGHT) style:UITableViewStylePlain];
     [self.view addSubview:_table];
    _table.height=_detailProductType==DraftDetailProduct?KSCREEN_H-KEDGE_DISTANCE:KSCREEN_H-KTABBAR_HEIGHT;
    _table.productDest=_oneModel.product.productDest;
    _table.productId  =_productId;
    _table.oneModel   =_oneModel;
    [self scrollDidScroll];
    

    //如果是草稿，头部图片加载为本地
    if (_detailProductType==DraftDetailProduct) {
        if (_oneModel.product.headImage.length) {
            _table.topImgView.image=[UIImage imageWithContentsOfFile:_oneModel.product.headImage];
        }
    }
    else{
        [_table.topImgView sd_setImageWithURL:[NSURL URLWithString:_oneModel.product.headImage ] placeholderImage:[UIImage imageNamed:@"image_placeholder"]];
    }
    
    //除草稿外，项目添加分享，评论，收藏，支付操作
    if (_detailProductType!=DraftDetailProduct) {
        //导航栏添加分享
        _shareBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _shareBtn.frame=CGRectMake(KSCREEN_W-40, 0, 40, 44);
        [_shareBtn setImage:[UIImage imageNamed:@"icon_share"] forState:UIControlStateNormal];
        [_shareBtn addTarget:self action:@selector(share) forControlEvents:UIControlEventAllEvents];
        [self.navigationController.navigationBar addSubview:_shareBtn];
        
//        添加底部按钮
        __weak typeof (&*self)weakSelf=self;
        _bottomView=[[ZCDetailBottomView alloc]init];
        _bottomView.detailProductType=_detailProductType;
        _bottomView.buttonClick=^(ZCBottomButtonType buttonType)
        {
            if (buttonType==CommentType) {
                [weakSelf comment];
            }
            else if(buttonType==SupportType)
            {
                [weakSelf support];
            }
            else if (buttonType==RecommendType)
            {
                [weakSelf collection];
            }
        };
        [self.view addSubview:_bottomView];
        
        if (_detailProductType==PersonDetailProduct) {
            _collectionBtn=(UIButton *)[_bottomView viewWithTag:RecommendType];
        }
    }
    //初始化数据
    [self initData];
}

#pragma mark --- tableView的滑动
-(void)scrollDidScroll
{
    __weak typeof (&*self)weakSelf=self;
    _table.scrollDidScrollBlock=^(CGFloat offSetY)
    {
        if (weakSelf.viewDidappear) {
            //导航栏颜色渐变
            [weakSelf changeNavColorByContentOffSetY:offSetY];
            //设置导航栏title
            CGFloat height=BGIMAGEHEIGHT;
            if ((height + offSetY)/(height)>1) {
                weakSelf.title= weakSelf.oneModel.product.productName;
                if (weakSelf.title.length>8) {
                    weakSelf.title=[NSString stringWithFormat:@"%@...",[weakSelf.title substringToIndex:7]];
                }
            }
            else
            {
                weakSelf.title=nil;
            }
        }
    };
}

#pragma mark --- 获取众筹详情数据
-(void)getHttpData
{
    //获取众筹详情
    NSString *urlStr=KGET_DETAIL_PRODUCT([ZYZCTool getUserId],_productId);
     NSLog(@"%@",urlStr);
    [ZYZCHTTPTool getHttpDataByURL:urlStr withSuccessGetBlock:^(id result, BOOL isSuccess) {
        NSLog(@"result:%@",result);
        if (isSuccess) {
            _detailModel=[[ZCDetailModel alloc]mj_setKeyValues:result];
            
            NSArray *detailDays=_detailModel.detailProductModel.schedule;
            for (NSString *jsonStr in detailDays) {
                NSDictionary *dict=[ZYZCTool turnJsonStrToDictionary:jsonStr];
                MoreFZCTravelOneDayDetailMdel *oneSchedule=[MoreFZCTravelOneDayDetailMdel mj_objectWithKeyValues:dict];
                [_detailDays addObject:oneSchedule];
            }
            //获取数据，给table赋值
            _table.detailDays=_detailDays;
            _table.detailModel=_detailModel;
//            //判断是否已推荐
            _getCollection=[_detailModel.detailProductModel.Friend isEqual:@0];
            [_collectionBtn setTitle:_getCollection?@"推荐":@"已推荐" forState:UIControlStateNormal];
        }
    } andFailBlock:^(id failResult) {
        NSLog(@"failResult:%@",failResult);
    }];
}

#pragma mark --- 分享
-(void)share
{
    __weak typeof (&*self)weakSelf=self;
    __block NSString *url=[NSString stringWithFormat:@"http://www.sosona.com/pay/crowdfundingDetail?pid=%@",_productId];
    
    NSArray *destArr=[ZYZCTool turnJsonStrToArray:_oneModel.product.productDest];
    NSString *dest=destArr.count>1?destArr[1]:@"";
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    alertController.view.tintColor=[UIColor ZYZC_MainColor];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *shareToZoneAction = [UIAlertAction actionWithTitle:@"分享到微信朋友圈" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
    {
        NSLog(@"%@",weakSelf.oneModel.product.productName);
        [WXApiShare shareScene:YES withTitle:_oneModel.product.productName andDesc:[NSString stringWithFormat:@"%@梦想去%@旅行,正在众游筹旅费，希望你能支持TA",_oneModel.user.userName,dest] andThumbImage:nil andWebUrl:url];
    }];
    
    UIAlertAction *shareToFriendAction = [UIAlertAction actionWithTitle:@"分享到微信好友" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
  {
      [WXApiShare shareScene:NO withTitle:_oneModel.product.productName  andDesc:[NSString stringWithFormat:@"%@梦想去%@旅行,正在众游筹旅费，希望你能支持TA",_oneModel.user.userName,dest]  andThumbImage:nil andWebUrl:url];
  }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:shareToZoneAction];
    [alertController addAction:shareToFriendAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark --- 推荐/取消推荐
-(void)collection
{
    NSDictionary *parameters=@{@"openid":[ZYZCTool getUserId],@"friendsId":_productId};
    NSString *url=_getCollection?FOLLOWPRODUCT:UNFOLLOWPRODUCT;
    
    [ZYZCHTTPTool postHttpDataWithEncrypt:YES andURL:url andParameters:parameters andSuccessGetBlock:^(id result, BOOL isSuccess) {
        _getCollection?[MBProgressHUD showSuccess:ZYLocalizedString(@"collection_success")]:[MBProgressHUD showSuccess:ZYLocalizedString(@"collection_fail")];
        [_collectionBtn setTitle:_getCollection?@"已推荐":@"推荐" forState:UIControlStateNormal];
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
    //支付
    if (_bottomView.surePay) {
        NSLog(@"productId:%@",_oneModel.product.productId);
        if (_bottomView.payMoneyBlock) {
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getOrderPayResult:) name:KORDER_PAY_NOTIFICATION object:nil];
            _bottomView.payMoneyBlock(_oneModel.product.productId);
        }
    }
    //提示选择支付众筹的类型
    else{
        UIButton *supportBtn=(UIButton *)[_table.headView viewWithTag:ReturnType];
        [_table.headView getContent:supportBtn];
        
        [MBProgressHUD showSuccess:@"请选择支持方式"];
        [UIView animateWithDuration:0.1 animations:^{
            _table.contentOffset=CGPointMake(0, BGIMAGEHEIGHT-44);
        } completion:nil];
    }
}


#pragma mark --- 支付结果
-(void)getOrderPayResult:(NSNotification *)notify
{
    NSLog(@"notify%@",notify);
    if ([notify.object isEqualToString:@"success"]) {
        //微信支付成功
        [[NSNotificationCenter defaultCenter]removeObserver:self name:KORDER_PAY_NOTIFICATION object:nil];
    }
}

#pragma mark --- 改变导航栏颜色
-(void)changeNavColorByContentOffSetY:(CGFloat )offsetY
{
    //导航栏颜色渐变
    CGFloat height=BGIMAGEHEIGHT;
    if (offsetY >= -height) {
        CGFloat alpha = MIN(1, (height + offsetY)/height);
        [self.navigationController.navigationBar cnSetBackgroundColor:[_navColor colorWithAlphaComponent:alpha]];
    } else {
        [self.navigationController.navigationBar cnSetBackgroundColor:[_navColor colorWithAlphaComponent:0]];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar cnSetBackgroundColor:[_navColor colorWithAlphaComponent:0]];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    _viewDidappear=YES;
    _shareBtn.hidden=NO;
    [self changeNavColorByContentOffSetY:_table.contentOffset.y];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"viewControllerShow" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    _shareBtn.hidden=YES;
    _viewDidappear=NO;
//    if (_detailProductType==PersonDetailProduct) {
//        self.oneModel.productType=ZCListProduct;
//    }
//    else if (_detailProductType==MineDetailProduct)
//    {
//        self.oneModel.productType=MyPublishProduct;
//    }
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
