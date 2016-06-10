//
//  TacticSingleViewController.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/4/21.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "TacticSingleViewController.h"
#import "TacticSingleFoodModel.h"
#import "TacticSingleTipsModel.h"
#import "TacticSingleTableViewCell.h"
//#import "TacticSingleHeadView.h"
#import "TacticCustomMapView.h"
#import "TacticCityHeadView.h"
#import "TacticCountryHeadView.h"
#import "TacticSingleModelFrame.h"
#import "ZYZCAccountTool.h"
#import "ZYZCAccountModel.h"
#import "MBProgressHUD+MJ.h"
@interface TacticSingleViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) TacticSingleModelFrame *tacticSingleModelFrame;

@property (nonatomic, weak) UIButton *sureButton;

@property (nonatomic,assign) BOOL isWantGo;
@end



@implementation TacticSingleViewController
#pragma mark - system方法
- (instancetype)initWithViewId:(NSInteger)viewId
{
    self = [super init];
    if (self) {
        self.viewId = viewId;
        
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setBackItem];
    
    /**
     *  设置导航栏
     */
    [self setUpNavi];
    /**
     *  创建tableView
     */
    [self createTableView];
    /**
     *  创建底部工具条
     */
    [self createBottomBar];
    
    /**
     *  刷新数据
     */
    [self refreshDataWithViewId:self.viewId];
    
    
    [self requestWantGoWithViewId:_viewId];
}
- (void)viewWillAppear:(BOOL)animated
{
    [self scrollViewDidScroll:self.tableView];
}
#pragma mark - set方法
- (TacticSingleModelFrame *)tacticSingleModelFrame
{
    if(!_tacticSingleModelFrame){
        _tacticSingleModelFrame = [[TacticSingleModelFrame alloc] init];
    }
    return _tacticSingleModelFrame;
}

- (void)setIsWantGo:(BOOL)isWantGo
{
    _isWantGo = isWantGo;
    if (isWantGo == YES) {//已关注
        [_sureButton setTitle:ZYLocalizedString(@"isWantGo") forState:UIControlStateNormal];
    }else{
        [_sureButton setTitle:ZYLocalizedString(@"wantGo") forState:UIControlStateNormal];
    }
}

#pragma mark - configUI方法
/**
 *  设置导航栏
 */
- (void)setUpNavi
{
    [self.navigationController.navigationBar cnSetBackgroundColor:home_navi_bgcolor(0)];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
}
/**
 *  创建tableView
 */
- (void)createTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor ZYZC_BgGrayColor];
    tableView.separatorColor = [UIColor clearColor];
    [self.view addSubview:tableView];
    self.tableView = tableView;
}
/**
 *  创建底部工具条
 */
- (void)createBottomBar
{
    UIView *bottomBar = [[UIView alloc] init];
    bottomBar.size = CGSizeMake(KSCREEN_W, 49);
    bottomBar.left = 0;
    bottomBar.bottom = KSCREEN_H;
    bottomBar.backgroundColor=[UIColor ZYZC_TabBarGrayColor];
    [self.view addSubview:bottomBar];
    CGFloat btn_width = KSCREEN_W/2;
    UIButton *sureBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(btn_width * 0.5, 0, btn_width, bottomBar.height);
    [sureBtn setTitle:ZYLocalizedString(@"wantGo") forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor ZYZC_TextGrayColor] forState:UIControlStateNormal];
    sureBtn.titleLabel.font=[UIFont systemFontOfSize:20];
    [sureBtn addTarget:self action:@selector(wantToGoAction:) forControlEvents:UIControlEventTouchUpInside];
    [bottomBar addSubview:sureBtn];
    self.sureButton = sureBtn;
}
#pragma mark - requsetData方法
/**
 *  刷新数据
 */
- (void)refreshDataWithViewId:(NSInteger)viewId
{
    if (_tacticSingleModel) {
        self.tacticSingleModelFrame.tacticSingleModel = _tacticSingleModel;
        [self.tableView reloadData];
        return;
    }
    
    NSString *url = GET_TACTIC_VIEW(viewId);
    NSLog(@"%@",url);
    
    __weak typeof(&*self) weakSelf = self;
    [ZYZCHTTPTool getHttpDataByURL:url withSuccessGetBlock:^(id result, BOOL isSuccess) {
        if (isSuccess) {
            //          NSLog(@"%@",result);
            TacticSingleModel *tacticSingleModel = [TacticSingleModel mj_objectWithKeyValues:result[@"data"]];
            weakSelf.tacticSingleModelFrame.tacticSingleModel = tacticSingleModel;
            
            [weakSelf.tableView reloadData];
        }
        
    } andFailBlock:^(id failResult) {
        NSLog(@"%@",failResult);
    }];
    
}

- (void)requestWantGoWithViewId:(NSInteger)viewId
{
    
    ZYZCAccountModel *accountModel = [ZYZCAccountTool account];
    NSString *url = Get_Tactic_Status_WantGo(accountModel.openid, self.viewId);
    NSLog(@"%@",url);
    __weak typeof(&*self) weakSelf = self;
    [ZYZCHTTPTool getHttpDataByURL:url withSuccessGetBlock:^(id result, BOOL isSuccess) {
        if (isSuccess) {
            weakSelf.isWantGo = [result[@"data"] intValue];
        }
        
    } andFailBlock:^(id failResult) {
        NSLog(@"%@",failResult);
    }];
    
}

- (void)wantToGoAction:(UIButton *)button
{
    ZYZCAccountModel *accountModel = [ZYZCAccountTool account];
    if (!accountModel) {//没有账号
        [MBProgressHUD showError:@"请登录后再点击"];
    }else{
        if(_isWantGo == NO){//加关注
            NSString *wantGoUrl = Add_Tactic_WantGo(accountModel.openid, self.viewId);
            NSLog(@"%@",wantGoUrl);
            [ZYZCHTTPTool getHttpDataByURL:wantGoUrl withSuccessGetBlock:^(id result, BOOL isSuccess) {
                [MBProgressHUD showSuccess:ZYLocalizedString(@"add_spot_success")];
                //改文字
//                [self.sureButton setTitle:@"已关注" forState:UIControlStateNormal];
                self.isWantGo = YES;
            } andFailBlock:^(id failResult) {
                [MBProgressHUD showError:ZYLocalizedString(@"add_spot_fail")];
            }];
            
        }else{//取关
            NSString *wantGoUrl = Del_Tactic__WantGo(accountModel.openid, self.viewId);
            [ZYZCHTTPTool getHttpDataByURL:wantGoUrl withSuccessGetBlock:^(id result, BOOL isSuccess) {
                [MBProgressHUD showSuccess:ZYLocalizedString(@"del_spot_success")];
                //改文字
//                [self.sureButton setTitle:@"想去" forState:UIControlStateNormal];
                
                self.isWantGo = NO;
            } andFailBlock:^(id failResult) {
                [MBProgressHUD showError:ZYLocalizedString(@"del_spot_fail")];
            }];
            
        }
    }
    
    
}



#pragma mark - UITableDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *ID = @"TacticSingleTableViewCell";
    TacticSingleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[TacticSingleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    //这里进行模型的赋值
    cell.tacticSingleModelFrame = self.tacticSingleModelFrame;
    return cell;
}

#pragma mark - UITableDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return TacticSingleHeadViewHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    SDWebImageOptions options = SDWebImageRetryFailed | SDWebImageLowPriority;
    //进行判断，是国家还是城市
    if (self.tacticSingleModelFrame.tacticSingleModel.viewType == 1) {
        TacticCountryHeadView *headView = [[TacticCountryHeadView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_W, TacticSingleHeadViewHeight)];
        
        //国家
        headView.flagImageName.text = self.tacticSingleModelFrame.tacticSingleModel.name;
        [headView sd_setImageWithURL:[NSURL URLWithString:KWebImage(self.tacticSingleModelFrame.tacticSingleModel.viewImg)] placeholderImage:[UIImage imageNamed:@"image_placeholder"] options:options];
        [headView.flagImage sd_setImageWithURL:[NSURL URLWithString:KWebImage(self.tacticSingleModelFrame.tacticSingleModel.countryImg)] placeholderImage:[UIImage imageNamed:@"image_placeholder"] options:options];
        
        return headView;
    }else if (self.tacticSingleModelFrame.tacticSingleModel.viewType == 2) {
        
        TacticCityHeadView *headView = [[TacticCityHeadView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_W, TacticSingleHeadViewHeight)];
        
        //添加渐变条
        UIImageView *bgImg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_W, 64)];
        bgImg.image=[UIImage imageNamed:@"Background"];
        [headView addSubview:bgImg];
        
        headView.nameLabel.text = self.tacticSingleModelFrame.tacticSingleModel.name;
       
        [headView sd_setImageWithURL:[NSURL URLWithString:KWebImage(self.tacticSingleModelFrame.tacticSingleModel.viewImg)] placeholderImage:[UIImage imageNamed:@"image_placeholder"] options:options];
        [headView.flagImage sd_setImageWithURL:[NSURL URLWithString:KWebImage(self.tacticSingleModelFrame.tacticSingleModel.countryImg)] placeholderImage:[UIImage imageNamed:@"image_placeholder"] options:options];
        headView.flagImageName.text = self.tacticSingleModelFrame.tacticSingleModel.country;
        return headView;
        
    }else{
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.tacticSingleModelFrame.realHeight;
}

/**
 *  navi背景色渐变的效果
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY <= oneViewMapHeight) {
        CGFloat alpha = MAX(0, offsetY/oneViewMapHeight);
        
        [self.navigationController.navigationBar cnSetBackgroundColor:home_navi_bgcolor(alpha)];
        self.title = @"";
    } else {
        [self.navigationController.navigationBar cnSetBackgroundColor:home_navi_bgcolor(1)];
        if (self.tacticSingleModelFrame) {
            self.title = self.tacticSingleModelFrame.tacticSingleModel.name;
        }
        
    }
}


@end
