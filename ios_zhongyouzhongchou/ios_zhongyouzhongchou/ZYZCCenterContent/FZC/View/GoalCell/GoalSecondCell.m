//
//  GoalSecondCell.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/3/18.
//  Copyright © 2016年 liuliang. All rights reserved.
//
#define ALERTTEXT @"上传诱人的美景做封面"//添加风景图提示文字
#import "GoalSecondCell.h"
#import "ChooseSceneImgController.h"
#import "SelectImageViewController.h"
#import "UIView+GetSuperTableView.h"
#import "MoreFZCViewController.h"
@implementation GoalSecondCell

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
    self.bgImg.height=SECONDCELLHEIGHT;
    [self.titleLab removeFromSuperview];
    _textField= [[UITextField alloc]initWithFrame:CGRectMake(2*KEDGE_DISTANCE, 15, KSCREEN_W-40, 20)];
    _textField.borderStyle=UITextBorderStyleNone;
    _textField.placeholder=@"编写旅行主题名";
    _textField.font=[UIFont systemFontOfSize:17];
    _textField.delegate=self;
    _textField.returnKeyType=UIReturnKeyDone;
    [self.contentView addSubview:_textField];
    
    //添加空白框架背景
    UIImageView *frameImg=[[UIImageView alloc]initWithFrame:CGRectMake(2*KEDGE_DISTANCE, self.topLineView.bottom+KEDGE_DISTANCE, KSCREEN_W-4*KEDGE_DISTANCE, 125*KCOFFICIEMNT)];
    frameImg.layer.cornerRadius=5;
    frameImg.layer.masksToBounds=YES;
    frameImg.layer.borderWidth=1;
    frameImg.layer.borderColor=[UIColor ZYZC_BgGrayColor].CGColor;
    frameImg.userInteractionEnabled=YES;
    [self.contentView addSubview:frameImg];
    _frameImg=frameImg;
    //添加提示文字lab
    CGFloat labWidth=[ZYZCTool calculateStrLengthByText:ALERTTEXT andFont:[UIFont systemFontOfSize:15] andMaxWidth:KSCREEN_W].width+5;
    UILabel *alertLab=[[UILabel alloc]initWithFrame:CGRectMake((frameImg.width-labWidth-26)/2, (frameImg.height-20)/2, 0, 0)];
    alertLab.font=[UIFont systemFontOfSize:15];
    alertLab.text=ALERTTEXT;
    alertLab.textColor=[UIColor ZYZC_TextGrayColor01];
    [alertLab setSize:CGSizeMake(labWidth, 20)];
    [frameImg addSubview:alertLab];
    //添加图片标示
    UIImageView *iconImg=[[UIImageView alloc]initWithFrame:CGRectMake(alertLab.right, (frameImg.height-19)/2,26, 19)];
    iconImg.userInteractionEnabled=NO;
    iconImg.image=[UIImage imageNamed:@"ico_fmpic"];
    [frameImg addSubview:iconImg];
    
    //给图片添加点击手势
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapHappen:)];
    [frameImg addGestureRecognizer:tap];
}

#pragma mark --- 选择图片
-(void)tapHappen:(UITapGestureRecognizer *)tap
{
    _imagePicker = [[UIImagePickerController alloc] init];
    _imagePicker.delegate = self;
    _imagePicker.allowsEditing = YES;
    __weak typeof (&*self)weakSelf=self;
    //创建UIAlertController控制器
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    //选择众游图库
    UIAlertAction *collectionAction = [UIAlertAction actionWithTitle:@"众游图库" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action){
            ChooseSceneImgController *chooseImgVC=[[ChooseSceneImgController alloc]init];
            [weakSelf.viewController.navigationController pushViewController:chooseImgVC animated:YES];
    }];
    //选择本地相册
    UIAlertAction *draftsAction = [UIAlertAction actionWithTitle:@"本地相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        weakSelf.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [weakSelf.viewController presentViewController:weakSelf.imagePicker animated:YES completion:nil];
    }];
    //选择拍照
    UIAlertAction *giftCardAction = [UIAlertAction actionWithTitle:@"拍照获取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        weakSelf.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [weakSelf.viewController presentViewController:weakSelf.imagePicker animated:YES completion:nil];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:collectionAction];
    [alertController addAction:draftsAction];
    [alertController addAction:giftCardAction];
    
    [self.viewController presentViewController:alertController animated:YES completion:nil];
}

#pragma mark --- 获取本地照片
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    __weak typeof (&*self)weakSelf=self;
    [picker dismissViewControllerAnimated:YES completion:^{
        SelectImageViewController *selectImgVC=[[SelectImageViewController alloc]init];
        selectImgVC.selectImage=[info objectForKey:UIImagePickerControllerOriginalImage];
        selectImgVC.imageBlock=^(UIImage *img)
        {
            weakSelf.frameImg.image=img;
        };
        [weakSelf.viewController.navigationController pushViewController:selectImgVC animated:YES];
    }];
}

#pragma mark --- textField代理方法
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_textField endEditing:YES];
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    //监听键盘的出现和收起
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
    return YES;
}

#pragma mark --- 键盘出现和收起方法
-(void)keyboardWillShow:(NSNotification *)notify
{
    MoreFZCViewController *superVC=(MoreFZCViewController *)self.viewController;
    __weak typeof (&*self)weakSelf=self;
    superVC.goalKeyBordHidden=^()
    {
        [weakSelf.textField resignFirstResponder];
    };

    self.getSuperTableView.contentInset=UIEdgeInsetsMake(-100, 0, 0, 0);
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    
}

-(void)keyboardWillHidden:(NSNotification *)notify
{
    self.getSuperTableView.contentInset = UIEdgeInsetsMake(64 + 40, 0, 49, 0);
    [[NSNotificationCenter defaultCenter] removeObserver: self name:UIKeyboardWillHideNotification object:nil];
}

@end