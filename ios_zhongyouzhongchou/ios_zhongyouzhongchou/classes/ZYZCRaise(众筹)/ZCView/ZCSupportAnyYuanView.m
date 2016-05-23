//
//  ZCSupportAnyYuanView.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/5/20.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "ZCSupportAnyYuanView.h"

@implementation ZCSupportAnyYuanView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)configUI
{
    [super configUI];
    [self.limitLab removeFromSuperview];
    
    //编辑任意金额
    _textField=[[UITextField alloc]initWithFrame:CGRectMake(self.titleLab.right, self.titleLab.top-2, 80, self.titleLab.height+4)];
    _textField.delegate=self;
    _textField.placeholder=@"¥";
    _textField.returnKeyType=UIReturnKeyDone;
    _textField.backgroundColor= [UIColor ZYZC_TabBarGrayColor];
    _textField.font=[UIFont systemFontOfSize:14];
    [self addSubview:_textField];
    
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(_textField.right, self.titleLab.top, 20, self.titleLab.height)];
    lab.text=@"元";
    lab.textColor=[UIColor ZYZC_TextBlackColor];
    lab.font=[UIFont systemFontOfSize:15];
    [self addSubview:lab];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}



@end
