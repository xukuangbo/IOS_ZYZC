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
- (void)loadView
{
    [super loadView];
    
    [self createUI];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //界面出现的时候需要去加载数据
    [self requestData];
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
}
#pragma mark - 请求网络
- (void)requestData
{
    //能进这里肯定是存在账号的
    ZYZCAccountModel *model = [ZYZCAccountTool account];
    
    NSString *getUserInfoURL  = [NSString stringWithFormat:@"%@openid=%@",GETUSERINFO,model.openid];
    NSLog(@"%@",getUserInfoURL);
    
    [ZYZCHTTPTool getHttpDataByURL:getUserInfoURL withSuccessGetBlock:^(id result, BOOL isSuccess) {
        NSLog(@"%@",result);
        
        [self reloadUIData:result];
    } andFailBlock:^(id failResult) {
        NSLog(@"请求个人信息错误，errror：%@",failResult);
    }];
}

- (void)createUI
{
    MinePersonSetUpScrollView *scrollView = [[MinePersonSetUpScrollView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_W, KSCREEN_H - 49)];
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setBackItem];
    
    //创建界面
    
}

/**
 *  更新数据信息
 */
- (void)reloadUIData:(id)result
{
//    {
//        code = 0;
//        data =     {
//            friend = 0;
//            user =         {
//                faceImg = "http://wx.qlogo.cn/mmopen/ajNVdqHZLLCt7YH6akbZxZZgFFJS1Y6qKoAibibzIODsVz47eKjhrUkI6bFqoCcnugbSPxP5XIn8ticSUSeO26pGQ/0";
//                openid = "oulbuvlPG6-bzDIC6rkQXp53VURc";
//                sex = 1;
//                usedBalance = 0;
//                usedPoints = 0;
//                userId = 59;
//                userName = "\U6bb5\U5b50\U624bmj";
//            };
//        };
//        errorMsg = "";
//    }
    NSDictionary *dic = (NSDictionary *)result;
    
    MinePersonSetUpModel *model = [MinePersonSetUpModel mj_objectWithKeyValues:dic[@"data"]];
    
//    MinePersonAddressModel *addressModel = model.userbyaddress;
    
    self.scrollView.minePersonSetUpModel = model;
   
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    MinePersonSetUpHeadView *headView = [[MinePersonSetUpHeadView alloc] init];
//    SDWebImageOptions options = SDWebImageRetryFailed | SDWebImageLowPriority;
//    ZYZCAccountModel *accountModel = [ZYZCAccountTool account];
//    if (accountModel) {
//        [headView.iconView sd_setImageWithURL:[NSURL URLWithString:accountModel.headimgurl] placeholderImage:[UIImage imageNamed:@"icon_placeholder"] options:options];
//        headView.nameLabel.text = accountModel.nickname;
//    }else{
//        headView.nameLabel.text = @"暂无";
//        headView.iconView.image = [UIImage imageNamed:@"icon_placeholder"];
//    }
//    return headView;
//}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
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
