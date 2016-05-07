
//
//  ReturnThirdCellTwo.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/5/2.
//  Copyright © 2016年 liuliang. All rights reserved.
//
#import "ReturnCellBaseBGView.h"
#import "ReturnThirdCellTwo.h"
#import "MoreFZCViewController.h"
#import "MoreFZCReturnTableView.h"
#import "UIView+GetSuperTableView.h"

@implementation ReturnThirdCellTwo
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        ReturnCellBaseBGView *bgImageView = [ReturnCellBaseBGView viewWithRect:CGRectMake(ReturnThirdCellTwoMargin, 0, KSCREEN_W - 20, ReturnThirdCellTwoHeight) title:@"回报众筹2" image:[UIImage imageNamed:@"btn_xs_one_n_pre"] selectedImage:[UIImage imageNamed:@"btn_xs_one_pre"] desc:@"可多次支持，最多可支持众筹剩余金额的ReturnThirdCellTwoMargin0%。每支持一元,可与发起人增加1的亲密度。如果众筹失败，支持金额全额退返。可多次支持，最多可支持众筹剩余金额的ReturnThirdCellTwoMargin0%。每支持一元,可与发起人增加1的亲密度。如果众筹失败，支持金额全额退返。可多次支持，最多可支持众筹剩余金额的ReturnThirdCellTwoMargin0%。每支持一元,可与发起人增加1的亲密度。如果众筹失败，支持金额全额退返。可多次支持，最多可支持众筹剩余金额的ReturnThirdCellTwoMargin0%。每支持一元,可与发起人增加1的亲密度。如果众筹失败，支持金额全额退返。可多次支持，最多可支持众筹剩余金额的ReturnThirdCellTwoMargin0%。每支持一元,可与发起人增加1的亲密度。如果众筹失败，支持金额全额退返。"];
        self.bgImageView = bgImageView;
        [self.contentView addSubview:bgImageView];
        self.bgImageView.userInteractionEnabled = YES;
        self.bgImageView.iconButton.enabled = YES;
        self.bgImageView.iconButton.selected = YES;
        self.bgImageView.index = 3;
        
        
        [self createPeopleView];
        
        
    }
    return self;
}

/**
 *  创建可以填写的view
 */
- (void)createPeopleView
{
    UIView *peopleView = [[UIView alloc] initWithFrame:CGRectMake(ReturnThirdCellTwoMargin, self.bgImageView.descLabel.bottom + ReturnThirdCellTwoMargin, self.bgImageView.width, 400)];
    [self.bgImageView addSubview:peopleView];
    self.peopleView = peopleView;
    
    self.peopleTextfiled = [self viewWithFrame:CGRectMake(0, 1, self.peopleView.width, 81) titleName:@"人数设置:" leftViewName:nil textfiledPlaceholder:@"请输入人数  人"];
    
    if ([MoreFZCDataManager sharedMoreFZCDataManager].return_returnPeopleNumber01) {
        self.peopleTextfiled.text = [MoreFZCDataManager sharedMoreFZCDataManager].return_returnPeopleNumber01;
    }
    
    self.moneyTextFiled = [self viewWithFrame:CGRectMake(0, self.peopleTextfiled.bottom + 2, self.peopleView.width, 81) titleName:@"支持金额:" leftViewName:@"￥" textfiledPlaceholder:@"00.00元"];
    if ([MoreFZCDataManager sharedMoreFZCDataManager].return_returnPeopleNumber01) {
        self.moneyTextFiled.text = [MoreFZCDataManager sharedMoreFZCDataManager].return_returnPeopleMoney01;
    }
    
    //先创建一个标题view
    //1.灰色虚线
    UIView *entrylineView = [UIView lineViewWithFrame:CGRectMake(0, self.moneyTextFiled.bottom * 2 + 10, self.peopleView.width-2*KEDGE_DISTANCE, 1) andColor:[UIColor ZYZC_LineGrayColor]];
    [self.peopleView addSubview:entrylineView];
    //2.1创建人数设置
    UILabel *entryTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, entrylineView.bottom, self.peopleView.width, 30)];
    entryTitleLabel.text = @"回报描述";
    [self.peopleView addSubview:entryTitleLabel];
    
    //创建完后可以创建那个语音录入的内容
    FZCContentEntryView *entryView = [[FZCContentEntryView alloc] initWithFrame:CGRectMake(0, entryTitleLabel.bottom, self.peopleView.width, 200)];
    entryView.contentBelong=RETURN_02_CONTENTBELONG;
    [self.peopleView addSubview:entryView];
    self.entryView = entryView;
    
}


/**
 *  用于创建两个比较相似的view，金钱和人数设置
 */
- (UITextField *)viewWithFrame:(CGRect)frame titleName:(NSString *)titleName leftViewName:(NSString *)leftName textfiledPlaceholder:(NSString *)placeholder
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    [self.peopleView addSubview:view];
    //1.灰色虚线
    UIView *lineView = [UIView lineViewWithFrame:CGRectMake(0, 0, view.width-2*KEDGE_DISTANCE, 1) andColor:[UIColor ZYZC_LineGrayColor]];
    [view addSubview:lineView];
    //2.1创建人数设置
    UILabel *numberPeopleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 1, view.width, 30)];
    numberPeopleLabel.text = titleName;
    [view addSubview:numberPeopleLabel];
    
    //2.2创建人数设置输入框
    //这里应该创建一个00.00元的textfiled
    UITextField *TextFiled = [[UITextField alloc] init];
    TextFiled.left = 77.5;
    TextFiled.height = 40;
    TextFiled.top = numberPeopleLabel.bottom + ReturnThirdCellTwoMargin;
    TextFiled.width = view.width - TextFiled.left * 2;
    TextFiled.textAlignment = NSTextAlignmentCenter;
    TextFiled.keyboardType = UIKeyboardTypeNumberPad;
    TextFiled.returnKeyType = UIReturnKeyDone;
    //    TextFiled.text = placeholder;
    TextFiled.placeholder = placeholder;
    TextFiled.delegate = self;
    //    TextFiled.textColor = [UIColor ZYZC_TextGrayColor];
    TextFiled.backgroundColor = [UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1];
    TextFiled.clearsOnBeginEditing = YES;
    //    TextFiled.backgroundColor = [UIColor cyanColor];
    [view addSubview:TextFiled];
    
    
    //￥钱的字样
    if (leftName) {
        UILabel *sightLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, TextFiled.height, TextFiled.height)];
        sightLabel.textAlignment = NSTextAlignmentCenter;
        sightLabel.font = [UIFont systemFontOfSize:15];
        sightLabel.text = leftName;
        TextFiled.leftView = sightLabel;
        TextFiled.leftViewMode = UITextFieldViewModeAlways;
    }
    return TextFiled;
}


/**
 *  输出子控件
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
}



- (void)setOpen:(BOOL)open
{
    if (_open != open) {
        _open = open;
        
        if (open == YES) {
            //这里就是展开，改变所有东西的值
            self.bgImageView.height = ReturnThirdCellTwoHeight + 200;
            self.bgImageView.descLabel.numberOfLines = 0;
            self.bgImageView.descLabel.height = 290;
            self.bgImageView.downButton.bottom = self.bgImageView.descLabel.bottom;
            //            self.bgImageView.downButton.hidden = YES;
            
            self.peopleView.top = self.bgImageView.descLabel.bottom ;
            
        }else{
            self.bgImageView.height = ReturnThirdCellTwoHeight;
            self.bgImageView.descLabel.numberOfLines = 3;
            self.bgImageView.descLabel.height = 90;
            self.bgImageView.downButton.bottom = self.bgImageView.descLabel.bottom;
            self.peopleView.top = self.bgImageView.descLabel.bottom + ReturnThirdCellTwoMargin;
        }
    }
}

/**
 *  监听键盘的退出,已退出就记录数据
 */
- (void)keyboardWillHide:(NSNotification *)noti
{
    [MoreFZCDataManager sharedMoreFZCDataManager].return_returnPeopleMoney01 = self.moneyTextFiled.text;
    [MoreFZCDataManager sharedMoreFZCDataManager].return_returnPeopleNumber01 = self.peopleTextfiled.text;
}

- (void)reloadManagerData
{
    MoreFZCDataManager *mgr = [MoreFZCDataManager sharedMoreFZCDataManager];
    if (mgr.return_returnPeopleNumber01) {
        self.peopleTextfiled.text = mgr.return_returnPeopleNumber01;
    }
    if (mgr.return_returnPeopleMoney01) {
        self.moneyTextFiled.text = mgr.return_returnPeopleMoney01;
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField endEditing:YES];
    return YES;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    //注册键盘出现的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardDidHideNotification object:nil];
    return YES;
}

#pragma mark - 系统键盘的弹出
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    MoreFZCViewController *superVC=(MoreFZCViewController *)self.viewController;
    __weak typeof (&*self)weakSelf=self;
    superVC.returnKeyBordHidden=^(){
        [weakSelf.moneyTextFiled resignFirstResponder];
        [weakSelf.peopleTextfiled resignFirstResponder];
    };
    
    MoreFZCReturnTableView *table=(MoreFZCReturnTableView *)self.getSuperTableView;
    if (table.keyboardOpen == YES){
        return;
    }
    //键盘高度
    CGRect keyBoardFrame = [[[aNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //如果已经弹出键盘的话，就不应该进行这个步骤
    CGPoint contentOffset = table.contentOffset;
    contentOffset.y += keyBoardFrame.size.height;
    table.contentOffset = contentOffset;
    table.keyboardOpen = YES;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    MoreFZCReturnTableView *table=(MoreFZCReturnTableView *)self.getSuperTableView;
    //键盘高度
    CGRect keyBoardFrame = [[[aNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGPoint contentOffset = table.contentOffset;
    contentOffset.y -= keyBoardFrame.size.height;
    table.contentOffset = contentOffset;
    table.keyboardOpen = NO;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}


@end
