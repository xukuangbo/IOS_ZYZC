//
//  ZYZCBaseTableViewController.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/5/12.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "ZYZCBaseTableViewController.h"
#define home_navi_bgcolor(alpha) [[UIColor ZYZC_NavColor] colorWithAlphaComponent:alpha]

@interface ZYZCBaseTableViewController ()
@end

@implementation ZYZCBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor ZYZC_BgGrayColor];
    [self.navigationController.navigationBar cnSetBackgroundColor:[UIColor ZYZC_NavColor]];
    self.navigationController.navigationBar.titleTextAttributes=
    @{NSForegroundColorAttributeName:[UIColor whiteColor],
      NSFontAttributeName:[UIFont boldSystemFontOfSize:20]};
}

-(void)setBackItem
{
    self.navigationItem.leftBarButtonItem=[self customItemByImgName:@"btn_back_new" andAction:@selector(pressBack)];
}

-(void)customNavWithLeftBtnImgName:(NSString *)leftName andRightImgName:(NSString *)rightName andLeftAction:(SEL)leftAction andRightAction:(SEL)rightAction
{
    self.navigationItem.leftBarButtonItem=[self customItemByImgName:leftName andAction:leftAction];
    self.navigationItem.rightBarButtonItem=[self customItemByImgName:rightName andAction:rightAction];
}


-(UIBarButtonItem *)customItemByImgName:(NSString *)imgName andAction:(SEL)action
{
    return [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:imgName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:action];
}

-(void)pressBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - set方法
- (NSString *)titleName
{
    if (!_titleName) {
        _titleName = @"";
    }
    return _titleName;
}
- (CGFloat)imageViewHeight
{
    if (!_imageViewHeight) {
        _imageViewHeight = KSCREEN_W / 16 * 9;
    }
    return _imageViewHeight;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

#pragma mark - UIScrollViewDelegate
/**
 *  navi背景色渐变的效果
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    
    
    if (offsetY <= self.imageViewHeight) {
        CGFloat alpha = MAX(0, offsetY/self.imageViewHeight);
        
        [self.navigationController.navigationBar cnSetBackgroundColor:home_navi_bgcolor(alpha)];
        self.title = @"";
    } else {
        [self.navigationController.navigationBar cnSetBackgroundColor:home_navi_bgcolor(1)];
        self.title = self.titleName;
        
    }
}
@end
