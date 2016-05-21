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
#import "MinePersonSetUpFirstCell.h"
#define imageHeadHeight (KSCREEN_W / 16 * 9)
static NSString *const ID = @"MinePersonSetUpCell";
@interface MinePersonSetUpController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation MinePersonSetUpController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self scrollViewDidScroll:self.tableView];
    
    [self setBackItem];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setClearNavi];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self setNavi];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.contentView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256) / 256.0 green:arc4random_uniform(256) / 256.0 blue:arc4random_uniform(256) / 256.0 alpha:1];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return imageHeadHeight;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    MinePersonSetUpHeadView *headView = [[MinePersonSetUpHeadView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_W, imageHeadHeight)];
    SDWebImageOptions options = SDWebImageRetryFailed | SDWebImageLowPriority;
    ZYZCAccountModel *accountModel = [ZYZCAccountTool account];
    if (accountModel) {
        [headView.iconView sd_setImageWithURL:[NSURL URLWithString:accountModel.headimgurl] placeholderImage:[UIImage imageNamed:@"icon_placeholder"] options:options];
        headView.nameLabel.text = accountModel.nickname;
    }else{
        headView.nameLabel.text = @"暂无";
        headView.iconView.image = [UIImage imageNamed:@"icon_placeholder"];
    }
    return headView;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self changeNaviColorWithScroll:scrollView];
}
@end
