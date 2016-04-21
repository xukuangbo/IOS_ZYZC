//
//  ZCDetailContentShowBaseCell.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/4/20.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "ZCDetailContentShowBaseCell.h"

@implementation ZCDetailContentShowBaseCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor=[UIColor ZYZC_BgGrayColor];
        [self configUI];
    }
    return self;
}

-(void)configUI
{
     self.cellTable=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_H, ZCDETAIL_CONTENTSHOW_HEIGHT) style:UITableViewStylePlain];
    self.cellTable.dataSource=self;
    self.cellTable.delegate=self;
    self.cellTable.scrollEnabled=NO;
    self.cellTable.bounces=NO;
    self.cellTable.contentOffset=CGPointMake(0, -KCORNERRADIUS);
    self.cellTable.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.cellTable.tableFooterView=[[UIView alloc]init];
    self.cellTable.backgroundColor=[UIColor ZYZC_BgGrayColor];
    [self.contentView addSubview:self.cellTable];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y<=0) {
        scrollView.scrollEnabled=NO;
    }
    else
    {
        scrollView.scrollEnabled=YES;
    }
    
    if (scrollView.contentOffset.y>=scrollView.height*1/2) {
        scrollView.bounces=YES;
    }
    else
    {
        scrollView.bounces=NO;
    }
}


@end
