//
//  MinePersonSetUpScrollView.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/5/25.
//  Copyright © 2016年 liuliang. All rights reserved.

#import "MinePersonSetUpScrollView.h"
#import "MinePersonSetUpHeadView.h"
#import "MinePersonSetUpModel.h"
#import "MinePersonDatePickerView.h"
#import "MinePersonSetUpLikeController.h"
#define SetUpFirstCellLabelHeight 34
@interface MinePersonSetUpScrollView()<UITextFieldDelegate>
@property (nonatomic, strong) UIImageView *firstBg;
@property (nonatomic, strong) UIImageView *secondBg;
@property (nonatomic, strong) UIImageView *thirdBg;
@property (nonatomic, strong) UIImageView *fourthBg;
@end
@implementation MinePersonSetUpScrollView
#pragma mark - system方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
        
    }
    return self;
}


#pragma mark - setUI方法
- (void)createUI
{
    //头视图
     MinePersonSetUpHeadView *headView = [[MinePersonSetUpHeadView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_W, imageHeadHeight)];
//    headView.backgroundColor = [UIColor redColor];
    self.headView = headView;
    [self addSubview:headView];
    
    //第一个表格
    [self createFirstUI];
    
//    [self createSecondUI];
    
    [self createThirdUI];
    
    [self createFourthUI];
    
    [self createFifthUI];
    self.contentSize = CGSizeMake(KSCREEN_W, self.fourthBg.bottom + KEDGE_DISTANCE);
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
    
    //姓名
    CGFloat nameTitleX = KEDGE_DISTANCE;
    CGFloat nameTitleY = KEDGE_DISTANCE;
    CGFloat nameTitleW = (bgImageViewW - nameTitleX * 2) * 0.3;
    CGFloat nameTitleH = SetUpFirstCellLabelHeight;
    UILabel *nameTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameTitleX, nameTitleY, nameTitleW, nameTitleH)];
    nameTitleLabel.text = @"姓名";
    
    UITextField *titleView = [[UITextField alloc] init];
    titleView.placeholder = @"请输入姓名";
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
    sexButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [sexButton setTitleColor:[UIColor ZYZC_TextGrayColor] forState:UIControlStateNormal];
    [sexButton addTarget:self action:@selector(sexButtonAction:) forControlEvents:UIControlEventTouchUpInside];
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
    [birthButton addTarget:self action:@selector(birthButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    birthButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [birthButton setTitleColor:[UIColor ZYZC_TextGrayColor] forState:UIControlStateNormal];
    self.birthButton = birthButton;
    [self createUIWithSuperView:self.firstBg titleLabel:birthdayLabel titleView:birthButton];
    
    //星座标题
    CGFloat constellationLabelX = KEDGE_DISTANCE;
    CGFloat constellationLabelY = birthButton.bottom;
    CGFloat constellationLabelW = (bgImageViewW - nameTitleX * 2) * 0.3;
    CGFloat constellationLabelH = SetUpFirstCellLabelHeight;
    UILabel *constellationLabel = [[UILabel alloc] initWithFrame:CGRectMake(constellationLabelX, constellationLabelY, constellationLabelW, constellationLabelH)];
    constellationLabel.text = @"星座";
    UILabel *constellationButton = [[UILabel alloc] init];
    constellationButton.textColor = [UIColor ZYZC_TextGrayColor];
    constellationButton.text = @"请输入星座";
    self.constellationButton = constellationButton;
    [self createUIWithSuperView:self.firstBg titleLabel:constellationLabel titleView:constellationButton];
    
    self.firstBg.layer.cornerRadius = 5;
    self.firstBg.layer.masksToBounds = YES;
    self.firstBg.image = KPULLIMG(@"tab_bg_boss0", 5, 0, 5, 0);
    self.firstBg.height = (SetUpFirstCellLabelHeight * 4 + KEDGE_DISTANCE * 2);
}

/**
 *  第二个cell
 */
- (void)createThirdUI
{
    //背景白图
    CGFloat bgImageViewX = KEDGE_DISTANCE;
    CGFloat bgImageViewY = self.firstBg.bottom + KEDGE_DISTANCE;
    CGFloat bgImageViewW = KSCREEN_W - 2 * bgImageViewX;
    CGFloat bgImageViewH = 0;
    self.secondBg = [[UIImageView alloc] initWithFrame:CGRectMake(bgImageViewX, bgImageViewY, bgImageViewW, bgImageViewH)];
    self.secondBg.userInteractionEnabled = YES;
    [self addSubview:self.secondBg];
    
    //感情状况标题
    CGFloat marryLabelX = KEDGE_DISTANCE;
    CGFloat marryLabelY = KEDGE_DISTANCE;
    CGFloat marryLabelW = (bgImageViewW - marryLabelX * 2) * 0.3;
    CGFloat marryLabelH = SetUpFirstCellLabelHeight;
    UILabel *marryLabel = [[UILabel alloc] initWithFrame:CGRectMake(marryLabelX, marryLabelY, marryLabelW, marryLabelH)];
    marryLabel.text = @"感情状况";

    UILabel *marryButton = [[UILabel alloc] init];
    marryButton.userInteractionEnabled = YES;
//    UIButton *marryButton = [[UIButton alloc] init];
    marryButton.textColor =[UIColor ZYZC_TextGrayColor];
    marryButton.textAlignment = NSTextAlignmentLeft;
    [marryButton addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(marryButtonAction:)]];
    self.marryButton = marryButton;
    [self createUIWithSuperView:self.secondBg titleLabel:marryLabel titleView:marryButton];
    
    //身高标题
    CGFloat heightLabelX = KEDGE_DISTANCE;
    CGFloat heightLabelY = marryButton.bottom;
    CGFloat heightLabelW = (bgImageViewW - heightLabelX * 2) * 0.3;
    CGFloat heightLabelH = SetUpFirstCellLabelHeight;
    UILabel *heightLabel = [[UILabel alloc] initWithFrame:CGRectMake(heightLabelX, heightLabelY, heightLabelW, heightLabelH)];
    heightLabel.text = @"身高(cm)";
    UITextField *heightButton = [[UITextField alloc] init];
    heightButton.clearsOnBeginEditing = YES;
    heightButton.keyboardType = UIKeyboardTypeNumberPad;
    self.heightButton = heightButton;
    [self createUIWithSuperView:self.secondBg titleLabel:heightLabel titleView:heightButton];

    //体重标题
    CGFloat weightLabelX = KEDGE_DISTANCE;
    CGFloat weightLabelY = heightButton.bottom;
    CGFloat weightLabelW = (bgImageViewW - weightLabelX * 2) * 0.3;
    CGFloat weightLabelH = SetUpFirstCellLabelHeight;
    UILabel *weightLabel = [[UILabel alloc] initWithFrame:CGRectMake(weightLabelX, weightLabelY, weightLabelW, weightLabelH)];
    weightLabel.text = @"体重(kg)";
    UITextField *weightButton = [[UITextField alloc] init];
    weightButton.clearsOnBeginEditing = YES;
    weightButton.keyboardType = UIKeyboardTypeNumberPad;
    self.weightButton = weightButton;
    [self createUIWithSuperView:self.secondBg titleLabel:weightLabel titleView:weightButton];
    
    self.secondBg.layer.cornerRadius = 5;
    self.secondBg.layer.masksToBounds = YES;
    self.secondBg.image = KPULLIMG(@"tab_bg_boss0", 5, 0, 5, 0);
    self.secondBg.height = (SetUpFirstCellLabelHeight * 3 + KEDGE_DISTANCE * 2);
}
/**
 *  第四个cell
 */
- (void)createFourthUI
{
    //背景白图
    CGFloat bgImageViewX = KEDGE_DISTANCE;
    CGFloat bgImageViewY = self.secondBg.bottom + KEDGE_DISTANCE;
    CGFloat bgImageViewW = KSCREEN_W - 2 * bgImageViewX;
    CGFloat bgImageViewH = 0;
    self.thirdBg = [[UIImageView alloc] initWithFrame:CGRectMake(bgImageViewX, bgImageViewY, bgImageViewW, bgImageViewH)];
    self.thirdBg.userInteractionEnabled = YES;
    [self addSubview:self.thirdBg];
    
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
    [self createUIWithSuperView:self.thirdBg titleLabel:companyLabel titleView:companyButton];
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
    [self createUIWithSuperView:self.thirdBg titleLabel:jobLabel titleView:jobButton];
    
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
    [self createUIWithSuperView:self.thirdBg titleLabel:schoolLabel titleView:schoolButton];
    
    //所在地标题
    CGFloat locationLabelX = KEDGE_DISTANCE;
    CGFloat locationLabelY = schoolButton.bottom;
    CGFloat locationLabelW = (bgImageViewW - locationLabelX * 2) * 0.3;
    CGFloat locationLabelH = SetUpFirstCellLabelHeight;
    UILabel *locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(locationLabelX, locationLabelY, locationLabelW, locationLabelH)];
    locationLabel.text = @"所在地";
    UITextField *locationButton = [[UITextField alloc] init];
    self.locationButton = locationButton;
    [self createUIWithSuperView:self.thirdBg titleLabel:locationLabel titleView:locationButton];
    
    self.thirdBg.layer.cornerRadius = 5;
    self.thirdBg.layer.masksToBounds = YES;
    self.thirdBg.image = KPULLIMG(@"tab_bg_boss0", 5, 0, 5, 0);
    self.thirdBg.height = (SetUpFirstCellLabelHeight * 4 + KEDGE_DISTANCE * 2);
}
/**
 *  第五个cell
 */
- (void)createFifthUI
{
    //背景白图
    CGFloat bgImageViewX = KEDGE_DISTANCE;
    CGFloat bgImageViewY = self.thirdBg.bottom + KEDGE_DISTANCE;
    CGFloat bgImageViewW = KSCREEN_W - 2 * bgImageViewX;
    CGFloat bgImageViewH = 0;
    self.fourthBg = [[UIImageView alloc] initWithFrame:CGRectMake(bgImageViewX, bgImageViewY, bgImageViewW, bgImageViewH)];
    self.fourthBg.userInteractionEnabled = YES;
    [self addSubview:self.fourthBg];
    
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
    [self createUIWithSuperView:self.fourthBg titleLabel:emailLabel titleView:emailButton];
    
    
    
    self.fourthBg.layer.cornerRadius = 5;
    self.fourthBg.layer.masksToBounds = YES;
    self.fourthBg.image = KPULLIMG(@"tab_bg_boss0", 5, 0, 5, 0);
    self.fourthBg.height = (SetUpFirstCellLabelHeight * 1 + KEDGE_DISTANCE * 2);
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

#pragma mark - button点击方法
- (void)birthButtonAction:(UIButton *)birthButton
{
    [self.nameTextField endEditing:YES];
    [self.constellationButton endEditing:YES];
    [self.heightButton endEditing:YES];
    [self.weightButton endEditing:YES];
    
    MinePersonDatePickerView *datePickerView = [[MinePersonDatePickerView alloc] initWithFrame:self.bounds];

    __weak typeof(&*self) weakSelf = self;
    datePickerView.sureBlock = ^(NSDate *birthdayDate){
        //转成字符串
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSString *dateString = [formatter stringFromDate:birthdayDate];
        [weakSelf.birthButton setTitle:dateString forState:UIControlStateNormal];
        //转成星座
        NSCalendar * cal = [NSCalendar currentCalendar];
    
        NSUInteger unitFlags = NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit;
        NSDateComponents * component = [cal components:unitFlags fromDate:birthdayDate];
    //    NSInteger year = [component year];
        NSInteger month = [component month];
        NSInteger day = [component day];
        weakSelf.constellationButton.text = [ZYZCTool calculateConstellationWithMonth:month day:day];
    };
    
    [self addSubview:datePickerView];
}

/**
 *  兴趣标签
 */
- (void)likeButtonAction
{
    MinePersonSetUpLikeController *likeController = [[MinePersonSetUpLikeController alloc] init];
    [self.viewController.navigationController pushViewController:likeController animated:YES];
}


- (void)sexButtonAction:(UIButton *)button
{
    //弹出性别选择
    __weak typeof(&*self) weakSelf = self;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *manAction = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [weakSelf.sexButton setTitle:@"男" forState:UIControlStateNormal];
    }];
    UIAlertAction *girlAction = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [weakSelf.sexButton setTitle:@"女" forState:UIControlStateNormal];
    }];
    UIAlertAction *unknownAction = [UIAlertAction actionWithTitle:@"保密" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [weakSelf.sexButton setTitle:@"保密" forState:UIControlStateNormal];
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:manAction];
    [alertController addAction:girlAction];
    [alertController addAction:unknownAction];
    
    [self.viewController presentViewController:alertController animated:YES completion:nil];
}

- (void)marryButtonAction:(UIButton *)button
{
    //弹出性别选择
    __weak typeof(&*self) weakSelf = self;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *noMarrryAction = [UIAlertAction actionWithTitle:@"单身" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        weakSelf.marryButton.text = @"单身";
    }];
    UIAlertAction *lovingAction = [UIAlertAction actionWithTitle:@"恋爱中" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        weakSelf.marryButton.text = @"恋爱中";
    }];
    UIAlertAction *marriedAction = [UIAlertAction actionWithTitle:@"已婚" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        weakSelf.marryButton.text = @"已婚";
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:noMarrryAction];
    [alertController addAction:lovingAction];
    [alertController addAction:marriedAction];

    [self.viewController presentViewController:alertController animated:YES completion:nil];
}
#pragma mark - set方法
/**
 *  刷新数据
 */
- (void)setMinePersonSetUpModel:(MinePersonSetUpModel *)minePersonSetUpModel
{
    //头视图
    NSString *faceImg = minePersonSetUpModel.faceImg;
    [self.headView.iconView sd_setImageWithURL:[NSURL URLWithString:faceImg] placeholderImage:[UIImage imageNamed:@"icon_placeholder"] options:(SDWebImageRetryFailed | SDWebImageLowPriority)];
    
    self.headView.nameLabel.text = minePersonSetUpModel.userName;
    
    [self.headView sd_setImageWithURL:[NSURL URLWithString:faceImg] placeholderImage:[UIImage imageNamed:@"icon_placeholder"] options:(SDWebImageRetryFailed | SDWebImageLowPriority)];
    
    //姓名
    self.nameTextField.text = minePersonSetUpModel.userName? minePersonSetUpModel.userName : nil;
    //性别
    NSString *sexText = minePersonSetUpModel.sex? minePersonSetUpModel.sex : @"请输入性别";
    [self.sexButton setTitle:sexText forState:UIControlStateNormal];
    //生日
    NSString *birthText = minePersonSetUpModel.birthday? minePersonSetUpModel.birthday : @"请输入生日";
    [self.birthButton setTitle:birthText forState:UIControlStateNormal];
    //星座
    NSString *constellationText = minePersonSetUpModel.constellation? minePersonSetUpModel.constellation : nil;
    self.constellationButton.text = constellationText;
    //兴趣标签
    
}

#pragma mark - UITextfieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField endEditing:YES];
    return YES;
}

#pragma mark - requsetData方法



#pragma mark - delegate方法

@end
