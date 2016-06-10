//
//  MyReturnTableView.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/6/10.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "MyReturnTableView.h"

#import "ZYZCOneProductCell.h"
#import "ZCProductDetailController.h"

@implementation MyReturnTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self=[super initWithFrame:frame style:style]) {
         self.contentInset=UIEdgeInsetsMake(0, 0, KEDGE_DISTANCE, 0) ;
    }
    return self;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count*2+1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row%2) {
        ZYZCOneProductCell *productCell=(ZYZCOneProductCell *)[ZYZCOneProductCell customTableView:tableView cellWithIdentifier:@"myReturnProductCell" andCellClass:[ZYZCOneProductCell class]];
        productCell.oneModel=self.dataArr[(indexPath.row-1)/2];
        return productCell;
    }
    else
    {
        ZYZCOneProductCell *normalCell=(ZYZCOneProductCell *)[ZYZCOneProductCell createNormalCell];
        return normalCell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row%2) {
        return MY_ZC_CELL_HEIGHT;
    }
    return KEDGE_DISTANCE;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row%2) {
        ZCOneModel  *oneModel=self.dataArr[(indexPath.row-1)/2];
        ZCProductDetailController *detailController=[[ZCProductDetailController alloc]init];
        detailController.hidesBottomBarWhenPushed=YES;
        detailController.oneModel=oneModel;
        detailController.oneModel.productType=ZCDetailProduct;
        detailController.productId=oneModel.product.productId;
        detailController.detailProductType=PersonDetailProduct;
        [self.viewController.navigationController pushViewController:detailController animated:YES];
    }
}

#pragma mark --- 置顶按钮状态变化
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView==self) {
        CGFloat offSetY=scrollView.contentOffset.y;
        if (self.scrollDidScrollBlock) {
            self.scrollDidScrollBlock(offSetY);
        }
    }
}


@end
