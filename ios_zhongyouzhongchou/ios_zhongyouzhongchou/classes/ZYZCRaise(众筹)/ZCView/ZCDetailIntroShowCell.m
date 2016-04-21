//
//  ZCDetailIntroShowCell.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/4/20.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "ZCDetailIntroShowCell.h"
#import "ZCDetailIntroFirstCell.h"
#import "ZCDetailIntroSecondCell.h"
#import "ZCDetailIntroThirdCell.h"
@implementation ZCDetailIntroShowCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)configUI
{
    self.cellTable=[[UITableView alloc]initWithFrame:CGRectMake(0, KCORNERRADIUS, KSCREEN_H, ZCDETAIL_INTROSHOW_HEIGHT-KCORNERRADIUS) style:UITableViewStylePlain];
    self.cellTable.dataSource=self;
    self.cellTable.delegate=self;
    self.cellTable.scrollEnabled=NO;
    self.cellTable.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.cellTable.tableFooterView=[[UIView alloc]init];
    self.cellTable.backgroundColor=[UIColor ZYZC_BgGrayColor];
    [self.contentView addSubview:self.cellTable];
}

-(NSInteger ) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==0)
    {
        NSString *cellId01=@"introFirstCell";
        ZCDetailIntroFirstCell *introFirstCell=[tableView dequeueReusableCellWithIdentifier:cellId01];
        if (!introFirstCell) {
            introFirstCell= [[ZCDetailIntroFirstCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId01];
        }
        introFirstCell.layer.cornerRadius=KCORNERRADIUS;
        return introFirstCell;
    }
    else if (indexPath.row == 2)
    {
        NSString *cellId02=@"introSecondCell";
        ZCDetailIntroSecondCell *introSecondCell=[tableView dequeueReusableCellWithIdentifier:cellId02];
        if (!introSecondCell) {
            introSecondCell= [[ZCDetailIntroSecondCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId02];
        }
        return introSecondCell;
    }
    else if (indexPath.row == 4)
    {
        NSString *cellId03=@"introThirdCell";
        ZCDetailIntroThirdCell *introThirdCell=[tableView dequeueReusableCellWithIdentifier:cellId03];
        if (!introThirdCell) {
            introThirdCell= [[ZCDetailIntroThirdCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId03];
        }
        return introThirdCell;
        
    }

    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.contentView.backgroundColor=[UIColor ZYZC_BgGrayColor];
    return cell;
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return ZCDETAILINTRO_FIRSTCELL_HEIGHT;
    }
    else if (indexPath.row == 2)
    {
        return ZCDETAILINTRO_SECONDCELL_HEIGHT;
    }
    else if (indexPath.row == 4)
    {
        return ZCDETAILINTRO_THIRDCELL_HEIGHT;
    }
    else
    {
        return KEDGE_DISTANCE;
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
}

@end
