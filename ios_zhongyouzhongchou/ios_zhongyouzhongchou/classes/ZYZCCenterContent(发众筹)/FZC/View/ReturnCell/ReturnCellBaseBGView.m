
//
//  ReturnCellBaseBGView.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/3/24.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "ReturnCellBaseBGView.h"
#import "MoreFZCReturnTableView.h"
#import "UIView+GetSuperTableView.h"
#import "ReturnThirdCellTwo.h"
#import "ReturnThirdCell.h"
#import "ReturnFourthCell.h"
@interface ReturnCellBaseBGView ()
@property (nonatomic, weak) UIView *shadowView;
@end

@implementation ReturnCellBaseBGView
+ (instancetype)viewWithRect:(CGRect)frame title:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage desc:(NSString *)desc
{
    return [[self alloc] initWithRect:frame title:title image:image selectedImage:selectedImage desc:desc];
}

- (instancetype)initWithRect:(CGRect)frame title:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage desc:(NSString *)desc
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        //间隙
        //创建图片btn
        UIButton *iconbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        iconbutton.frame = CGRectMake(KEDGE_DISTANCE, KEDGE_DISTANCE, 20, 20);
        [iconbutton setImage:image forState:UIControlStateNormal];
        [iconbutton setImage:selectedImage forState:UIControlStateSelected];
//        iconbutton.enabled = NO;
//        [iconbutton addTarget:self action:@selector(bgEnabledAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:iconbutton];
        self.iconButton = iconbutton;
        
        //创建标题label
        CGFloat titleLabelX = iconbutton.right + KEDGE_DISTANCE;
        CGFloat titleLabelY = iconbutton.top;
        CGFloat titleLabelW = self.width - titleLabelX - KEDGE_DISTANCE;
        CGFloat titleLabelH = iconbutton.height;
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabelX,titleLabelY,titleLabelW,titleLabelH)];
        titleLabel.text = title;
        titleLabel.numberOfLines = 3;
        titleLabel.textColor = [UIColor redColor];
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        //图标点击事件
        UIButton *iconClickButton = [UIButton buttonWithType:UIButtonTypeCustom];
        iconClickButton.frame = CGRectMake(0, 0, titleLabel.right, 40);
        [iconClickButton addTarget:self action:@selector(bgEnabledAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:iconClickButton];
        self.iconClickButton = iconClickButton;
        
        
        //创建一条虚线
        CGFloat lineViewX = iconbutton.left;
        CGFloat lineViewY = iconbutton.bottom + KEDGE_DISTANCE;
        CGFloat lineViewW = self.width - lineViewX * 2;
        CGFloat lineViewH = 1;
        UIView *lineView = [UIView lineViewWithFrame:CGRectMake(lineViewX, lineViewY, lineViewW, lineViewH) andColor:[UIColor ZYZC_LineGrayColor]];
        [self addSubview:lineView];
        self.lineView = lineView;
        
        
        //创建实体内容
        UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(iconbutton.left, lineView.bottom + KEDGE_DISTANCE, lineView.width - iconbutton.width - KEDGE_DISTANCE, 80)];
        descLabel.font = [UIFont systemFontOfSize:14];
//        descLabel.backgroundColor = [UIColor greenColor];
        descLabel.numberOfLines = 3;
        
        descLabel.attributedText=[ZYZCTool setLineDistenceInText:desc];
        //    [descLabel sizeToFit];
        [self addSubview:descLabel];
        self.descLabel = descLabel;
        
        
        //计算高度
        self.image = KPULLIMG(@"tab_bg_boss0", 5, 0, 5, 0);
        
        //创建一个向下的箭头
        CGFloat downButtonWH = 30;
        CGFloat downButtonY = self.height - KEDGE_DISTANCE - downButtonWH;
        CGFloat downButtonX = self.width - KEDGE_DISTANCE - downButtonWH;
        UIButton *downButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [downButton setImage:[UIImage imageNamed:@"btn_xxd"] forState:UIControlStateNormal];
        downButton.frame = CGRectMake(downButtonX, downButtonY, downButtonWH, downButtonWH);
        [downButton addTarget:self action:@selector(downButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        downButton.bottom = descLabel.bottom;
        [self addSubview:downButton];
        self.downButton = downButton;
        
        //放置一块遮盖的view
        CGFloat shadowViewX = 0;
        CGFloat shadowViewY = iconbutton.bottom + 10;
        CGFloat shadowViewW = frame.size.width;
        CGFloat shadowViewH = frame.size.height - shadowViewY;
        UIView *shadowView = [[UIView alloc] initWithFrame:CGRectMake(shadowViewX, shadowViewY, shadowViewW, shadowViewH)];
        [self addSubview:shadowView];
        shadowView.hidden = YES;
        self.shadowView = shadowView;
    }
    
    
    return self;
}

/**
 *  左上角按钮的可点击事件
 */
- (void)bgEnabledAction:(UIButton *)button
{
    NSLog(@"%zd",self.index);
    if (self.index != 3 && self.index != 2) {
        return;
    }

    self.iconButton.selected = !self.iconButton.selected;
    button.selected = !button.selected;
    if (button.selected == YES) {
        
         self.shadowView.hidden = YES;
        
    }else{
        
        [self bringSubviewToFront:self.shadowView];
        self.shadowView.hidden = NO;
    }
    
    //这里要存到单例里面去
    if (self.index == 2) {//说明是第三个cell
        [MoreFZCDataManager sharedMoreFZCDataManager].return_returnPeopleStatus = [NSString stringWithFormat:@"%zd",button.selected];
    }
    //这里要存到单例里面去
    if (self.index == 3) {//说明是第三个celltwo
        [MoreFZCDataManager sharedMoreFZCDataManager].return_returnPeopleStatus01 = [NSString stringWithFormat:@"%zd",button.selected];
    }
    
}

/**
 *  展开button 的点击动作
 */
- (void)downButtonAction:(UIButton *)button
{
    MoreFZCReturnTableView *tableView = ((MoreFZCReturnTableView *)self.getSuperTableView);
    button.selected = !button.selected;
    

    if (self.index == 2) {//第三个cell
         tableView.returnThirdDownbuttonOpen = !tableView.returnThirdDownbuttonOpen;
        if (tableView.returnThirdDownbuttonOpen == YES) {//展开
            tableView.openArray[4] = @1;
            
            tableView.heightArray[4] = @(ReturnThirdCellHeight + 200);
        }else{//收缩
            tableView.openArray[4] = @0;
            tableView.heightArray[4] = @(ReturnThirdCellHeight);
        }
        //先拿到cell
        ReturnThirdCell *cell = (ReturnThirdCell *)self.superview.superview;
        NSIndexPath *path = [tableView indexPathForCell:cell];
        [tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];
    }else if (self.index == 3) {//第三个cell
        tableView.returnThirdDownbuttonOpen = !tableView.returnThirdDownbuttonOpen;
        if (tableView.returnThirdDownbuttonOpen == YES) {//展开
            tableView.openArray[6] = @1;
            
            tableView.heightArray[6] = @(ReturnThirdCellTwoHeight + 200);
        }else{//收缩
            tableView.openArray[6] = @0;
            tableView.heightArray[6] = @(ReturnThirdCellTwoHeight);
        }
        //先拿到cell
        ReturnThirdCellTwo *cell = (ReturnThirdCellTwo *)self.superview.superview;
        NSIndexPath *path = [tableView indexPathForCell:cell];
        [tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (self.index == 4){
        tableView.returnThirdDownbuttonOpen = !tableView.returnThirdDownbuttonOpen;
        
        if (tableView.returnThirdDownbuttonOpen == YES) {//展开
            tableView.openArray[8] = @1;
            tableView.heightArray[8] = @(ReturnFourthCellHeight + 200);
        }else{//收缩
            tableView.openArray[8] = @0;
            tableView.heightArray[8] = @(ReturnFourthCellHeight);
        }
        //先拿到cell
        ReturnFourthCell *cell = (ReturnFourthCell *)self.superview.superview;
//        NSLog(@"%@",self.superview.superview);
        NSIndexPath *path = [tableView indexPathForCell:cell];
        [tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];
    }
    
    
    
    
}



@end
