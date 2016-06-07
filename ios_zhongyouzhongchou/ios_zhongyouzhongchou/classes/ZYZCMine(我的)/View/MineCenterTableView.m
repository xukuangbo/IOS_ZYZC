//
//  MineCenterTableView.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/4/8.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "MineCenterTableView.h"
#import "MineViewController.h"
#import "MineHeadView.h"
#import "MineCenterTableViewCell.h"
#import "MineMessageController.h"
#import "ZCMainController.h"
#import "MineWantGoVC.h"
#import "ZYZCRCManager.h"
#import "MyUserFollowedVC.h"
#import "ZYZCAccountTool.h"
#import "ZYZCAccountModel.h"
#import "MBProgressHUD+MJ.h"
#import "ZYZCMineVIewController.h"
@interface MineCenterTableView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) ZYZCRCManager *RCManager;
@end
@implementation MineCenterTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
//        self.backgroundColor = [UIColor blackColor];
        self.contentInset = UIEdgeInsetsMake(MineTopViewH * KCOFFICIEMNT, 0, 0, 0);
        self.rowHeight = centerCellRowHeight;
        
        self.imageArray = @[@"icn_bag",@"icn_news",@"icn_xingcheng",@"icn_lovedest",@"icn_loveman",@"icn_mylove"];
        self.titleArray = @[@"我的钱包",@"消息",@"我的行程",@"我想去的目的地",@"我关注的旅游达人",@"我的收藏"];
    }
    return self;
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"MineCenterTableViewCell";
    MineCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[MineCenterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    NSString *imageString = self.imageArray[indexPath.row];
    cell.iconView.image = [UIImage imageNamed:imageString];
    cell.titleLabel.text = self.titleArray[indexPath.row];
    
    
//    //显示打卡
//    if (indexPath.row == 0) {
//        cell.playCardBtn.hidden = NO;
//    }
    
    return cell;
}

/**
 *  暂时不做下拉放大
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 向下拽了多少距离
    MineViewController *VC = (MineViewController *)self.viewController;
    CGFloat down = -(MineTopViewH * KCOFFICIEMNT) - scrollView.contentOffset.y;
    if (down < 0){
        VC.topView.top = down;
        return;
    }else{
        VC.topView.top = 0;
        CGRect frame = VC.topView.frame;
        // 5决定图片变大的速度,值越大,速度越快
        frame.size.height = MineTopViewH * KCOFFICIEMNT + down * 1;
        VC.topView.frame = frame;
    }
}

/**
 *  点击时候调用
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZYZCAccountModel *accountModel = [ZYZCAccountTool account];
    if (!accountModel) {
        [MBProgressHUD showError:ZYLocalizedString(@"login_action")];
    }else{
        if (indexPath.row == 1) {
            NSLog(@"消息点击了!!!!!");
            
            //        这里弹到消息界面
            MineMessageController *messageVC = [[MineMessageController alloc] init];
            [self.viewController.navigationController pushViewController:messageVC animated:YES];
        }
        else if (indexPath.row == 2)
        {
            ZCMainController *myTravelVC=[[ZCMainController alloc]init];
            myTravelVC.zcType=Mylist;
            myTravelVC.hidesBottomBarWhenPushed=YES;
            [self.viewController.navigationController pushViewController:myTravelVC animated:YES];
        }
        else if (indexPath.row == 3)
        {
            MineWantGoVC *wantGoVC = [[MineWantGoVC alloc] init];
            [self.viewController.navigationController pushViewController:wantGoVC animated:YES];
        }else if (indexPath.row == 4)
        {
            MyUserFollowedVC *myUserFollowedVC = [[MyUserFollowedVC alloc] init];
            [self.viewController.navigationController pushViewController:myUserFollowedVC animated:YES];
        }
        else if(indexPath.row == 5)
        {
            ZYZCMineVIewController *vc=[[ZYZCMineVIewController alloc]init];
            [self.viewController.navigationController pushViewController:vc animated:YES];
        }
    }
    
    
}

@end
