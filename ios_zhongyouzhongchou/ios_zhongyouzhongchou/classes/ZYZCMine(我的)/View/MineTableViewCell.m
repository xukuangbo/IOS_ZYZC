//
//  MineTableViewCell.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/6/7.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "MineTableViewCell.h"
#import "ZCMainController.h"
#import "MineWantGoVC.h"
#import "ZYZCRCManager.h"
#import "MyUserFollowedVC.h"
#import "ZYZCAccountTool.h"
#import "ZYZCAccountModel.h"
#import "MBProgressHUD+MJ.h"
#import "ZYZCMineVIewController.h"
@interface MineTableViewCell ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIImageView *iconImg;
@property (nonatomic, strong) UILabel     *textLab;
@property (nonatomic, strong) UIImageView *arrowImg;
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation MineTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor=[UIColor ZYZC_BgGrayColor];
        _dataArr=[NSMutableArray array];
        NSArray *iconNames=@[@"icon_wallet",@"icon_message",@"icon_trip",
                             @"icon_reture",@"icon_destination",@"icon_man"];
        NSArray *titles=@[@"我的钱包",@"私信",@"我的行程",@"我的回报",@"我想去的目的地",@"我关注的旅行达人"];
        for (int i=0; i<6; i++) {
            MineOneItemModel *itemModel=[[MineOneItemModel alloc]init];
            itemModel.iconImg=iconNames[i];
            itemModel.title=titles[i];
            [_dataArr addObject:itemModel];
        }
        [self configUI];
    }
    return self;
}

-(void)configUI
{
    UIImageView *bgImg=[[UIImageView alloc]initWithFrame:CGRectMake(KEDGE_DISTANCE, 0, KSCREEN_W-2*KEDGE_DISTANCE, MINE_CELL_HEIGHT)];
    bgImg.image=KPULLIMG(@"tab_bg_boss0", 5, 0, 5, 0);
    [self.contentView addSubview:bgImg];
    bgImg.userInteractionEnabled=YES;
    
    UITableView *table=[[UITableView alloc]initWithFrame:CGRectMake(KEDGE_DISTANCE, KEDGE_DISTANCE, bgImg.width-2*KEDGE_DISTANCE, bgImg.height-2*KEDGE_DISTANCE) style:UITableViewStylePlain];
    table.dataSource=self;
    table.delegate=self;
    table.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    table.backgroundColor=[UIColor ZYZC_BgGrayColor];
    table.separatorStyle=UITableViewCellSeparatorStyleNone;
    table.showsVerticalScrollIndicator=NO;
    table.scrollEnabled=NO;
    [bgImg addSubview:table];

}

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   NSString *cellId=@"mineItemCell";
    MineOneItemCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell=[[MineOneItemCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.itemModel=_dataArr[indexPath.row];
        if (indexPath.row==5) {
            cell.hiddenLine=YES;
        }
        if (indexPath.row==1) {
            cell.showDot=YES;
        }
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ONE_ITEM_CELL_HEIGHT;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        //我的钱包
    }
    else if (indexPath.row==1)
    {
        //私信
        ZYZCRCManager *RCManager=[ZYZCRCManager defaultManager];
        [RCManager getMyConversationListWithSupperController:self.viewController];
    }
    else if (indexPath.row==2)
    {
        //我的行程
        ZCMainController *myTravelVC=[[ZCMainController alloc]init];
        myTravelVC.zcType=Mylist;
        myTravelVC.hidesBottomBarWhenPushed=YES;
        [self.viewController.navigationController pushViewController:myTravelVC animated:YES];
    }
    else if(indexPath.row==3)
    {
        //我的回报
        
    }
    else if (indexPath.row==4)
    {
        //我想去的目的地
        MineWantGoVC *wantGoVC = [[MineWantGoVC alloc] init];
        [self.viewController.navigationController pushViewController:wantGoVC animated:YES];

    }
    else if (indexPath.row==5)
    {
        //我关注的旅行达人
        MyUserFollowedVC *myUserFollowedVC = [[MyUserFollowedVC alloc] init];
        [self.viewController.navigationController pushViewController:myUserFollowedVC animated:YES];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
