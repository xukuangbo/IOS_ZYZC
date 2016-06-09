//
//  MineSaveContactInfoVC.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/6/7.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#define SetUpFirstCellLabelHeight 34
#import "MineSaveContactInfoVC.h"
#import "ZYZCAccountTool.h"
#import "ZYZCAccountModel.h"
#import "MBProgressHUD+MJ.h"
#import "STPickerArea.h"

@interface MineSaveContactInfoVC ()<UITextFieldDelegate,UIScrollViewDelegate,STPickerAreaDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *firstBg;

@property (nonatomic, weak) UITextField *nameTextField;
@property (nonatomic, weak) UITextField *phoneTextField;
@property (nonatomic, weak) UITextField *placeButton;

@property (nonatomic, weak) UITextField *detailPlaceButton;

@property (nonatomic, weak) UITextField *descButton;

@property (nonatomic, weak) UIButton *saveButton;
@end

@implementation MineSaveContactInfoVC
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self configUI];
    }
    return self;
}
#pragma mark - system方法

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setBackItem];
    
    self.title = @"收货地址";
}


#pragma mark - setUI方法
- (void)configUI
{
    self.hidesBottomBarWhenPushed = YES;
    self.view.backgroundColor = [UIColor ZYZC_BgGrayColor];
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:scrollView];
    scrollView.delegate = self;
    self.scrollView = scrollView;
    
    //第一个表格
    [self createFirstUI];
    
    [self createSaveButton];
    
    self.scrollView.contentSize = CGSizeMake(KSCREEN_W, self.saveButton.bottom + KEDGE_DISTANCE);
    if(self.scrollView.contentSize.height <= KSCREEN_H){
        self.scrollView.contentSize = CGSizeMake(KSCREEN_W, KSCREEN_H + KEDGE_DISTANCE);
    }
    NSLog(@"%@___%@",NSStringFromCGSize(self.scrollView.contentSize),NSStringFromCGRect( self.firstBg.frame));
}
/**
 *  第一个cell
 */
- (void)createFirstUI
{
    //背景白图
    CGFloat bgImageViewX = KEDGE_DISTANCE;
    CGFloat bgImageViewY = KEDGE_DISTANCE;
    CGFloat bgImageViewW = KSCREEN_W - 2 * bgImageViewX;
    CGFloat bgImageViewH = 0;
    self.firstBg = [[UIImageView alloc] initWithFrame:CGRectMake(bgImageViewX, bgImageViewY, bgImageViewW, bgImageViewH)];
    self.firstBg.userInteractionEnabled = YES;
    [self.scrollView addSubview:self.firstBg];
    
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
    //电话
    CGFloat phoneLabelX = KEDGE_DISTANCE;
    CGFloat phoneLabelY = nameTitleLabel.bottom;
    CGFloat phoneLabelW = (bgImageViewW - nameTitleX * 2) * 0.3;
    CGFloat phoneLabelH = SetUpFirstCellLabelHeight;
    UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(phoneLabelX, phoneLabelY, phoneLabelW, phoneLabelH)];
    phoneLabel.text = @"电话";
    
    UITextField *phoneTextField = [[UITextField alloc] init];
    phoneTextField.delegate = self;
    phoneTextField.placeholder = @"手机号码";
    phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneTextField = phoneTextField;
    [self createUIWithSuperView:self.firstBg titleLabel:phoneLabel titleView:phoneTextField];
    
    //地区
    CGFloat placeLabelX = KEDGE_DISTANCE;
    CGFloat placeLabelY = phoneLabel.bottom;
    CGFloat placeLabelW = (bgImageViewW - nameTitleX * 2) * 0.3;
    CGFloat placeLabelH = SetUpFirstCellLabelHeight;
    UILabel *placeLabel = [[UILabel alloc] initWithFrame:CGRectMake(placeLabelX, placeLabelY, placeLabelW, placeLabelH)];
    placeLabel.text = @"地区";
    UITextField *placeButton = [[UITextField alloc] init];
    placeButton.placeholder = @"请输入地区";
    placeButton.delegate = self;
    self.placeButton = placeButton;
    [self createUIWithSuperView:self.firstBg titleLabel:placeLabel titleView:placeButton];
    
    //地址
    CGFloat detailPlaceLabelX = KEDGE_DISTANCE;
    CGFloat detailPlaceLabelY = placeLabel.bottom;
    CGFloat detailPlaceLabelW = (bgImageViewW - nameTitleX * 2) * 0.3;
    CGFloat detailPlaceLabelH = SetUpFirstCellLabelHeight;
    UILabel *detailPlaceLabel = [[UILabel alloc] initWithFrame:CGRectMake(detailPlaceLabelX, detailPlaceLabelY, detailPlaceLabelW, detailPlaceLabelH)];
    detailPlaceLabel.text = @"地址";
    UITextField *detailPlaceButton = [[UITextField alloc] init];
    detailPlaceButton.delegate = self;
    detailPlaceButton.placeholder = @"5~50个字，不能全部为数字";
    self.detailPlaceButton = detailPlaceButton;
    [self createUIWithSuperView:self.firstBg titleLabel:detailPlaceLabel titleView:detailPlaceButton];
    
    //备注
    CGFloat descLabelX = KEDGE_DISTANCE;
    CGFloat descLabelY = detailPlaceLabel.bottom;
    CGFloat descLabelW = (bgImageViewW - nameTitleX * 2) * 0.3;
    CGFloat descLabelH = SetUpFirstCellLabelHeight;
    UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(descLabelX, descLabelY, descLabelW, descLabelH)];
    descLabel.text = @"备注";
    UITextField *descButton = [[UITextField alloc] init];
    descButton.placeholder = @"填写";
    descButton.delegate = self;
    self.descButton = descButton;
    [self createUIWithSuperView:self.firstBg titleLabel:descLabel titleView:descButton];
    
    
    self.firstBg.layer.cornerRadius = 5;
    self.firstBg.layer.masksToBounds = YES;
    self.firstBg.image = KPULLIMG(@"tab_bg_boss0", 5, 0, 5, 0);
    self.firstBg.height = (SetUpFirstCellLabelHeight * 5 + KEDGE_DISTANCE * 2);
}
/**
 *  保存按钮
 */
- (void)createSaveButton
{
    //保存按钮
    CGFloat saveButtonX = KEDGE_DISTANCE;
    CGFloat saveButtonY = self.firstBg.bottom + KEDGE_DISTANCE;
    CGFloat saveButtonW = KSCREEN_W - 2 * saveButtonX;
    CGFloat saveButtonH = SetUpFirstCellLabelHeight * 2;
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    saveButton.frame = CGRectMake(saveButtonX, saveButtonY, saveButtonW, saveButtonH);
    saveButton.layer.cornerRadius = 5;
    saveButton.layer.masksToBounds = YES;
    saveButton.titleLabel.textColor = [UIColor whiteColor];
    saveButton.backgroundColor = [UIColor ZYZC_MainColor];
    saveButton.titleLabel.font = [UIFont systemFontOfSize:25];
    [saveButton addTarget:self action:@selector(saveButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    
    [self.scrollView addSubview:saveButton];
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

#pragma mark - requsetData方法

#pragma mark - set方法

#pragma mark - button点击方法
- (void)placeButtonAction
{
    NSLog(@"点击了地点");
}

- (void)saveButtonAction:(UIButton *)button
{
    
    ZYZCAccountModel *accountModel = [ZYZCAccountTool account];
    if (accountModel) {
        //判断是否有文字
        if ([self checkMessage] == NO) return;
        NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
        [parameter setValue:accountModel.openid forKey:@"openid"];
        if (_nameTextField.text.length > 0) {
            [parameter setValue:_nameTextField.text forKey:@"consignee"];
        }
        if (_phoneTextField.text.length > 0) {
            [parameter setValue:_phoneTextField.text forKey:@"phone"];
        }
        if (_placeButton.text.length > 0) {
            [parameter setValue:_placeButton.text forKey:@"province"];
        }
        if (_detailPlaceButton.text.length > 0) {
            [parameter setValue:_detailPlaceButton.text forKey:@"address"];
        }
        if (_descButton.text.length > 0) {
            [parameter setValue:_descButton.text forKey:@"descript"];
        }
        
        NSLog(@"%@",Regist_SaveContactInfo);
        [ZYZCHTTPTool postHttpDataWithEncrypt:YES andURL:@"http://192.168.1.27/register/saveContactInfo.action" andParameters:parameter andSuccessGetBlock:^(id result, BOOL isSuccess) {
            [MBProgressHUD showSuccess:@"保存成功"];
            [MBProgressHUD setAnimationDelay:2];
            [self.navigationController popViewControllerAnimated:YES];
        } andFailBlock:^(id failResult) {
            [MBProgressHUD showError:@"保存失败"];
            [MBProgressHUD setAnimationDelay:2];
            NSLog(@"%@",failResult);
        }];
        
    }
    
    
}

/**
 *  确认是否有信息
 */
- (BOOL)checkMessage
{
    if(_nameTextField.text.length <= 0){
        [MBProgressHUD showError:ZYLocalizedString(@"place_name")];
        return NO;
    }
    if(_phoneTextField.text.length <= 0){
        [MBProgressHUD showError:ZYLocalizedString(@"place_phone")];
        return NO;
    }
//    if(_placeButton.text.length <= 0){
//        [MBProgressHUD showError:ZYLocalizedString(@"place_place")];
//        return NO;
//    }
    if(_detailPlaceButton.text.length <= 0){
        [MBProgressHUD showError:ZYLocalizedString(@"place_detail_place")];
        
    }
    return YES;

}
#pragma mark - delegate方法

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == _placeButton) {
        [_placeButton resignFirstResponder];
        
        
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

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}
- (void)pickerArea:(STPickerArea *)pickerArea province:(NSString *)province city:(NSString *)city area:(NSString *)area
{
    NSString *text = [NSString stringWithFormat:@"%@ %@ %@", province, city, area];
    _placeButton.text = text;
}

@end
