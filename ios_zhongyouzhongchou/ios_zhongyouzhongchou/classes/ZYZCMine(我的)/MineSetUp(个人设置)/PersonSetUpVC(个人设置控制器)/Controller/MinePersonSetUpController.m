//
//  MinePersonSetUpController.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/5/12.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "MinePersonSetUpController.h"
#import "MinePersonSetUpHeadView.h"
#import "ZYZCAccountTool.h"
#import "ZYZCAccountModel.h"
#import "FXBlurView.h"
#import "MinePersonSetUpScrollView.h"
#import "MBProgressHUD+MJ.h"
#import "MJExtension.h"
#import "MinePersonSetUpModel.h"
#import "MinePersonAddressModel.h"
#define home_navi_bgcolor(alpha) [[UIColor ZYZC_NavColor] colorWithAlphaComponent:alpha]

@interface MinePersonSetUpController ()<UIScrollViewDelegate>
@property (nonatomic, weak) MinePersonSetUpScrollView *scrollView;
@end

@implementation MinePersonSetUpController
#pragma mark - 系统方法
- (void)loadView
{
    [super loadView];
    
    [self createUI];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //界面出现的时候需要去加载数据
    [self requestData];
}


- (void)viewDidUnload
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar cnSetBackgroundColor:home_navi_bgcolor(0)];

    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar cnSetBackgroundColor:[UIColor ZYZC_NavColor]];
    self.navigationController.navigationBar.titleTextAttributes=
    @{NSForegroundColorAttributeName:[UIColor whiteColor],
      NSFontAttributeName:[UIFont boldSystemFontOfSize:20]};
    
    self.hidesBottomBarWhenPushed = YES;
}
#pragma mark - 请求网络
- (void)requestData
{
    //能进这里肯定是存在账号的
    ZYZCAccountModel *model = [ZYZCAccountTool account];
    
    NSString *getUserInfoURL  = Get_SelfInfo(model.openid, [model.userId intValue]);
    NSLog(@"%@",getUserInfoURL);
    [ZYZCHTTPTool getHttpDataByURL:getUserInfoURL withSuccessGetBlock:^(id result, BOOL isSuccess) {
//        NSLog(@"%@",result);
        
        [self reloadUIData:result];
    } andFailBlock:^(id failResult) {
        NSLog(@"请求个人信息错误，errror：%@",failResult);
    }];
}

- (void)createUI
{
    MinePersonSetUpScrollView *scrollView = [[MinePersonSetUpScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setBackItem];
    
}

/**
 *  更新数据信息
 */
- (void)reloadUIData:(id)result
{
    NSDictionary *dic = (NSDictionary *)result;
    NSDictionary *data = dic[@"data"];
    
    MinePersonSetUpModel *model = [MinePersonSetUpModel mj_objectWithKeyValues:data[@"user"]];
    
    self.scrollView.minePersonSetUpModel = model;
}
#pragma mark - button点击
- (void)keyboardWillShow:(NSNotification *)notification {
    
}

- (void)keyboardWillHide:(NSNotification *)notification {
    
}



#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //make keyboard down
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    [self changeNaviColorWithScroll:scrollView];
}

- (void)changeNaviColorWithScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    
    
    if (offsetY <= imageHeadHeight) {
        CGFloat alpha = MAX(0, offsetY/imageHeadHeight);
        
        [self.navigationController.navigationBar cnSetBackgroundColor:home_navi_bgcolor(alpha)];
        self.title = @"";
    } else {
        [self.navigationController.navigationBar cnSetBackgroundColor:home_navi_bgcolor(1)];
        self.title = @"个人设置";
        
    }
}
@end
