//
//  ReturnFourthCell.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/3/28.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "ReturnFourthCell.h"
#import "GoalPeoplePickerView.h"
@interface ReturnFourthCell ()
@property (nonatomic, weak) GoalPeoplePickerView *pickerView;

@property (nonatomic, weak) UIButton *lastButton;
/**
 *  用于存放的大view
 */
@property (nonatomic, weak) UIView *bigContentView;
@end
@implementation ReturnFourthCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        ReturnCellBaseBGView *bgImageView = [ReturnCellBaseBGView viewWithRect:CGRectMake(ReturnFourthCellMargin, 0, KSCREEN_W - ReturnFourthCellMargin * 2, ReturnFourthCellHeight) title:@"一起游" image:[UIImage imageNamed:@"btn_xs_one"] selectedImage:nil desc:@"可多次支持，最多可支持众筹剩余金额的ReturnThirdCellMargin0%。\n每支持一元,可与发起人增加1的亲密度。如果众筹失败，支持金额全额退返。\n可多次支持，最多可支持众筹剩余金额的ReturnThirdCellMargin0%。每支持一元,可与发起人增加1的亲密度。如果众筹失败，支持金额全额退返。可多次支持，最多可支持众筹剩余金额的ReturnThirdCellMargin0%。每支持一元,可与发起人增加1的亲密度。如果众筹失败，支持金额全额退返。可多次支    持，最多可支持众筹剩余金额的ReturnThirdCellMargin0%。每支持一元,可与发起人增加1的亲密度。如果众筹失败，支持金额全额退返。可多次支持，最多可支持众筹剩余金额的ReturnThirdCellMargin0%。每支持一元,可与发起人增加1的亲密度。如果众筹失败，支持金额全额退返。"];
        [self.contentView addSubview:bgImageView];
        self.bgImageView = bgImageView;
        self.bgImageView.userInteractionEnabled = YES;
        self.bgImageView.index = 3;
        
        /**
         *  创建大内容视图
         */
        [self createBigContentView];
        /**
         *  这里开始写出游人数
         */
        [self createOutplaypeople];
        /**
         *  支持金额
         */
        [self createMoneyView];
        
        
        
        
    }
    return self;
}

/**
 *  创建大内容视图
 */
- (void)createBigContentView
{
    CGFloat bigContentViewX = 0;
    CGFloat bigContentViewY = self.bgImageView.descLabel.bottom + ReturnFourthCellMargin;
    CGFloat bigContentViewW = self.bgImageView.width;
    CGFloat bigContentViewH = self.bgImageView.height - self.bgImageView.descLabel.bottom - ReturnFourthCellMargin;
    UIView *bigContentView = [[UIView alloc] initWithFrame:CGRectMake(bigContentViewX, bigContentViewY, bigContentViewW, bigContentViewH)];
    [self.bgImageView addSubview:bigContentView];
    self.bigContentView = bigContentView;
}

/**
 *  这里开始写出游人数
 */
- (void)createOutplaypeople
{
    //这里开始写出游人数
    //1.灰色虚线
    UIView *outPeoplelineView = [UIView lineViewWithFrame:CGRectMake(KEDGE_DISTANCE, 0, self.bigContentView.width-2*KEDGE_DISTANCE, 1) andColor:[UIColor ZYZC_LineGrayColor]];
    [self.bigContentView addSubview:outPeoplelineView];
    //2.1创建人数设置
    UILabel *entryTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(ReturnFourthCellMargin, outPeoplelineView.bottom, self.bgImageView.width - ReturnFourthCellMargin * 2, 30)];
    entryTitleLabel.text = @"出游人数:";
    [self.bigContentView addSubview:entryTitleLabel];
    
    //人数设置封装的view,给个属性接收
    GoalPeoplePickerView *pickerView = [[GoalPeoplePickerView alloc] initWithFrame:CGRectMake(ReturnFourthCellMargin, entryTitleLabel.bottom, 0, 0)];
    //读取第二个界面的人数
    if ([MoreFZCDataManager sharedMoreFZCDataManager].numberPeople) {
        pickerView.numberPeople = [MoreFZCDataManager sharedMoreFZCDataManager].numberPeople;
    }else{
        pickerView.numberPeople = 4;
    }
    self.pickerView = pickerView;
    [self.bigContentView addSubview:pickerView];
    
    
}
/**
 *  支持金额
 */
- (void)createMoneyView
{
    //1.灰色虚线
    UIView *outPeoplelineView = [UIView lineViewWithFrame:CGRectMake(ReturnFourthCellMargin, self.pickerView.bottom + 10, self.bigContentView.width - ReturnFourthCellMargin * 2, 1) andColor:[UIColor ZYZC_LineGrayColor]];
    [self.bigContentView addSubview:outPeoplelineView];
    //2.1创建金额设置
    UILabel *entryTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(ReturnFourthCellMargin, outPeoplelineView.bottom, self.bigContentView.width - ReturnFourthCellMargin * 2, 30)];
    entryTitleLabel.text = @"支持金额";
//    entryTitleLabel.backgroundColor = [UIColor redColor];
    [self.bigContentView addSubview:entryTitleLabel];
    
    //这里创建一个view是那种view
    UIImageView *peopleMoneyView = [[UIImageView alloc] initWithFrame:CGRectMake(ReturnFourthCellMargin , entryTitleLabel.bottom, self.bigContentView.width - ReturnFourthCellMargin * 2, 40)];
    peopleMoneyView.image = [UIImage imageNamed:@"jdt_zer"];
    peopleMoneyView.height = (CGFloat)peopleMoneyView.image.size.height / peopleMoneyView.image.size.width * peopleMoneyView.width;
    peopleMoneyView.userInteractionEnabled = YES;
    //添加4个button
    CGFloat buttonW = peopleMoneyView.width * 0.25;
    CGFloat buttonH = peopleMoneyView.height;
    for (int i = 0; i < 4; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(buttonW * i, 0, buttonW, buttonH);
        button.showsTouchWhenHighlighted = YES;
        button.tag = i;
        [peopleMoneyView addSubview:button];
        //设置最开始的lastbutton
        if (i == 0) {
            self.lastButton = button;
        }
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    self.peopleMoneyView = peopleMoneyView;
    [self.bigContentView addSubview:peopleMoneyView];
    
    //最后一个，金额的显示
    UILabel *moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bgImageView.width, 40)];
    moneyLabel.centerX = peopleMoneyView.centerX;
    moneyLabel.centerY = peopleMoneyView.bottom + 0.5 * moneyLabel.height;
//    moneyLabel.backgroundColor = [UIColor redColor];
    self.moneyLabel = moneyLabel;
    moneyLabel.textAlignment = NSTextAlignmentCenter;
    [self.bigContentView addSubview:moneyLabel];
    
    //先看看有没有单例有没有值
    NSInteger returnCellSupportButton = [MoreFZCDataManager sharedMoreFZCDataManager].returnCellSupportButton;
    
    //这里是为了给他一个初始值
    [self changeMoneyCountByTag:returnCellSupportButton];
}

/**
 *  根据给的tag值去改变图片
 */
- (void)changeMoneyCountByTag:(NSInteger)tag
{
    
    switch (tag) {
        case 0:
            self.peopleMoneyView.image = [UIImage imageNamed:@"jdt_zer"];
            break;
        case 1:
            self.peopleMoneyView.image = [UIImage imageNamed:@"jdt_fiv"];
            break;
        case 2:
            self.peopleMoneyView.image = [UIImage imageNamed:@"jdt_ten"];
            break;
        case 3:
            self.peopleMoneyView.image = [UIImage imageNamed:@"jdt_fif"];
            break;
        default:
            break;
    }
    //百分比
    CGFloat f = tag * 0.05;
    //这里应该改变文字
    CGFloat returnMoneyCount = [MoreFZCDataManager sharedMoreFZCDataManager].raiseMoneyCountText * f;
    
    NSString *moneyString = [NSString stringWithFormat:@"￥ %.2f 元",returnMoneyCount];
    [self changeMoneyLabelStringWithString:moneyString];
    
}

- (void)reloadManagerData
{
    MoreFZCDataManager *mgr = [MoreFZCDataManager sharedMoreFZCDataManager];
    if (mgr.numberPeople) {
        self.pickerView.numberPeople = mgr.numberPeople;
    }
    if (mgr.returnCellSupportButton) {
        [self changeMoneyCountByTag:mgr.returnCellSupportButton];
    }
}

- (void)setOpen:(BOOL)open
{
    if (_open != open) {
        _open = open;
        
        if (open == YES) {
            //这里就是展开，改变所有东西的值
            self.bgImageView.height = ReturnFourthCellHeight + 200;
            self.bgImageView.descLabel.numberOfLines = 0;
            self.bgImageView.descLabel.height = 290;
            self.bgImageView.downButton.bottom = self.bgImageView.descLabel.bottom;
            //            self.bgImageView.downButton.hidden = YES;
            
            self.bigContentView.top = self.bgImageView.descLabel.bottom + ReturnFourthCellMargin;
            
        }else{
            self.bgImageView.height = ReturnFourthCellHeight;
            self.bgImageView.descLabel.numberOfLines = 3;
            self.bgImageView.descLabel.height = 90;
            self.bgImageView.downButton.bottom = self.bgImageView.descLabel.bottom;
            self.bigContentView.top = self.bgImageView.descLabel.bottom + ReturnFourthCellMargin;
        }
    }
}

/**
 *  选金额的点击效果
 */
- (void)buttonAction:(UIButton *)button
{
    if (self.lastButton == button) {
        return;
    }
    [self changeMoneyCountByTag:button.tag];
    self.lastButton = button;
    [MoreFZCDataManager sharedMoreFZCDataManager].returnCellSupportButton = button.tag;
}

/**
 *  显示label的金钱数字
 */
- (void)changeMoneyLabelStringWithString:(NSString *)string
{
//    NSLog(@"%ld",string.length);
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:string];
    [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, 1)];
    [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(attrString.length - 1, 1)];
    [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(attrString.length - 1, 1)];
    [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(2, string.length - 4)];
    self.moneyLabel.attributedText = attrString;
    
    
}

@end
