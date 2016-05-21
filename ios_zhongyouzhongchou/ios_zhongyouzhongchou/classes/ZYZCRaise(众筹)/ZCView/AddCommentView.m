//
//  AddCommentView.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/5/16.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "AddCommentView.h"
#import "MBProgressHUD+MJ.h"
#import "UIView+GetSuperTableView.h"
@interface AddCommentView ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *editFieldView;
@property (nonatomic, strong) UIButton    *sendComentBtn;
@end

@implementation AddCommentView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame=CGRectMake(0, 0, KSCREEN_W, 49);
        [self configUI];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame=CGRectMake(0, 0, KSCREEN_W, 49);
        self.backgroundColor=[UIColor ZYZC_BgGrayColor01];
        [self configUI];
    }
    return self;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver: self name:UITextFieldTextDidChangeNotification object:nil];
}

-(void)configUI
{
    CGFloat buttonWidth=90;
    _editFieldView=[[UITextField alloc]initWithFrame:CGRectMake(KEDGE_DISTANCE, 8, self.width-buttonWidth, 33)];
    _editFieldView.borderStyle=UITextBorderStyleRoundedRect;
    _editFieldView.placeholder=@"点击编写评论";
    _editFieldView.returnKeyType=UIReturnKeyDone;
    _editFieldView.delegate=self;
    [self addSubview:_editFieldView];
    
    //监听文字发生变化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:nil];
    
    
    _sendComentBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    _sendComentBtn.frame=CGRectMake(_editFieldView.right, 0, buttonWidth, self.height);
    _sendComentBtn.layer.cornerRadius=KCORNERRADIUS;
    _sendComentBtn.layer.masksToBounds=YES;
    [_sendComentBtn setTitle:@"发表" forState:UIControlStateNormal];
    [_sendComentBtn setTitleColor:[UIColor ZYZC_TextGrayColor] forState:UIControlStateNormal];
    _sendComentBtn.titleLabel.font=[UIFont systemFontOfSize:20];
    _sendComentBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    [_sendComentBtn addTarget:self  action:@selector(sendMyComment) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_sendComentBtn];
    
    [self addSubview:[UIView lineViewWithFrame:CGRectMake(0, 0, self.width, 1) andColor:nil]];
}

#pragma mark --- 发表评论
-(void)sendMyComment
{
    NSDictionary *parameters= @{@"openid":[ZYZCTool getUserId],@"productId":_productId,@"content":_editFieldView.text};
    if (_editFieldView.text.length) {
        [ZYZCHTTPTool postHttpDataWithEncrypt:YES andURL:COMMENT_PRODUCT andParameters:parameters andSuccessGetBlock:^(id result, BOOL isSuccess) {
            NSLog(@"%@",result);
            if (isSuccess) {
                [MBProgressHUD showSuccess:ZYLocalizedString(@"comment_success")];
                if (!_editFieldView.resignFirstResponder) {
                   [_editFieldView resignFirstResponder];
                }
                _editFieldView.text=nil;
                 [_sendComentBtn setTitleColor:[UIColor ZYZC_TextGrayColor] forState:UIControlStateNormal];
                if (_commentSuccess) {
                    _commentSuccess(_editFieldView.text);
                }
            }
            else
            {
                 [MBProgressHUD showSuccess:ZYLocalizedString(@"comment_fail")];
            }
            
        } andFailBlock:^(id failResult) {
            [MBProgressHUD showSuccess:ZYLocalizedString(@"comment_fail")];
        }];
    }
}

#pragma mark --- textField代理方法
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField==_editFieldView) {
        //监听键盘的出现和收起
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
    }
    return YES;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [_editFieldView resignFirstResponder];
    return YES;
}



#pragma mark --- 文字发生改变
-(void)textChange
{
    if (_editFieldView.text.length) {
        [_sendComentBtn setTitleColor:[UIColor ZYZC_MainColor] forState:UIControlStateNormal];
    }
    else
    {
        [_sendComentBtn setTitleColor:[UIColor ZYZC_TextGrayColor] forState:UIControlStateNormal];
    }
}

#pragma mark --- 键盘出现和收起方法
-(void)keyboardWillShow:(NSNotification *)notify
{
     NSDictionary *dic = notify.userInfo;
     NSValue *value = dic[UIKeyboardFrameEndUserInfoKey];
    CGFloat height=value.CGRectValue.size.height;
    self.bottom-=height;
    if (_keyBoardChange) {
        _keyBoardChange(height,YES);
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}

-(void)keyboardWillHidden:(NSNotification *)notify
{
    NSDictionary *dic = notify.userInfo;
    NSValue *value = dic[UIKeyboardFrameEndUserInfoKey];
    CGFloat height=value.CGRectValue.size.height;
    self.bottom+=height;
    if (_keyBoardChange) {
        _keyBoardChange(height,NO);
    }
    [[NSNotificationCenter defaultCenter] removeObserver: self name:UIKeyboardWillHideNotification object:nil];
}



@end
