//
//  ZYZCPersonalController.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/6/1.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "ZYZCPersonalController.h"

@interface ZYZCPersonalController ()

@end

@implementation ZYZCPersonalController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setBackItem];
    [self.navigationController.navigationBar cnSetBackgroundColor:[[UIColor ZYZC_NavColor] colorWithAlphaComponent:0]];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
