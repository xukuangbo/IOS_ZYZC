//
//  MinePersonSetUpFirstCell.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/5/24.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "MinePersonSetUpFirstCell.h"
@interface MinePersonSetUpFirstCell()<UITextFieldDelegate>

@end
@implementation MinePersonSetUpFirstCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor ZYZC_BgGrayColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        //背景白图
        CGFloat bgImageViewX = KEDGE_DISTANCE;
        CGFloat bgImageViewY = SetUpFirstCellTopMargin;
        CGFloat bgImageViewW = KSCREEN_W - 2 * bgImageViewX;
        CGFloat bgImageViewH = 0;
        UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(bgImageViewX, bgImageViewY, bgImageViewW, bgImageViewH)];
        bgImageView.userInteractionEnabled = YES;
        [self.contentView addSubview:bgImageView];
        self.bgImageView = bgImageView;
        
        //姓名标题
        CGFloat nameTitleX = KEDGE_DISTANCE;
        CGFloat nameTitleY = KEDGE_DISTANCE;
        CGFloat nameTitleW = (bgImageViewW - nameTitleX * 2) * 0.3;
        CGFloat nameTitleH = SetUpFirstCellLabelHeight;
        UILabel *nameTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameTitleX, nameTitleY, nameTitleW, nameTitleH)];
        nameTitleLabel.text = @"姓名";
        
        UITextField *titleView = [[UITextField alloc] init];
        titleView.clearsOnBeginEditing = YES;
        titleView.delegate = self;
        self.nameTextField = titleView;
        [self createUIWithSuperView:bgImageView titleLabel:nameTitleLabel titleView:titleView];
        
        //生日标题
        CGFloat birthdayLabelX = KEDGE_DISTANCE;
        CGFloat birthdayLabelY = nameTitleLabel.bottom;
        CGFloat birthdayLabelW = (bgImageViewW - nameTitleX * 2) * 0.3;
        CGFloat birthdayLabelH = SetUpFirstCellLabelHeight;
        UILabel *birthdayLabel = [[UILabel alloc] initWithFrame:CGRectMake(birthdayLabelX, birthdayLabelY, birthdayLabelW, birthdayLabelH)];
        birthdayLabel.text = @"生日";
        UIButton *birthButton = [[UIButton alloc] init];
        self.birthButton = birthButton;
        [self createUIWithSuperView:bgImageView titleLabel:birthdayLabel titleView:birthButton];
        
        //省会标题
        CGFloat proviceLabelX = KEDGE_DISTANCE;
        CGFloat proviceLabelY = birthButton.bottom;
        CGFloat proviceLabelW = (bgImageViewW - nameTitleX * 2) * 0.3;
        CGFloat proviceLabelH = SetUpFirstCellLabelHeight;
        UILabel *proviceLabel = [[UILabel alloc] initWithFrame:CGRectMake(proviceLabelX, proviceLabelY, proviceLabelW, proviceLabelH)];
        proviceLabel.text = @"地区";
        UIButton *proviceButton = [[UIButton alloc] init];
        self.proviceButton = proviceButton;
        [self createUIWithSuperView:bgImageView titleLabel:proviceLabel titleView:proviceButton];
        
        //身高标题
        CGFloat heightLabelX = KEDGE_DISTANCE;
        CGFloat heightLabelY = proviceButton.bottom;
        CGFloat heightLabelW = (bgImageViewW - heightLabelX * 2) * 0.3;
        CGFloat heightLabelH = SetUpFirstCellLabelHeight;
        UILabel *heightLabel = [[UILabel alloc] initWithFrame:CGRectMake(heightLabelX, heightLabelY, heightLabelW, heightLabelH)];
        heightLabel.text = @"身高";
        UIButton *heightButton = [[UIButton alloc] init];
        self.heightButton = heightButton;
        [self createUIWithSuperView:bgImageView titleLabel:heightLabel titleView:heightButton];
        
        //体重标题
        CGFloat weightLabelX = KEDGE_DISTANCE;
        CGFloat weightLabelY = heightButton.bottom;
        CGFloat weightLabelW = (bgImageViewW - weightLabelX * 2) * 0.3;
        CGFloat weightLabelH = SetUpFirstCellLabelHeight;
        UILabel *weightLabel = [[UILabel alloc] initWithFrame:CGRectMake(weightLabelX, weightLabelY, weightLabelW, weightLabelH)];
        weightLabel.text = @"体重";
        UIButton *weightButton = [[UIButton alloc] init];
        self.weightButton = weightButton;
        [self createUIWithSuperView:bgImageView titleLabel:weightLabel titleView:weightButton];
        
        //婚姻状况标题
        CGFloat marryLabelX = KEDGE_DISTANCE;
        CGFloat marryLabelY = weightLabel.bottom;
        CGFloat marryLabelW = (bgImageViewW - nameTitleX * 2) * 0.3;
        CGFloat marryLabelH = SetUpFirstCellLabelHeight;
        UILabel *marryLabel = [[UILabel alloc] initWithFrame:CGRectMake(marryLabelX, marryLabelY, marryLabelW, marryLabelH)];
        marryLabel.text = @"婚姻状况";
        UIButton *marryButton = [[UIButton alloc] init];
        self.marryButton = marryButton;
        [self createUIWithSuperView:bgImageView titleLabel:marryLabel titleView:marryButton];
        
        //星座标题
        CGFloat constellationLabelX = KEDGE_DISTANCE;
        CGFloat constellationLabelY = marryButton.bottom;
        CGFloat constellationLabelW = (bgImageViewW - nameTitleX * 2) * 0.3;
        CGFloat constellationLabelH = SetUpFirstCellLabelHeight;
        UILabel *constellationLabel = [[UILabel alloc] initWithFrame:CGRectMake(constellationLabelX, constellationLabelY, constellationLabelW, constellationLabelH)];
        constellationLabel.text = @"星座";
        UIButton *constellationButton = [[UIButton alloc] init];
        self.constellationButton = constellationButton;
        [self createUIWithSuperView:bgImageView titleLabel:constellationLabel titleView:constellationButton];
        
        bgImageView.layer.cornerRadius = 5;
        bgImageView.layer.masksToBounds = YES;
        bgImageView.image = KPULLIMG(@"tab_bg_boss0", 5, 0, 5, 0);
        bgImageView.height = SetUpFirstCellBgHeight;
        
    }
    return self;
}

- (void)createUIWithSuperView:(UIView *)superView titleLabel:(UILabel *)titleLabel titleView:(UIView *)titleView
{
    //标题
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [superView addSubview:titleLabel];
    
    CGFloat titleViewX = titleLabel.right;
    CGFloat titleViewY = titleLabel.top;
    CGFloat titleViewW = superView.width - titleLabel.width - KEDGE_DISTANCE * 2;
    CGFloat titleViewH = titleLabel.height;
    
    titleView.frame = CGRectMake(titleViewX, titleViewY, titleViewW, titleViewH);
    [superView addSubview:titleView];
}


#pragma mark - UITextfieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField endEditing:YES];
    return YES;
}
@end
