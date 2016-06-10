//
//  MineWalletVc.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/6/7.
//  Copyright © 2016年 liuliang. All rights reserved.
//
#define home_navi_bgcolor(alpha) [[UIColor ZYZC_NavColor] colorWithAlphaComponent:alpha]
#import "MineWalletVc.h"
#import "ZYZCAccountTool.h"
#import "ZYZCAccountModel.h"
#import "MineWalletTableViewCell.h"
#import "MineWalletModel.h"
@interface MineWalletVc ()<UITableViewDelegate,UITableViewDataSource>
/**
 *  头视图
 */
@property (nonatomic, strong) UIView *headMapView;
/**
 *  金钱显示
 */
@property (nonatomic, strong) UILabel *moneyLabel;
/**
 *  提现
 */
@property (nonatomic, strong) UIButton *checkMoneyButton;

/**
 *  提现说明
 */
@property (nonatomic, strong) UILabel *descLabel;

@property (nonatomic, strong) NSArray *projectArray;


@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MineWalletVc

#pragma mark - system方法
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}
- (void)loadView
{
    [super loadView];
    
    [self configUI];
    
    [self requsetData];
    [self.navigationController.navigationBar cnSetBackgroundColor:home_navi_bgcolor(1)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar cnSetBackgroundColor:home_navi_bgcolor(1)];
}

#pragma mark - setUI方法
- (void)configUI
{
    self.view.backgroundColor = [UIColor ZYZC_BgGrayColor];
    
    self.title = @"我的钱包";
    
    [self setBackItem];
    
    [self createHeadView];
    
    [self createTableView];
    
}


- (void)createHeadView
{
    _headMapView = [[UIView alloc] initWithFrame:CGRectMake(0, KNAV_STATUS_HEIGHT, KSCREEN_W, (KSCREEN_H - KNAV_STATUS_HEIGHT) / 2.0)];
    _headMapView.backgroundColor = [UIColor ZYZC_BgGrayColor];
    [self.view addSubview:_headMapView];
    //标题
    CGFloat titleLabelW = KSCREEN_W;
    CGFloat titleLabelH = 20;
    CGFloat titleLabelX = 0;
    CGFloat titleLabelY = KEDGE_DISTANCE;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH)];
    titleLabel.text = @"可提现旅费";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [_headMapView addSubview:titleLabel];
    
    //金额
    CGFloat moneyLabelW = KSCREEN_W;
    CGFloat moneyLabelH = 60;
    _moneyLabel = [[UILabel alloc] init];
    _moneyLabel.size = CGSizeMake(moneyLabelW, moneyLabelH);
    _moneyLabel.centerX = _headMapView.width * 0.5;
    _moneyLabel.bottom = _headMapView.height * 0.5;
//    _moneyLabel.backgroundColor = [UIColor blueColor];
    _moneyLabel.textAlignment = NSTextAlignmentCenter;
    _moneyLabel.text = @"￥8000.00";
    [_headMapView addSubview:_moneyLabel];
    
    //保存按钮
    CGFloat checkMoneyW = KSCREEN_W - 2 * KEDGE_DISTANCE;
    CGFloat checkMoneyH = 50;
    _checkMoneyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _checkMoneyButton.size = CGSizeMake(checkMoneyW, checkMoneyH);
    _checkMoneyButton.centerY = 0.75 * _headMapView.height;
    _checkMoneyButton.centerX = _headMapView.width * 0.5;
    _checkMoneyButton.layer.cornerRadius = 5;
    _checkMoneyButton.layer.masksToBounds = YES;
    _checkMoneyButton.titleLabel.textColor = [UIColor whiteColor];
    _checkMoneyButton.backgroundColor = [UIColor ZYZC_MainColor];
    _checkMoneyButton.titleLabel.font = [UIFont systemFontOfSize:25];
    [_checkMoneyButton addTarget:self action:@selector(checkMoneyButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_checkMoneyButton setTitle:@"提现" forState:UIControlStateNormal];
    
    [_headMapView addSubview:_checkMoneyButton];
    
    //提现说明
    CGFloat descLabelW = KSCREEN_W;
    CGFloat descLabelH = 20;
    _descLabel = [[UILabel alloc] init];
    _descLabel.size = CGSizeMake(descLabelW, descLabelH);
    _descLabel.bottom = _headMapView.height - 10;
    _descLabel.centerX = _headMapView.width * 0.5;
    _descLabel.textAlignment = NSTextAlignmentCenter;
    _descLabel.text = @"提现说明";
    _descLabel.textColor = [UIColor ZYZC_MainColor];
    _descLabel.font = [UIFont systemFontOfSize:14];
    [_descLabel addTarget:self action:@selector(descLabelAction)];
    
    [_headMapView addSubview:_descLabel];
}

- (void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.contentInset = UIEdgeInsetsMake( _headMapView.height, 0, 0, 0);
    [self.view insertSubview:_tableView atIndex:0];
    NSLog(@"%@",NSStringFromCGRect(_tableView.frame));
}

#pragma mark - requsetData方法
- (void)requsetData
{
    NSString *url = Get_MyWallet;
    ZYZCAccountModel *accountModel = [ZYZCAccountTool account];
    NSDictionary *parameters = @{
                                 @"openid":accountModel.openid
                                 };
    __weak typeof(&*self) weakSelf = self;
    [ZYZCHTTPTool postHttpDataWithEncrypt:YES andURL:url andParameters:parameters andSuccessGetBlock:^(id result, BOOL isSuccess) {
        NSString *cash = [NSString stringWithFormat:@"%@",result[@"data"][@"cash"]];
        [weakSelf changeMoneyByMoney:cash];
    } andFailBlock:^(id failResult) {
        NSLog(@"%@",failResult);
    }];
    
    NSArray *tempArray = @[
                                @{
                                    @"projectImg" : @"http://cc.cocimg.com/api/uploads/160601/26c53ff78ae3b1cdcd93b2c444aed35a.jpg",
                                    @"name" : @"阿萨德刚",
                                    @"totalMoney" : @"23133",
                                    @"drawMoneyTime" : @"1988-02-23",
                                    @"projectName" : @"在你的心上，自由的飞翔"
                                    
                                    },
                                @{
                                    @"projectImg" : @"http://cc.cocimg.com/api/uploads/160601/26c53ff78ae3b1cdcd93b2c444aed35a.jpg",
                                    @"name" : @"阿萨德刚",
                                    @"totalMoney" : @"23133",
                                    @"drawMoneyTime" : @"1988-02-23",
                                    @"projectName" : @"在你的心上，自由的飞翔"
                                    
                                    },
                                @{
                                    @"projectImg" : @"http://cc.cocimg.com/api/uploads/160601/26c53ff78ae3b1cdcd93b2c444aed35a.jpg",
                                    @"name" : @"阿萨德刚",
                                    @"totalMoney" : @"23133",
                                    @"drawMoneyTime" : @"1988-02-23",
                                    @"projectName" : @"在你的心上，自由的飞翔"
                                    
                                    },
                                @{
                                    @"projectImg" : @"http://cc.cocimg.com/api/uploads/160601/26c53ff78ae3b1cdcd93b2c444aed35a.jpg",
                                    @"name" : @"阿萨德刚",
                                    @"totalMoney" : @"23133",
                                    @"drawMoneyTime" : @"1988-02-23",
                                    @"projectName" : @"在你的心上，自由的飞翔"
                                    
                                    },
                                @{
                                    @"projectImg" : @"http://cc.cocimg.com/api/uploads/160601/26c53ff78ae3b1cdcd93b2c444aed35a.jpg",
                                    @"name" : @"阿萨德刚",
                                    @"totalMoney" : @"23133",
                                    @"drawMoneyTime" : @"1988-02-23",
                                    @"projectName" : @"在你的心上，自由的飞翔"
                                    
                                    },
                                ];
    
    _projectArray = [MineWalletModel mj_objectArrayWithKeyValuesArray:tempArray];
    
    [_tableView reloadData];
}
#pragma mark - set方法
- (void)changeMoneyByMoney:(NSString *)cash
{
    
    NSString *money = [NSString stringWithFormat:@"￥ %@元",cash];
    
    NSMutableAttributedString *attributedmoney = [[NSMutableAttributedString alloc] initWithString:money];
    [attributedmoney addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:[money rangeOfString:@"￥ "]];
    [attributedmoney addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:[money rangeOfString:@"元"]];
    [attributedmoney addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25] range:[money rangeOfString:cash]];
    
    _moneyLabel.attributedText = attributedmoney;
    
}

#pragma mark - button点击方法
- (void)checkMoneyButtonAction:(UIButton *)button
{
    NSLog(@"提现啦！！！");
}

- (void)descLabelAction
{
    NSLog(@"提现说明");
}
#pragma mark - delegate方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_projectArray.count == 0) {
        _tableView.hidden = YES;
    }else{
        _tableView.hidden = NO;
    }
    return _projectArray.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *ID = @"MineWalletTableViewCell";
    MineWalletTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[MineWalletTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.mineWalletModel = _projectArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return WalletCellRowHeight;
}
@end
