//
//  MinePersonSetUpScrollView.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/5/25.
//  Copyright © 2016年 liuliang. All rights reserved.

#import "MinePersonSetUpScrollView.h"
#import "MinePersonSetUpHeadView.h"
#import "MinePersonSetUpModel.h"
#define SetUpFirstCellLabelHeight 34
@interface MinePersonSetUpScrollView()<UITextFieldDelegate>
@property (nonatomic, strong) UIImageView *firstBg;
@property (nonatomic, strong) UIImageView *secondBg;
@property (nonatomic, strong) UIImageView *thirdBg;
@property (nonatomic, strong) UIImageView *fourthBg;
@property (nonatomic, strong) UIImageView *fifthBg;
@end
@implementation MinePersonSetUpScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
        
        
    }
    return self;
}

- (void)createUI
{
    //头视图
     MinePersonSetUpHeadView *headView = [[MinePersonSetUpHeadView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_W, imageHeadHeight)];
    self.headView = headView;
    [self addSubview:headView];
    
    //第一个表格
    [self createFirstUI];
    
    [self createSecondUI];
    
    [self createThirdUI];
    
    [self createFourthUI];
    
    [self createFifthUI];
    self.contentSize = CGSizeMake(KSCREEN_W, self.fifthBg.bottom + KEDGE_DISTANCE);
    NSLog(@"%@",NSStringFromCGSize(self.contentSize));
}

/**
 *  第一个cell
 */
- (void)createFirstUI
{
    //背景白图
    CGFloat bgImageViewX = KEDGE_DISTANCE;
    CGFloat bgImageViewY = self.headView.bottom + KEDGE_DISTANCE;
    CGFloat bgImageViewW = KSCREEN_W - 2 * bgImageViewX;
    CGFloat bgImageViewH = 0;
    self.firstBg = [[UIImageView alloc] initWithFrame:CGRectMake(bgImageViewX, bgImageViewY, bgImageViewW, bgImageViewH)];
    self.firstBg.userInteractionEnabled = YES;
    [self addSubview:self.firstBg];
    
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
    [self createUIWithSuperView:self.firstBg titleLabel:nameTitleLabel titleView:titleView];
    //性别
    CGFloat sexX = KEDGE_DISTANCE;
    CGFloat sexY = nameTitleLabel.bottom;
    CGFloat sexW = (bgImageViewW - nameTitleX * 2) * 0.3;
    CGFloat sexH = SetUpFirstCellLabelHeight;
    UILabel *sexLabel = [[UILabel alloc] initWithFrame:CGRectMake(sexX, sexY, sexW, sexH)];
    sexLabel.text = @"性别";
    
    UIButton *sexButton = [[UIButton alloc] init];
    sexButton.userInteractionEnabled = NO;
    self.sexButton = sexButton;
    [self createUIWithSuperView:self.firstBg titleLabel:sexLabel titleView:sexButton];
    
    //生日标题
    CGFloat birthdayLabelX = KEDGE_DISTANCE;
    CGFloat birthdayLabelY = sexButton.bottom;
    CGFloat birthdayLabelW = (bgImageViewW - nameTitleX * 2) * 0.3;
    CGFloat birthdayLabelH = SetUpFirstCellLabelHeight;
    UILabel *birthdayLabel = [[UILabel alloc] initWithFrame:CGRectMake(birthdayLabelX, birthdayLabelY, birthdayLabelW, birthdayLabelH)];
    birthdayLabel.text = @"生日";
    UIButton *birthButton = [[UIButton alloc] init];
    self.birthButton = birthButton;
    [self createUIWithSuperView:self.firstBg titleLabel:birthdayLabel titleView:birthButton];
    
//    //省会标题
//    CGFloat proviceLabelX = KEDGE_DISTANCE;
//    CGFloat proviceLabelY = birthButton.bottom;
//    CGFloat proviceLabelW = (bgImageViewW - nameTitleX * 2) * 0.3;
//    CGFloat proviceLabelH = SetUpFirstCellLabelHeight;
//    UILabel *proviceLabel = [[UILabel alloc] initWithFrame:CGRectMake(proviceLabelX, proviceLabelY, proviceLabelW, proviceLabelH)];
//    proviceLabel.text = @"地区";
//    UIButton *proviceButton = [[UIButton alloc] init];
//    self.proviceButton = proviceButton;
//    [self createUIWithSuperView:self.firstBg titleLabel:proviceLabel titleView:proviceButton];
//    
//    //身高标题
//    CGFloat heightLabelX = KEDGE_DISTANCE;
//    CGFloat heightLabelY = proviceButton.bottom;
//    CGFloat heightLabelW = (bgImageViewW - heightLabelX * 2) * 0.3;
//    CGFloat heightLabelH = SetUpFirstCellLabelHeight;
//    UILabel *heightLabel = [[UILabel alloc] initWithFrame:CGRectMake(heightLabelX, heightLabelY, heightLabelW, heightLabelH)];
//    heightLabel.text = @"身高";
//    UIButton *heightButton = [[UIButton alloc] init];
//    self.heightButton = heightButton;
//    [self createUIWithSuperView:self.firstBg titleLabel:heightLabel titleView:heightButton];
//    
//    //体重标题
//    CGFloat weightLabelX = KEDGE_DISTANCE;
//    CGFloat weightLabelY = heightButton.bottom;
//    CGFloat weightLabelW = (bgImageViewW - weightLabelX * 2) * 0.3;
//    CGFloat weightLabelH = SetUpFirstCellLabelHeight;
//    UILabel *weightLabel = [[UILabel alloc] initWithFrame:CGRectMake(weightLabelX, weightLabelY, weightLabelW, weightLabelH)];
//    weightLabel.text = @"体重";
//    UIButton *weightButton = [[UIButton alloc] init];
//    self.weightButton = weightButton;
//    [self createUIWithSuperView:self.firstBg titleLabel:weightLabel titleView:weightButton];
//    
//    //婚姻状况标题
//    CGFloat marryLabelX = KEDGE_DISTANCE;
//    CGFloat marryLabelY = weightLabel.bottom;
//    CGFloat marryLabelW = (bgImageViewW - nameTitleX * 2) * 0.3;
//    CGFloat marryLabelH = SetUpFirstCellLabelHeight;
//    UILabel *marryLabel = [[UILabel alloc] initWithFrame:CGRectMake(marryLabelX, marryLabelY, marryLabelW, marryLabelH)];
//    marryLabel.text = @"婚姻状况";
//    UIButton *marryButton = [[UIButton alloc] init];
//    self.marryButton = marryButton;
//    [self createUIWithSuperView:self.firstBg titleLabel:marryLabel titleView:marryButton];
    
    //星座标题
    CGFloat constellationLabelX = KEDGE_DISTANCE;
    CGFloat constellationLabelY = birthButton.bottom;
    CGFloat constellationLabelW = (bgImageViewW - nameTitleX * 2) * 0.3;
    CGFloat constellationLabelH = SetUpFirstCellLabelHeight;
    UILabel *constellationLabel = [[UILabel alloc] initWithFrame:CGRectMake(constellationLabelX, constellationLabelY, constellationLabelW, constellationLabelH)];
    constellationLabel.text = @"星座";
    UITextField *constellationButton = [[UITextField alloc] init];
    constellationButton.delegate = self;
    self.constellationButton = constellationButton;
    [self createUIWithSuperView:self.firstBg titleLabel:constellationLabel titleView:constellationButton];
    
    self.firstBg.layer.cornerRadius = 5;
    self.firstBg.layer.masksToBounds = YES;
    self.firstBg.image = KPULLIMG(@"tab_bg_boss0", 5, 0, 5, 0);
    self.firstBg.height = (SetUpFirstCellLabelHeight * 4 + KEDGE_DISTANCE * 2);
}


- (void)createSecondUI
{
    //背景白图
    CGFloat bgImageViewX = KEDGE_DISTANCE;
    CGFloat bgImageViewY = self.firstBg.bottom + KEDGE_DISTANCE;
    CGFloat bgImageViewW = KSCREEN_W - 2 * bgImageViewX;
    CGFloat bgImageViewH = 0;
    self.secondBg = [[UIImageView alloc] initWithFrame:CGRectMake(bgImageViewX, bgImageViewY, bgImageViewW, bgImageViewH)];
    self.secondBg.userInteractionEnabled = YES;
    [self addSubview:self.secondBg];
    
    //兴趣标题
    CGFloat likeLabelX = KEDGE_DISTANCE;
    CGFloat likeLabelY = KEDGE_DISTANCE;
    CGFloat likeLabelW = (bgImageViewW - likeLabelX * 2) * 0.3;
    CGFloat likeLabelH = SetUpFirstCellLabelHeight;
    UILabel *likeLabel = [[UILabel alloc] initWithFrame:CGRectMake(likeLabelX, likeLabelY, likeLabelW, likeLabelH)];
    likeLabel.text = @"兴趣标签";
    UIButton *likeButton = [[UIButton alloc] init];
    self.likeButton = likeButton;
    [self createUIWithSuperView:self.secondBg titleLabel:likeLabel titleView:likeButton];
    
    self.secondBg.layer.cornerRadius = 5;
    self.secondBg.layer.masksToBounds = YES;
    self.secondBg.image = KPULLIMG(@"tab_bg_boss0", 5, 0, 5, 0);
    self.secondBg.height = (SetUpFirstCellLabelHeight * 1 + KEDGE_DISTANCE * 2);
    
}

- (void)createThirdUI
{
    //背景白图
    CGFloat bgImageViewX = KEDGE_DISTANCE;
    CGFloat bgImageViewY = self.secondBg.bottom + KEDGE_DISTANCE;
    CGFloat bgImageViewW = KSCREEN_W - 2 * bgImageViewX;
    CGFloat bgImageViewH = 0;
    self.thirdBg = [[UIImageView alloc] initWithFrame:CGRectMake(bgImageViewX, bgImageViewY, bgImageViewW, bgImageViewH)];
    self.thirdBg.userInteractionEnabled = YES;
    [self addSubview:self.thirdBg];
    
    //感情状况标题
    CGFloat marryLabelX = KEDGE_DISTANCE;
    CGFloat marryLabelY = KEDGE_DISTANCE;
    CGFloat marryLabelW = (bgImageViewW - marryLabelX * 2) * 0.3;
    CGFloat marryLabelH = SetUpFirstCellLabelHeight;
    UILabel *marryLabel = [[UILabel alloc] initWithFrame:CGRectMake(marryLabelX, marryLabelY, marryLabelW, marryLabelH)];
    marryLabel.text = @"感情状况";

    UIButton *marryButton = [[UIButton alloc] init];
    marryButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.marryButton = marryButton;
    [self createUIWithSuperView:self.thirdBg titleLabel:marryLabel titleView:marryButton];
    
    //身高标题
    CGFloat heightLabelX = KEDGE_DISTANCE;
    CGFloat heightLabelY = marryButton.bottom;
    CGFloat heightLabelW = (bgImageViewW - heightLabelX * 2) * 0.3;
    CGFloat heightLabelH = SetUpFirstCellLabelHeight;
    UILabel *heightLabel = [[UILabel alloc] initWithFrame:CGRectMake(heightLabelX, heightLabelY, heightLabelW, heightLabelH)];
    heightLabel.text = @"身高";
    UIButton *heightButton = [[UIButton alloc] init];
    self.heightButton = heightButton;
    [self createUIWithSuperView:self.thirdBg titleLabel:heightLabel titleView:heightButton];

    //体重标题
    CGFloat weightLabelX = KEDGE_DISTANCE;
    CGFloat weightLabelY = heightButton.bottom;
    CGFloat weightLabelW = (bgImageViewW - weightLabelX * 2) * 0.3;
    CGFloat weightLabelH = SetUpFirstCellLabelHeight;
    UILabel *weightLabel = [[UILabel alloc] initWithFrame:CGRectMake(weightLabelX, weightLabelY, weightLabelW, weightLabelH)];
    weightLabel.text = @"体重";
    UIButton *weightButton = [[UIButton alloc] init];
    self.weightButton = weightButton;
    [self createUIWithSuperView:self.thirdBg titleLabel:weightLabel titleView:weightButton];
    
    self.thirdBg.layer.cornerRadius = 5;
    self.thirdBg.layer.masksToBounds = YES;
    self.thirdBg.image = KPULLIMG(@"tab_bg_boss0", 5, 0, 5, 0);
    self.thirdBg.height = (SetUpFirstCellLabelHeight * 3 + KEDGE_DISTANCE * 2);
}

- (void)createFourthUI
{
    //背景白图
    CGFloat bgImageViewX = KEDGE_DISTANCE;
    CGFloat bgImageViewY = self.thirdBg.bottom + KEDGE_DISTANCE;
    CGFloat bgImageViewW = KSCREEN_W - 2 * bgImageViewX;
    CGFloat bgImageViewH = 0;
    self.fourthBg = [[UIImageView alloc] initWithFrame:CGRectMake(bgImageViewX, bgImageViewY, bgImageViewW, bgImageViewH)];
    self.fourthBg.userInteractionEnabled = YES;
    [self addSubview:self.fourthBg];
    
    //公司标题
    CGFloat companyLabelX = KEDGE_DISTANCE;
    CGFloat companyLabelY = KEDGE_DISTANCE;
    CGFloat companyLabelW = (bgImageViewW - companyLabelX * 2) * 0.3;
    CGFloat companyLabelH = SetUpFirstCellLabelHeight;
    UILabel *companyLabel = [[UILabel alloc] initWithFrame:CGRectMake(companyLabelX, companyLabelY, companyLabelW, companyLabelH)];
    companyLabel.text = @"公司";
    
    UITextField *companyButton = [[UITextField alloc] init];
    companyButton.clearsOnBeginEditing = YES;
    companyButton.delegate = self;
    self.companyButton = companyButton;
    [self createUIWithSuperView:self.fourthBg titleLabel:companyLabel titleView:companyButton];
    //工作
    CGFloat jobLabelX = KEDGE_DISTANCE;
    CGFloat jobLabelY = companyButton.bottom;
    CGFloat jobLabelW = (bgImageViewW - jobLabelX * 2) * 0.3;
    CGFloat jobLabelH = SetUpFirstCellLabelHeight;
    UILabel *jobLabel = [[UILabel alloc] initWithFrame:CGRectMake(jobLabelX, jobLabelY, jobLabelW, jobLabelH)];
    jobLabel.text = @"职业";
    
    UITextField *jobButton = [[UITextField alloc] init];
    jobButton.clearsOnBeginEditing = YES;
    jobButton.delegate = self;
    self.jobButton = jobButton;
    [self createUIWithSuperView:self.fourthBg titleLabel:jobLabel titleView:jobButton];
    
    //学校标题
    CGFloat schoolLabelX = KEDGE_DISTANCE;
    CGFloat schoolLabelY = jobButton.bottom;
    CGFloat schoolLabelW = (bgImageViewW - schoolLabelX * 2) * 0.3;
    CGFloat schoolLabelH = SetUpFirstCellLabelHeight;
    UILabel *schoolLabel = [[UILabel alloc] initWithFrame:CGRectMake(schoolLabelX, schoolLabelY, schoolLabelW, schoolLabelH)];
    schoolLabel.text = @"学校";
    UITextField *schoolButton = [[UITextField alloc] init];
    schoolButton.clearsOnBeginEditing = YES;
    schoolButton.delegate = self;
    self.schoolButton = schoolButton;
    [self createUIWithSuperView:self.fourthBg titleLabel:schoolLabel titleView:schoolButton];
    
    
    //所在地标题
    CGFloat locationLabelX = KEDGE_DISTANCE;
    CGFloat locationLabelY = schoolButton.bottom;
    CGFloat locationLabelW = (bgImageViewW - locationLabelX * 2) * 0.3;
    CGFloat locationLabelH = SetUpFirstCellLabelHeight;
    UILabel *locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(locationLabelX, locationLabelY, locationLabelW, locationLabelH)];
    locationLabel.text = @"所在地";
    UITextField *locationButton = [[UITextField alloc] init];
    self.locationButton = locationButton;
    [self createUIWithSuperView:self.fourthBg titleLabel:locationLabel titleView:locationButton];
    
    self.fourthBg.layer.cornerRadius = 5;
    self.fourthBg.layer.masksToBounds = YES;
    self.fourthBg.image = KPULLIMG(@"tab_bg_boss0", 5, 0, 5, 0);
    self.fourthBg.height = (SetUpFirstCellLabelHeight * 4 + KEDGE_DISTANCE * 2);
}

- (void)createFifthUI
{
    //背景白图
    CGFloat bgImageViewX = KEDGE_DISTANCE;
    CGFloat bgImageViewY = self.fourthBg.bottom + KEDGE_DISTANCE;
    CGFloat bgImageViewW = KSCREEN_W - 2 * bgImageViewX;
    CGFloat bgImageViewH = 0;
    self.fifthBg = [[UIImageView alloc] initWithFrame:CGRectMake(bgImageViewX, bgImageViewY, bgImageViewW, bgImageViewH)];
    self.fifthBg.userInteractionEnabled = YES;
    [self addSubview:self.fifthBg];
    
    //邮箱标题
    CGFloat emailX = KEDGE_DISTANCE;
    CGFloat emailY = KEDGE_DISTANCE;
    CGFloat emailW = (bgImageViewW - emailX * 2) * 0.3;
    CGFloat emailH = SetUpFirstCellLabelHeight;
    UILabel *emailLabel = [[UILabel alloc] initWithFrame:CGRectMake(emailX, emailY, emailW, emailH)];
    emailLabel.text = @"邮箱";
    
    UITextField *emailButton = [[UITextField alloc] init];
    emailButton.clearsOnBeginEditing = YES;
    emailButton.delegate = self;
    self.emailButton = emailButton;
    [self createUIWithSuperView:self.fifthBg titleLabel:emailLabel titleView:emailButton];
    
    
    
    self.fifthBg.layer.cornerRadius = 5;
    self.fifthBg.layer.masksToBounds = YES;
    self.fifthBg.image = KPULLIMG(@"tab_bg_boss0", 5, 0, 5, 0);
    self.fifthBg.height = (SetUpFirstCellLabelHeight * 1 + KEDGE_DISTANCE * 2);
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

/**
 *  刷新数据
 */
- (void)setMinePersonSetUpModel:(MinePersonSetUpModel *)minePersonSetUpModel
{
    if (minePersonSetUpModel.realName) {
        NSLog(@"%@",minePersonSetUpModel.realName);
    }
}
@end
