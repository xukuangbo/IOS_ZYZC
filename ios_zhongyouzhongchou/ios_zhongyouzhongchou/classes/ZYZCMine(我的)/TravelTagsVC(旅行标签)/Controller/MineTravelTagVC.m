//
//  MineTravelTagVC.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/6/13.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "MineTravelTagVC.h"
#import "MineTravelTagsModel.h"
#import "MineTravelTagButton.h"
#import "MineTravelTagBgView.h"
#import "ZYZCAccountTool.h"
#import "MBProgressHUD+MJ.h"
#define SetUpFirstCellLabelHeight 34
@interface MineTravelTagVC ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *titleArrayOne;
@property (nonatomic, strong) NSMutableArray *titleArrayTwo;
@property (nonatomic, strong) MineTravelTagBgView *firstBg;
@property (nonatomic, strong) MineTravelTagBgView *secondBg;
@property (nonatomic, strong) NSArray *personTagArray;
@property (nonatomic, strong) ZYZCAccountModel *account;

@property (nonatomic, strong) UIButton *saveButton;
@end

@implementation MineTravelTagVC
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
        self.view.backgroundColor = [UIColor ZYZC_BgGrayColor];
        
        self.title = @"旅行标签";
        _account = [ZYZCAccountTool account];
        [self setBackItem];
        
        [self configUI];
        
        [self requestPersonTagData];
        
        
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar cnSetBackgroundColor:[[UIColor ZYZC_NavColor] colorWithAlphaComponent:1]];
}
#pragma mark - system方法

#pragma mark - setUI方法
- (void)configUI
{
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    scrollView.backgroundColor = [UIColor ZYZC_BgGrayColor];
    [self.view addSubview:scrollView];
    scrollView.delegate = self;
    self.scrollView = scrollView;
    
    [self createSaveButton];
    
}

/**
 *  保存按钮
 */
- (void)createSaveButton
{
    //保存按钮
    CGFloat saveButtonX = KEDGE_DISTANCE;
    CGFloat saveButtonY = -100;
    CGFloat saveButtonW = KSCREEN_W - 2 * saveButtonX;
    CGFloat saveButtonH = SetUpFirstCellLabelHeight * 2;
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    saveButton.frame = CGRectMake(saveButtonX, saveButtonY, saveButtonW, saveButtonH);
    saveButton.layer.cornerRadius = 5;
    saveButton.layer.masksToBounds = YES;
    saveButton.titleLabel.textColor = [UIColor whiteColor];
    saveButton.backgroundColor = [UIColor ZYZC_MainColor];
    saveButton.titleLabel.font = [UIFont systemFontOfSize:25];
    [saveButton addTarget:self action:@selector(saveButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    
    [self.scrollView addSubview:saveButton];
    self.saveButton = saveButton;
    
}

#pragma mark - requsetData方法
- (void)requestPersonTagData
{
    __weak typeof(&*self) weakSelf = self;
    NSLog(@"%@",Get_UserInfo_AddressInfo(_account.openid));
    [ZYZCHTTPTool getHttpDataByURL:Get_UserInfo_AddressInfo(_account.openid) withSuccessGetBlock:^(id result, BOOL isSuccess) {
        NSString *tagstring = result[@"data"][@"user"][@"tags"];
        if (tagstring) {
            weakSelf.personTagArray = [tagstring componentsSeparatedByString:@","];
            
            [self requestDataOne];
        }
    } andFailBlock:^(id failResult) {
        
    }];
}

- (void)requestDataOne{
    
    __weak typeof(&*self) weakSelf = self;
    [ZYZCHTTPTool getHttpDataByURL:Get_TravelTag_List(1) withSuccessGetBlock:^(id result, BOOL isSuccess) {
        
        NSLog(@"%@",result);
        weakSelf.titleArrayOne = [MineTravelTagsModel mj_objectArrayWithKeyValuesArray:result[@"data"]];
        
        [self requestDataTwo];
        
    } andFailBlock:^(id failResult) {
        NSLog(@"%@",failResult);
    }];
    
}

- (void)requestDataTwo{
    __weak typeof(&*self) weakSelf = self;
    [ZYZCHTTPTool getHttpDataByURL:Get_TravelTag_List(2) withSuccessGetBlock:^(id result, BOOL isSuccess) {
        
        NSLog(@"%@",result);
        weakSelf.titleArrayTwo = [MineTravelTagsModel mj_objectArrayWithKeyValuesArray:result[@"data"]];
        
        weakSelf.saveButton.origin = CGPointMake(KEDGE_DISTANCE, weakSelf.secondBg.bottom + KEDGE_DISTANCE);
        weakSelf.scrollView.contentSize = CGSizeMake(0, weakSelf.saveButton.bottom + KEDGE_DISTANCE);
    } andFailBlock:^(id failResult) {
        NSLog(@"%@",failResult);
    }];
}
#pragma mark - set方法
- (void)setTitleArrayOne:(NSMutableArray *)titleArrayOne
{
    _titleArrayOne = titleArrayOne;
    
    //移除所有的子button
    for(UIView *mylabelview in [_firstBg subviews])
    {
        if ([mylabelview isKindOfClass:[UIButton class]]) {
            [mylabelview removeFromSuperview];
        }
    }
    
    CGFloat bgImageViewX = KEDGE_DISTANCE;
    CGFloat bgImageViewY = KEDGE_DISTANCE;
    CGFloat bgImageViewW = KSCREEN_W - 2 * bgImageViewX;
    CGFloat bgImageViewH = _scrollView.height - bgImageViewY * 2;
    _firstBg = [[MineTravelTagBgView alloc] initWithFrame:CGRectMake(bgImageViewX, bgImageViewY, bgImageViewW, bgImageViewH) Title:@"请选择旅行标签" DetailTitle:@"最多10个标签" TitleArray:titleArrayOne PesonTitleArray:_personTagArray];
    [_scrollView addSubview:_firstBg];
}
- (void)setTitleArrayTwo:(NSMutableArray *)titleArrayTwo
{
    //移除所有的子button
    for(UIView *mylabelview in [_secondBg subviews])
    {
        if ([mylabelview isKindOfClass:[UIButton class]]) {
            [mylabelview removeFromSuperview];
        }
    }
    CGFloat bgImageViewX = KEDGE_DISTANCE;
    CGFloat bgImageViewY = _firstBg.bottom + KEDGE_DISTANCE;
    CGFloat bgImageViewW = KSCREEN_W - 2 * bgImageViewX;
    CGFloat bgImageViewH = 0;
    _secondBg = [[MineTravelTagBgView alloc] initWithFrame:CGRectMake(bgImageViewX, bgImageViewY, bgImageViewW, bgImageViewH) Title:@"请选择兴趣标签" DetailTitle:@"最多10个标签" TitleArray:titleArrayTwo PesonTitleArray:_personTagArray];
    [_scrollView addSubview:_secondBg];
}
#pragma mark - button点击方法
- (void)saveButtonAction:(UIButton *)button
{
    //拼接第一个
    NSString *string = [NSString string];
    for (UIView *view in _firstBg.subviews) {
        if ([view isKindOfClass:[MineTravelTagButton class]]) {
            MineTravelTagButton *button = (MineTravelTagButton *)view;
            if (button.selected == YES) {
                
                if (string.length < 1) {
                    string = [string stringByAppendingString:[NSString stringWithFormat:@"%@",button.textString]];
                }else{
                    string = [string stringByAppendingString:[NSString stringWithFormat:@",%@",button.textString]];
                }
                
            }else{
                
            }
        }
    }
    //拼接第二个
    for (UIView *view in _secondBg.subviews) {
        if ([view isKindOfClass:[MineTravelTagButton class]]) {
            MineTravelTagButton *button = (MineTravelTagButton *)view;
            if (button.selected == YES) {
                if (string.length < 1) {
                    string = [string stringByAppendingString:[NSString stringWithFormat:@"%@",button.textString]];
                }else{
                    string = [string stringByAppendingString:[NSString stringWithFormat:@",%@",button.textString]];
                }
            }else{
                
            }
        }
        
    }
    NSLog(@"%@",string);
    NSDictionary *parameters = @{
                                 @"openid":_account.openid,
                                 @"tags":string
                                 };
    __weak typeof(&*self) weakSelf = self;
    [ZYZCHTTPTool postHttpDataWithEncrypt:YES andURL:Post_TravelTag andParameters:parameters    andSuccessGetBlock:^(id result, BOOL isSuccess) {
        
        [MBProgressHUD showSuccess:@"旅行标签设置成功"];
        
        [weakSelf.navigationController popViewControllerAnimated:YES];
    } andFailBlock:^(id failResult) {
        NSLog(@"%@",failResult);
        [MBProgressHUD showSuccess:@"旅行标签设置失败"];
    }];
}
#pragma mark - delegate方法

@end
