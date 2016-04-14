//
//  MoreFZCRaiseMoneyTableView.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/3/17.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "MoreFZCRaiseMoneyTableView.h"
@interface MoreFZCRaiseMoneyTableView ()


@end
@implementation MoreFZCRaiseMoneyTableView


- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataSource =self;
        self.delegate  = self;
//        self.contentInset = UIEdgeInsetsMake(64 + 50 + 20, 0, 0, 0);
    }
    return self;
}


- (NSMutableArray *)realHeightArray
{
    if (_realHeightArray == nil) {
        _realHeightArray = [NSMutableArray arrayWithArray:@[@10,@10,@10,@10]];
    }
    return _realHeightArray;
}

/**
 *  firstModel
 */
- (RaiseMoneyFirstModel *)firstModel
{
    if (_firstModel == nil) {
        _firstModel = [[RaiseMoneyFirstModel alloc] init];
        _firstModel.openButtonSelected = NO;
        _firstModel.realHeight = _firstModel.bgImageHeight = 120;
        _firstModel.totalMoney = @"0.00 元";
        _firstModel.detailViewHeight = 60;
        _firstModel.moneyTextfliedBottom = _firstModel.detailViewHeight - 10;
        _firstModel.sightTextfiledHidden = YES;
//        _firstModel.sightMoney = @"点击可以更改文字哦~";
//        _firstModel.transMoney = @"点击可以更改文字哦~";
//        _firstModel.liveMoney = @"点击可以更改文字哦~";
//        _firstModel.eatMoney = @"点击可以更改文字哦~";
    }
    
    
    return _firstModel;
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //0 2 4灰色空白视图
    if (indexPath.row == 1 ||indexPath.row ==3) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"noneCell"];
        cell.contentView.backgroundColor = [UIColor ZYZC_BgGrayColor];
        return cell;
    }else if(indexPath.row == 0){
        
        MoreFZCRaiseMoneyFirstCell *cell = [[MoreFZCRaiseMoneyFirstCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"firstCell"];
        if (!self.firstModel) {
            self.firstModel = cell.model;
        }
        cell.model = self.firstModel;
        //block的定义
        __weak typeof(&*self) weakSelf = self;
        __weak typeof(&*cell) weakCell = cell;
        
        cell.changeHeightBlock = ^(RaiseMoneyFirstModel *model){
            //先添加到数组中，再刷新数据
            weakSelf.firstModel = model;
            //此方法拿到该cell,此时要刷新cell的数据
            [weakSelf reloadRowsAtIndexPaths:@[[weakSelf indexPathForCell:weakCell]] withRowAnimation:UITableViewRowAnimationNone];
            
        };
        return cell;
    }else{//这里是第二个cell
        NSString *cellId=@"MoreFZCRaiseMoneySecondCell";
        MoreFZCRaiseMoneySecondCell *cell = [[MoreFZCRaiseMoneySecondCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.soundFileName=cellId;

        return cell;
        
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {//第1中cell
        return self.firstModel.realHeight;
    }else if (indexPath.row == 2){//第二种cell
        return RAISECECONDHEIGHT;
    }
    return [self.realHeightArray[indexPath.row] floatValue];
    
}






@end
