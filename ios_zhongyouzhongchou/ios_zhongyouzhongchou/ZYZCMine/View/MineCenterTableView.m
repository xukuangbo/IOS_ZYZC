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
@interface MineCenterTableView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) NSArray *titleArray;
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
    
    
    //显示打卡
    if (indexPath.row == 0) {
        cell.playCardBtn.hidden = NO;
    }
    
    return cell;
}

/**
 *  暂时不做下拉放大
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 向下拽了多少距离
    MineViewController *VC = (MineViewController *)[self getVC];
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

-(UIViewController *)getVC
{
    UIResponder *next = self.nextResponder;
    while (next != nil) {
        if ([next isKindOfClass:[UIViewController class]]) {
            
            return (UIViewController *)next;
        }
        
        next = next.nextResponder;
    }
    
    return nil;
}

/**
 *  点击时候调用
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        NSLog(@"消息点击了!!!!!");
        
//        这里弹到消息界面
        MineMessageController *messageVC = [[MineMessageController alloc] init];
        [[self getVC].navigationController pushViewController:messageVC animated:YES];
    }
}

@end
