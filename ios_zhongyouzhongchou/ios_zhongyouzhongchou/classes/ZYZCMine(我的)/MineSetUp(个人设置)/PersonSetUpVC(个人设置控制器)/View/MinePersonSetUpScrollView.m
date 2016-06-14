//
//  MinePersonSetUpScrollView.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/5/25.
//  Copyright © 2016年 liuliang. All rights reserved.

#import "MinePersonSetUpScrollView.h"
#import "MinePersonSetUpHeadView.h"
#import "MinePersonSetUpModel.h"
#import "ZYZCAccountTool.h"
#import "ZYZCAccountModel.h"
#import "MBProgressHUD+MJ.h"
#import "STPickerArea.h"
#import "STPickerDate.h"
#import "STPickerSingle.h"
#import "FXBlurView.h"
#define SetUpFirstCellLabelHeight 34
@interface MinePersonSetUpScrollView()<UITextFieldDelegate,STPickerAreaDelegate,STPickerDateDelegate>
@property (nonatomic, strong) UIImageView *firstBg;
@property (nonatomic, strong) UIImageView *secondBg;
@property (nonatomic, strong) UIImageView *thirdBg;
@property (nonatomic, strong) UIImageView *fourthBg;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *district;
@property (nonatomic, weak) UIButton *saveButton;
@property (nonatomic, strong) FXBlurView *blurView;
@end
@implementation MinePersonSetUpScrollView
#pragma mark - system方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
        
//        [self requestData];
    }
    return self;
}


#pragma mark - setUI方法
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
    
    [self createSaveButton];
    
    self.contentSize = CGSizeMake(KSCREEN_W, self.saveButton.bottom + KEDGE_DISTANCE);
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
    nameTitleLabel.text = @"昵称";
    
    UITextField *titleView = [[UITextField alloc] init];
    titleView.textColor = [UIColor lightGrayColor];
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
    UITextField *birthButton = [[UITextField alloc] init];
    birthButton.textColor = [UIColor lightGrayColor];
    birthButton.placeholder = @"请选择生日";
    birthButton.delegate = self;
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
    heightButton.textColor = [UIColor lightGrayColor];
    heightButton.placeholder = @"请输入身高";
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
    weightButton.textColor = [UIColor lightGrayColor];
    weightButton.placeholder = @"请输入体重";
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
 *  第三个cell
 */
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
    
    //公司标题
    CGFloat companyLabelX = KEDGE_DISTANCE;
    CGFloat companyLabelY = KEDGE_DISTANCE;
    CGFloat companyLabelW = (bgImageViewW - companyLabelX * 2) * 0.3;
    CGFloat companyLabelH = SetUpFirstCellLabelHeight;
    UILabel *companyLabel = [[UILabel alloc] initWithFrame:CGRectMake(companyLabelX, companyLabelY, companyLabelW, companyLabelH)];
    companyLabel.text = @"公司";
    
    UITextField *companyButton = [[UITextField alloc] init];
    companyButton.textColor = [UIColor lightGrayColor];
    companyButton.placeholder = @"请输入公司名称";
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
    jobButton.textColor = [UIColor lightGrayColor];
    jobButton.placeholder = @"请输入工作";
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
    schoolButton.textColor = [UIColor lightGrayColor];
    schoolButton.placeholder = @"请输入学校";
    schoolButton.clearsOnBeginEditing = YES;
    schoolButton.delegate = self;
    self.schoolButton = schoolButton;
    [self createUIWithSuperView:self.thirdBg titleLabel:schoolLabel titleView:schoolButton];
    
    //学校标题
    CGFloat departmentX = KEDGE_DISTANCE;
    CGFloat departmentY = schoolButton.bottom;
    CGFloat departmentW = (bgImageViewW - departmentX * 2) * 0.3;
    CGFloat departmentH = SetUpFirstCellLabelHeight;
    UILabel *departmentLabel = [[UILabel alloc] initWithFrame:CGRectMake(departmentX, departmentY, departmentW, departmentH)];
    departmentLabel.text = @"专业";
    UITextField *departmentButton = [[UITextField alloc] init];
    departmentButton.textColor = [UIColor lightGrayColor];
    departmentButton.placeholder = @"请输入专业";
    departmentButton.clearsOnBeginEditing = YES;
    departmentButton.delegate = self;
    self.departmentButton = departmentButton;
    [self createUIWithSuperView:self.thirdBg titleLabel:departmentLabel titleView:departmentButton];
    
    //所在地标题
    CGFloat locationLabelX = KEDGE_DISTANCE;
    CGFloat locationLabelY = departmentButton.bottom;
    CGFloat locationLabelW = (bgImageViewW - locationLabelX * 2) * 0.3;
    CGFloat locationLabelH = SetUpFirstCellLabelHeight;
    UILabel *locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(locationLabelX, locationLabelY, locationLabelW, locationLabelH)];
    locationLabel.text = @"所在地";
    UITextField *locationButton = [[UITextField alloc] init];
    locationButton.textColor = [UIColor lightGrayColor];
    locationButton.delegate = self;
    locationButton.placeholder = @"请选择所在地";
    self.locationButton = locationButton;
    [self createUIWithSuperView:self.thirdBg titleLabel:locationLabel titleView:locationButton];
    
    self.thirdBg.layer.cornerRadius = 5;
    self.thirdBg.layer.masksToBounds = YES;
    self.thirdBg.image = KPULLIMG(@"tab_bg_boss0", 5, 0, 5, 0);
    self.thirdBg.height = (SetUpFirstCellLabelHeight * 5 + KEDGE_DISTANCE * 2);
}
/**
 *  第四个cell
 */
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
    
    //邮箱标题
    CGFloat emailX = KEDGE_DISTANCE;
    CGFloat emailY = KEDGE_DISTANCE;
    CGFloat emailW = (bgImageViewW - emailX * 2) * 0.3;
    CGFloat emailH = SetUpFirstCellLabelHeight;
    UILabel *emailLabel = [[UILabel alloc] initWithFrame:CGRectMake(emailX, emailY, emailW, emailH)];
    emailLabel.text = @"邮箱";
    
    UITextField *emailButton = [[UITextField alloc] init];
    emailButton.placeholder = @"请输入邮箱";
    emailButton.textColor = [UIColor lightGrayColor];
    emailButton.clearsOnBeginEditing = YES;
    emailButton.delegate = self;
    self.emailButton = emailButton;
    [self createUIWithSuperView:self.fourthBg titleLabel:emailLabel titleView:emailButton];
    
    //手机
    CGFloat phoneLabelX = KEDGE_DISTANCE;
    CGFloat phoneLabelY = emailButton.bottom;
    CGFloat phoneLabelW = (bgImageViewW - phoneLabelX * 2) * 0.3;
    CGFloat phoneLabelH = SetUpFirstCellLabelHeight;
    UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(phoneLabelX, phoneLabelY, phoneLabelW, phoneLabelH)];
    phoneLabel.text = @"QQ";
    UITextField *phoneButton = [[UITextField alloc] init];
    phoneButton.textColor = [UIColor lightGrayColor];
    phoneButton.delegate = self;
    phoneButton.placeholder = @"请输入QQ";
    self.phoneButton = phoneButton;
    [self createUIWithSuperView:self.fourthBg titleLabel:phoneLabel titleView:phoneButton];
    
    self.fourthBg.layer.cornerRadius = 5;
    self.fourthBg.layer.masksToBounds = YES;
    self.fourthBg.image = KPULLIMG(@"tab_bg_boss0", 5, 0, 5, 0);
    self.fourthBg.height = (SetUpFirstCellLabelHeight * 2 + KEDGE_DISTANCE * 2);
}

- (void)createSaveButton
{
    //保存按钮
    CGFloat saveButtonX = KEDGE_DISTANCE;
    CGFloat saveButtonY = self.fourthBg.bottom + KEDGE_DISTANCE;
    CGFloat saveButtonW = KSCREEN_W - 2 * saveButtonX;
    CGFloat saveButtonH = SetUpFirstCellLabelHeight *2;
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    saveButton.frame = CGRectMake(saveButtonX, saveButtonY, saveButtonW, saveButtonH);
    saveButton.titleLabel.font = [UIFont systemFontOfSize:20];
    saveButton.top = saveButtonY;
    saveButton.layer.cornerRadius = 5;
    saveButton.layer.masksToBounds = YES;
    saveButton.titleLabel.textColor = [UIColor whiteColor];
    saveButton.backgroundColor = [UIColor ZYZC_MainColor];
    [saveButton addTarget:self action:@selector(saveButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    
    [self addSubview:saveButton];
    self.saveButton = saveButton;

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

#pragma mark - button点击方

- (void)sexButtonAction:(UIButton *)button
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
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
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    //弹出性别选择
    __weak typeof(&*self) weakSelf = self;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *noMarrryAction = [UIAlertAction actionWithTitle:ZYLocalizedString(@"maritalStatus_0") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        weakSelf.marryButton.text = ZYLocalizedString(@"maritalStatus_0");
    }];
    UIAlertAction *lovingAction = [UIAlertAction actionWithTitle:ZYLocalizedString(@"maritalStatus_1") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        weakSelf.marryButton.text = ZYLocalizedString(@"maritalStatus_1");
    }];
    UIAlertAction *marriedAction = [UIAlertAction actionWithTitle:ZYLocalizedString(@"maritalStatus_2") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        weakSelf.marryButton.text = ZYLocalizedString(@"maritalStatus_2");
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:noMarrryAction];
    [alertController addAction:lovingAction];
    [alertController addAction:marriedAction];

    [self.viewController presentViewController:alertController animated:YES completion:nil];
}

- (void)saveButtonAction:(UIButton *)button
{
    ZYZCAccountModel *accountModel = [ZYZCAccountTool account];
    if (accountModel) {
        NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
        [parameter setValue:accountModel.openid forKey:@"openid"];
        if (_nameTextField.text.length > 0) {
            [parameter setValue:_nameTextField.text forKey:@"realName"];
        }
        if (_sexButton.titleLabel.text.length > 0) {
            if([_sexButton.titleLabel.text isEqualToString:@"男"]){
                [parameter setValue:[NSNumber numberWithInt:1]  forKey:@"sex"];
            }else if([_sexButton.titleLabel.text isEqualToString:@"女"]){
                [parameter setValue:[NSNumber numberWithInt:2]  forKey:@"sex"];
            }else{
                [parameter setValue:[NSNumber numberWithInt:0]  forKey:@"sex"];
            }
        
        }
        if (_birthButton.text.length > 0) {
            [parameter setValue:_birthButton.text forKey:@"birthday"];
        }
        if (_heightButton.text.length > 0) {
            [parameter setValue:_heightButton.text forKey:@"height"];
        }
        if (_weightButton.text.length > 0) {
            [parameter setValue:_weightButton.text forKey:@"weight"];
        }
        if (_constellationButton.text.length > 0) {
            [parameter setValue:_constellationButton.text forKey:@"constellation"];
        }
        if (_marryButton.text.length > 0) {
            if([_marryButton.text isEqualToString:ZYLocalizedString(@"maritalStatus_0")]){
                [parameter setValue:@0 forKey:@"maritalStatus"];
            }else if([_marryButton.text isEqualToString:ZYLocalizedString(@"maritalStatus_1")]){
                [parameter setValue:@1 forKey:@"maritalStatus"];
            }else if ([_marryButton.text isEqualToString:ZYLocalizedString(@"maritalStatus_2")])
            {
                [parameter setValue:@2 forKey:@"maritalStatus"];
            }
        }
        if (_emailButton.text.length > 0) {
            [parameter setValue:_emailButton.text forKey:@"mail"];
        }
        if (_companyButton.text.length > 0) {
            [parameter setValue:_companyButton.text forKey:@"company"];
        }
        if (_jobButton.text.length > 0) {
            [parameter setValue:_jobButton.text forKey:@"title"];
        }
        if (_schoolButton.text.length > 0) {
            [parameter setValue:_schoolButton.text forKey:@"school"];
        }
        if (_departmentButton.text.length ) {
            [parameter setValue:_schoolButton.text forKey:@"department"];
        }
        if (_province.length > 0) {
            [parameter setValue:_province forKey:@"province"];
        }
        if (_city.length > 0) {
            [parameter setValue:_city forKey:@"city"];
        }
        if (_district.length > 0) {
            [parameter setValue:_district forKey:@"district"];
        }
        if (_phoneButton.text.length > 0) {
            [parameter setValue:_district forKey:@"qq"];
        }
        NSLog(@"%@",Regist_UpdateUserInfo);
        [ZYZCHTTPTool postHttpDataWithEncrypt:YES andURL:Regist_UpdateUserInfo andParameters:parameter andSuccessGetBlock:^(id result, BOOL isSuccess) {
            [MBProgressHUD showSuccess:@"保存成功"];
            [MBProgressHUD setAnimationDelay:2];
            [self.viewController.navigationController popViewControllerAnimated:YES];
        } andFailBlock:^(id failResult) {
            [MBProgressHUD showError:@"保存失败"];
            [MBProgressHUD setAnimationDelay:2];
            NSLog(@"%@",failResult);
        }];

    }
   
}

#pragma mark - set方法
/**
 *  刷新数据
 */
- (void)setMinePersonSetUpModel:(MinePersonSetUpModel *)minePersonSetUpModel
{
    //头视图
    NSString *faceImg = minePersonSetUpModel.faceImg;
    
    if (minePersonSetUpModel.faceImg.length > 0) {
        [self.headView.iconView sd_setImageWithURL:[NSURL URLWithString:faceImg] placeholderImage:[UIImage imageNamed:@"icon_placeholder"] options:(SDWebImageRetryFailed | SDWebImageLowPriority)];
        [self.headView sd_setImageWithURL:[NSURL URLWithString:faceImg] placeholderImage:[UIImage imageNamed:@"icon_placeholder"] options:(SDWebImageRetryFailed | SDWebImageLowPriority) completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [_headView addFXBlurView];
        }];
    }
    if (minePersonSetUpModel.userName.length > 0) {
        self.headView.nameLabel.text = minePersonSetUpModel.userName;
    }
    if (minePersonSetUpModel.realName.length > 0) {
        self.nameTextField.text = minePersonSetUpModel.realName;
    }
    if (minePersonSetUpModel.sex > 0) {
        if ([minePersonSetUpModel.sex intValue] == 0) {
            [self.sexButton setTitle:@"保密" forState:UIControlStateNormal];
        }else if ([minePersonSetUpModel.sex intValue] == 1){
            [self.sexButton setTitle:@"男" forState:UIControlStateNormal];
        }else{
            [self.sexButton setTitle:@"女" forState:UIControlStateNormal];
        }
    }
    if(minePersonSetUpModel.birthday.length > 0){
        _birthButton.text = minePersonSetUpModel.birthday;
    }
    if (minePersonSetUpModel.constellation.length > 0) {
        _constellationButton.text = minePersonSetUpModel.constellation;
    }
    if (minePersonSetUpModel.maritalStatus.length > 0) {
        if ([minePersonSetUpModel.maritalStatus intValue] == 0) {
            self.marryButton.text = ZYLocalizedString(@"maritalStatus_0");
        }else if ([minePersonSetUpModel.maritalStatus intValue] == 1){
            self.marryButton.text = ZYLocalizedString(@"maritalStatus_1");
        }else if ([minePersonSetUpModel.maritalStatus intValue] == 2)
        {
            self.marryButton.text = ZYLocalizedString(@"maritalStatus_2");
        }
    }
    if (minePersonSetUpModel.height > 0) {
        _heightButton.text = [NSString stringWithFormat:@"%d",minePersonSetUpModel.height];
    }
    if (minePersonSetUpModel.weight > 0) {
        _weightButton.text = [NSString stringWithFormat:@"%d",minePersonSetUpModel.weight] ;
    }
    if (minePersonSetUpModel.company.length > 0) {
        _companyButton.text = minePersonSetUpModel.company;
    }
    if (minePersonSetUpModel.title.length > 0) {
        _jobButton.text = minePersonSetUpModel.title;
    }
    if (minePersonSetUpModel.school.length > 0) {
        _schoolButton.text = minePersonSetUpModel.school;
    }
    if (minePersonSetUpModel.department.length > 0) {
        _departmentButton.text = minePersonSetUpModel.department;
    }
    //地名
    NSString *placeString = @"";
    if (minePersonSetUpModel.province.length > 0) {
        placeString = [placeString stringByAppendingString:minePersonSetUpModel.province];
        _province = minePersonSetUpModel.province;
    }
    if (minePersonSetUpModel.city.length > 0) {
        placeString = [placeString stringByAppendingString:minePersonSetUpModel.city];
        _city = minePersonSetUpModel.city;
    }
    if (minePersonSetUpModel.district.length > 0) {
        placeString = [placeString stringByAppendingString:minePersonSetUpModel.district];
        _district = minePersonSetUpModel.district;
    }
    _locationButton.text = placeString;
    
    if (minePersonSetUpModel.mail.length > 0) {
        _emailButton.text = minePersonSetUpModel.mail;
    }

}

#pragma mark - UITextfieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == _locationButton) {
        [_locationButton resignFirstResponder];
        
        STPickerArea *pickerArea = [[STPickerArea alloc]init];
        [pickerArea setDelegate:self];
        [pickerArea setContentMode:STPickerContentModeBottom];
        [pickerArea show];
        
    }
    if (textField == _birthButton) {
        [_birthButton resignFirstResponder];
        
        STPickerDate *pickerDate = [[STPickerDate alloc]init];
        [pickerDate setDelegate:self];
        [pickerDate show];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField endEditing:YES];
    return YES;
}

#pragma mark - requsetData方法



#pragma mark - delegate方法
- (void)pickerArea:(STPickerArea *)pickerArea province:(NSString *)province city:(NSString *)city area:(NSString *)area
{
    NSString *text = [NSString stringWithFormat:@"%@ %@ %@", province, city, area];
    _province = province;
    _city = city;
    _district = area;
    _locationButton.text = text;
}

- (void)pickerDate:(STPickerDate *)pickerDate year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
    NSString *text = [NSString stringWithFormat:@"%d-%02d-%02d", year, month, day];
   _constellationButton.text = [ZYZCTool calculateConstellationWithMonth:month day:day];
    
    _birthButton.text = text;
}

@end
