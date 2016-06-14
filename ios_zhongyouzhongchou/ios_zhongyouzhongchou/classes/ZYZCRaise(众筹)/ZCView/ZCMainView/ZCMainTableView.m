//
//  ZCMainTableView.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/6/8.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "ZCMainTableView.h"

#import "ZYZCOneProductCell.h"

#import "ZCProductDetailController.h"

@implementation ZCMainTableView

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
        ZYZCOneProductCell *productCell=(ZYZCOneProductCell *)[ZYZCOneProductCell customTableView:tableView cellWithIdentifier:@"productCell" andCellClass:[ZYZCOneProductCell class]];
        productCell.oneModel.productType=ZCListProduct;
        productCell.oneModel=self.dataArr[(indexPath.row-1)/2];
        return productCell;
    }
    else
    {
        UITableViewCell *normalCell=[ZYZCBaseTableViewCell createNormalCell];
        return normalCell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row%2) {
        return PRODUCT_CELL_HEIGHT;
    }
    return KEDGE_DISTANCE;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row%2) {
        //推出信息详情页
        ZCProductDetailController *productDetailVC=[[ZCProductDetailController alloc]init];
        productDetailVC.detailProductType=PersonDetailProduct;
        productDetailVC.hidesBottomBarWhenPushed=YES;
        ZCOneModel *oneModel=self.dataArr[indexPath.row/2];
        productDetailVC.oneModel=oneModel;
        productDetailVC.oneModel.productType=ZCDetailProduct;
        productDetailVC.productId=oneModel.product.productId;
        productDetailVC.detailProductType=PersonDetailProduct;
        [self.viewController.navigationController pushViewController:productDetailVC animated:YES];
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
