//
//  MineCenterTableView.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/4/8.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "MineFootTableView.h"
#import "MineViewController.h"
#import "MineHeadView.h"
@interface MineFootTableView()<UITableViewDelegate,UITableViewDataSource>

@end
@implementation MineFootTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        self.backgroundColor = [UIColor blackColor];
        self.contentInset = UIEdgeInsetsMake(MineTopViewH * KCOFFICIEMNT, 0, 0, 0);
    }
    return self;
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView: (UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.contentView.backgroundColor = [UIColor redColor];
        //        cell.textLabel.text = [NSString stringWithFormat:@"第%zd个cell",indexPath.row];
        return cell;
    }
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
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


@end
