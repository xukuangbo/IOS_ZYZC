//
//  MoreFZCTravelTableView.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/3/17.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "MoreFZCTravelTableView.h"
#import "NSDate+RMCalendarLogic.h"
@implementation MoreFZCTravelTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        _rowsChangeHeight=[NSMutableDictionary dictionary];
        _travelDetailCellArr=[NSMutableArray array];
        _travelDays=1;
        self.dataSource =self;
        self.delegate   =self;
    }
    return self;
}

#pragma mark --- 获取总的行程时间
-(void)getTravelDays
{
    MoreFZCDataManager *manager=[MoreFZCDataManager sharedMoreFZCDataManager];
    _travelDays=[manager.goal_TotalTravelDay integerValue];
    if (_travelDetailCellArr.count) {
        [_travelDetailCellArr removeAllObjects];
    }
   
    for (int i=0; i<_travelDays; i++) {
        TravelSecondCell *secondCell=[[TravelSecondCell alloc]init];
        secondCell.oneDetailModel.day=[NSNumber numberWithInt:i+1];
        if (manager.travelDetailDays.count) {
            for (MoreFZCTravelOneDayDetailMdel *model in manager.travelDetailDays) {
                if ([model.day integerValue]==i+1) {
                    secondCell.oneDetailModel=model;
                }
            }
        }
        [_travelDetailCellArr addObject:secondCell];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [self getTravelDays];
    
    return 2+_travelDays*2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        TravelFirstCell *travelFirstCell=[tableView dequeueReusableCellWithIdentifier:@"travelFirstCell"];
        if (!travelFirstCell) {
            travelFirstCell=[[TravelFirstCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"travelFirstCell"];
        }
        [travelFirstCell reloadTravelData];
        return travelFirstCell;
    }
    else if(indexPath.row%2==0)
    {
        NSInteger cellNumber=indexPath.row/2;
        NSString *cellId=[NSString stringWithFormat:@"travelSecondCell%zd",indexPath.row/2];
        TravelSecondCell *travelSecondCell=[tableView dequeueReusableCellWithIdentifier:cellId];
        if (!travelSecondCell) {
            travelSecondCell=[[TravelSecondCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        __weak typeof (&*self)weakSelf=self;
        travelSecondCell.reloadTableBlock=^(BOOL isChangeHeight)
        {
            MoreFZCDataManager *manager=[MoreFZCDataManager sharedMoreFZCDataManager];
            [manager.travelDetailDays removeAllObjects];
            for (NSInteger i=0; i<weakSelf.travelDetailCellArr.count; i++) {
                TravelSecondCell *travelSecondCell=weakSelf.travelDetailCellArr[i];
                [travelSecondCell saveTravelOneDayDetailData];
                NSDictionary *modelDict = travelSecondCell.oneDetailModel.mj_keyValues;
                if (modelDict.count>3) {
                    [manager.travelDetailDays addObject:travelSecondCell.oneDetailModel];
                }
            }
            [weakSelf.rowsChangeHeight setObject:[NSNumber numberWithBool:isChangeHeight] forKey:[NSNumber numberWithInteger:indexPath.row]];
            
            [tableView reloadData];
        };
        
        MoreFZCDataManager *manager=[MoreFZCDataManager sharedMoreFZCDataManager];
        if (manager.travelDetailDays.count) {
            for (MoreFZCTravelOneDayDetailMdel *model in manager.travelDetailDays) {
                if ([model.day integerValue]==cellNumber) {
                    travelSecondCell.oneDetailModel=model;
                }
            }
        }
        
        travelSecondCell.titleLab.text=[NSString stringWithFormat:@"第%.2zd天:",indexPath.row/2];
        travelSecondCell.oneDetailModel.day=[NSNumber numberWithInteger:indexPath.row/2];
        travelSecondCell.contentBelong=TRAVEL_CONTENTBELONG(indexPath.row/2);
        return travelSecondCell;
    }
    else
    {
        UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor=[UIColor ZYZC_BgGrayColor];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return TRAVELFIRSTCELLHEIGHT;
    }
    else if(indexPath.row%2==0)
    {
        NSNumber *numberRow=[NSNumber numberWithInteger:indexPath.row];
        NSNumber *isChangeHeight=self.rowsChangeHeight[numberRow];
        if ([isChangeHeight boolValue]) {
            return TRAVELSECONDCELLHEIGHT+TRAVELOPENHEIGHT;
        }
        else
        {
            return TRAVELSECONDCELLHEIGHT;
        }
    }
    else
    {
        return KEDGE_DISTANCE;
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row%2==0&&indexPath.row>0) {
        [_travelDetailCellArr replaceObjectAtIndex:indexPath.row/2-1 withObject:cell];
    }
}

@end
