//
//  MinePersonSetUpController.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/5/12.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "MinePersonSetUpController.h"

@interface MinePersonSetUpController ()

@end

@implementation MinePersonSetUpController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackItem];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"123"];
    return cell;
}
@end
