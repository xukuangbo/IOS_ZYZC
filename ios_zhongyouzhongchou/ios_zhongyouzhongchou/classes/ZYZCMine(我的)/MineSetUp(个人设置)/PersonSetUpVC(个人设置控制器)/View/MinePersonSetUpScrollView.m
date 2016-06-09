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
#import "ZYZCAccountTool.h"
#import "ZYZCAccountModel.h"
#import "MBProgressHUD+MJ.h"
#import "STPickerArea.h"
#define SetUpFirstCellLabelHeight 34
@interface MinePersonSetUpScrollView()<UITextFieldDelegate,STPickerAreaDelegate>
@property (nonatomic, strong) UIImageView *firstBg;
@property (nonatomic, strong) UIImageView *secondBg;
@property (nonatomic, strong) UIImageView *thirdBg;
@property (nonatomic, strong) UIImageView *fourthBg;
@property (nonatomic, weak) UIButton *saveButton;
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
//    headView.backgroundColor = [UIColor redColor];
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
    locationButton.delegate = self;
    locationButton.placeholder = @"请选择所在地";
    self.locationButton = locationButton;
    [self createUIWithSuperView:self.thirdBg titleLabel:locationLabel titleView:locationButton];
    
    self.thirdBg.layer.cornerRadius = 5;
    self.thirdBg.layer.masksToBounds = YES;
    self.thirdBg.image = KPULLIMG(@"tab_bg_boss0", 5, 0, 5, 0);
    self.thirdBg.height = (SetUpFirstCellLabelHeight * 4 + KEDGE_DISTANCE * 2);
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
    emailButton.clearsOnBeginEditing = YES;
    emailButton.delegate = self;
    self.emailButton = emailButton;
    [self createUIWithSuperView:self.fourthBg titleLabel:emailLabel titleView:emailButton];
    
    
    
    self.fourthBg.layer.cornerRadius = 5;
    self.fourthBg.layer.masksToBounds = YES;
    self.fourthBg.image = KPULLIMG(@"tab_bg_boss0", 5, 0, 5, 0);
    self.fourthBg.height = (SetUpFirstCellLabelHeight * 1 + KEDGE_DISTANCE * 2);
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

#pragma mark - button点击方法
- (void)birthButtonAction:(UIButton *)birthButton
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
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
        if (_birthButton.titleLabel.text.length > 0) {
            [parameter setValue:_birthButton.titleLabel.text forKey:@"birthday"];
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
            if([_marryButton.text isEqualToString:@"未婚"]){
                [parameter setValue:[NSNumber numberWithInt:0] forKey:@"maritalStatus"];
            }else if([_sexButton.titleLabel.text isEqualToString:@"恋爱中"]){
                [parameter setValue:[NSNumber numberWithInt:1]  forKey:@"maritalStatus"];
            }else{
                [parameter setValue:[NSNumber numberWithInt:2]  forKey:@"maritalStatus"];
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
        if (_locationButton.text.length > 0) {
            [parameter setValue:_locationButton.text forKey:@"province"];
        }
        if (_locationButton.text.length > 0) {
            [parameter setValue:_locationButton.text forKey:@"city"];
        }
        if (_locationButton.text.length > 0) {
            [parameter setValue:_locationButton.text forKey:@"district"];
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
        [_birthButton setTitle:minePersonSetUpModel.birthday forState:UIControlStateNormal];
    }
    if (minePersonSetUpModel.constellation.length > 0) {
        _constellationButton.text = minePersonSetUpModel.constellation;
    }
    if (minePersonSetUpModel.maritalStatus.length > 0) {
        if ([minePersonSetUpModel.maritalStatus intValue] == 0) {
            self.marryButton.text = @"单身";
        }else if ([minePersonSetUpModel.sex intValue] == 1){
            self.marryButton.text = @"恋爱中";
        }else{
            self.marryButton.text = @"已婚";
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
    if (minePersonSetUpModel.province.length > 0) {
        [_proviceButton setTitle:minePersonSetUpModel.province forState:UIControlStateNormal];
    }
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
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField endEditing:YES];
    return YES;
}

#pragma mark - requsetData方法
//- (void)requestData
//{
//    ZYZCAccountModel *accountModel = [ZYZCAccountTool account];
//    NSString *url = Get_SelfInfo(accountModel.openid, [accountModel.userId intValue]);
////    NSString *url = @"";
//    NSLog(@"%@",url);
//    //访问网络
//    __weak typeof(&*self) weakSelf = self;
//    [ZYZCHTTPTool getHttpDataByURL:url withSuccessGetBlock:^(id result, BOOL isSuccess) {
//        if (isSuccess) {
//            //请求成功，转化为数组
////            weakSelf.mineWantGoModelArray = [MineWantGoModel mj_objectArrayWithKeyValuesArray:result[@"data"]];
////            [weakSelf.collectionView reloadData];
//        }
//    } andFailBlock:^(id failResult) {
//        NSLog(@"%@",failResult);
//    }];
//}


#pragma mark - delegate方法
- (void)pickerArea:(STPickerArea *)pickerArea province:(NSString *)province city:(NSString *)city area:(NSString *)area
{
    NSString *text = [NSString stringWithFormat:@"%@ %@ %@", province, city, area];
    _locationButton.text = text;
}

@end
