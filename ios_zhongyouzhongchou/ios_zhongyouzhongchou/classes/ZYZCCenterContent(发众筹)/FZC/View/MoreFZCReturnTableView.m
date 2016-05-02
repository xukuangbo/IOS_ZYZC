//
//  MoreFZCReturnTableView.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/3/17.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "MoreFZCReturnTableView.h"
#import "ReturnFirstCell.h"
#import "ReturnSecondCell.h"
#import "ReturnThirdCell.h"
#import "ReturnThirdCellTwo.h"
#import "ReturnFourthCell.h"
#import "MoreFZCViewController.h"
@interface MoreFZCReturnTableView ()

@end

@implementation MoreFZCReturnTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataSource =self;
        self.delegate  = self;
        self.backgroundColor = [UIColor ZYZC_BgGrayColor];
        
    }
    return self;
}

- (NSMutableArray *)openArray
{
    if (!_openArray) {
        _openArray = [NSMutableArray arrayWithArray:@[@0,@0,@0,@0,@0,@0,@0,@0,@0,@0]];
    }
    return _openArray;
}

/**
 *  初始化数组高度
 */
- (NSArray *)heightArray
{
    if (!_heightArray) {
        _heightArray = [NSMutableArray arrayWithArray:@[@150,@10,@150,@10,@ReturnThirdCellHeight,@10,@ReturnThirdCellTwoHeight,@10,@ReturnFourthCellHeight,@10]] ;
    }
    return _heightArray;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1 || indexPath.row == 3 || indexPath.row == 5 || indexPath.row == 7 || indexPath.row == 9 ) {
        
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        
        return cell;
    }else if (indexPath.row == 0){
        ReturnFirstCell *cell = [self dequeueReusableCellWithIdentifier:@"ReturnFirstCell"];
        if (!cell) {
            cell = [[ReturnFirstCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ReturnFirstCell"];
        }
        cell.open = [self.openArray[indexPath.row] floatValue];
        return cell;
    }else if(indexPath.row == 2){
        ReturnSecondCell *cell = [self dequeueReusableCellWithIdentifier:@"ReturnSecondCell"];
        if (!cell) {
            cell = [[ReturnSecondCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ReturnSecondCell"];
        }
        cell.open = [self.openArray[indexPath.row] floatValue];
        return cell;
    }else if(indexPath.row == 4){
        NSString *cellId=@"ReturnThirdCell";
        ReturnThirdCell *cell = [self dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[ReturnThirdCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.open = [self.openArray[indexPath.row] floatValue];
        [cell reloadManagerData];
        return cell;
    }else if(indexPath.row == 6){
        NSString *cellId=@"ReturnThirdCellTwo";
        ReturnThirdCellTwo *cell = [self dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
            cell = [[ReturnThirdCellTwo alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        }
        cell.open = [self.openArray[indexPath.row] floatValue];
        [cell reloadManagerData];
        return cell;
    }else{
        ReturnFourthCell *cell = [self dequeueReusableCellWithIdentifier:@"ReturnFourthCell"];
        if (!cell) {
            cell = [[ReturnFourthCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ReturnFourthCell"];
        }
        [cell reloadManagerData];
        cell.open = [self.openArray[indexPath.row] floatValue];
        return cell;
    }
   
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.heightArray[indexPath.row] floatValue];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        CGFloat height = [self.heightArray[indexPath.row] floatValue];
        if (height == 150) {
            //这里要改变里面的内容
            self.heightArray[indexPath.row] = @350;
            self.openArray[indexPath.row] = @1;
        }else
        {
            self.heightArray[indexPath.row] = @150;
             self.openArray[indexPath.row] = @0;
        }
       [self reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }else if (indexPath.row == 2){//这个是第二个cell
        CGFloat height = [self.heightArray[indexPath.row] floatValue];
        if (height == 150) {
            //这里要改变里面的内容
            self.heightArray[indexPath.row] = @350;
            self.openArray[indexPath.row] = @1;
        }else
        {
            self.heightArray[indexPath.row] = @150;
            self.openArray[indexPath.row] = @0;
        }
        [self reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (indexPath.row == 4){//这个是第三个cell
//        CGFloat height = [self.heightArray[indexPath.row] floatValue];
//        if (height == 150) {
//            //这里要改变里面的内容
//            self.heightArray[indexPath.row] = @350;
//            self.openArray[indexPath.row] = @1;
//        }else
//        {
//            self.heightArray[indexPath.row] = @150;
//            self.openArray[indexPath.row] = @0;
//        }
        //这是回报众筹,点击的时候要让键盘弹回去
        ReturnThirdCell *cell = [self cellForRowAtIndexPath:indexPath];
        [cell.moneyTextFiled endEditing:YES];
        [cell.peopleTextfiled endEditing:YES];
    }
    else if (indexPath.row == 6){//这个是第三个cell
        //        CGFloat height = [self.heightArray[indexPath.row] floatValue];
        //        if (height == 150) {
        //            //这里要改变里面的内容
        //            self.heightArray[indexPath.row] = @350;
        //            self.openArray[indexPath.row] = @1;
        //        }else
        //        {
        //            self.heightArray[indexPath.row] = @150;
        //            self.openArray[indexPath.row] = @0;
        //        }
        //这是回报众筹,点击的时候要让键盘弹回去
        ReturnThirdCellTwo *cell = [self cellForRowAtIndexPath:indexPath];
        [cell.moneyTextFiled endEditing:YES];
        [cell.peopleTextfiled endEditing:YES];
    }
}
@end
