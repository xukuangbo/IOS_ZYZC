//
//  MineMessageController.m
//  ios_zhongyouzhongchou
//
//  Created by mac on 16/4/11.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "MineMessageController.h"
#import "MineMessageModel.h"
#import "MineMessageCell.h"
@interface MineMessageController ()<UITableViewDelegate,UITableViewDataSource,MineMessageCellDelegate>
@property (nonatomic, strong) NSMutableArray *messages;

@property (nonatomic, weak) UITableView *tableView;
@end

@implementation MineMessageController
#pragma mark - 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setNavi];
    
    
    //这里发送一个网络请求，返回一个数据，数据解析成一个nsdictionary的字典,然后转化成一组模型对象
    //现在，我假设已经拥有该对象数组，然后开始写代码
    
    [self createTableView];
    
}

#pragma mark - 初始化方法
- (void)setNavi
{
    [self setBackItem];
    self.navigationItem.title = @"消息";
    UIButton *setItem = [UIButton buttonWithType:UIButtonTypeCustom];
    [setItem setImage:[UIImage imageNamed:@"btn_set"] forState:UIControlStateNormal];
    setItem.size = setItem.currentImage.size;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:setItem];
}
/**
 *  创建tableView
 */
- (void)createTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = MineMessageCellHeight;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor ZYZC_BgGrayColor];
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

/**
 *  模型数组
 */
- (NSMutableArray *)messages
{
    if (!_messages) {
        _messages = [NSMutableArray array];
        
        for (int i = 0; i < 8; i++) {
            MineMessageModel *model = [[MineMessageModel alloc] init];
            model.iconString = @"http://dynamic-image.yesky.com/600x-/uploadImages/upload/20140903/upload/201409/b1ac130pjrapng.png";
            model.newMessageCount = arc4random() % 5;
            model.name = [NSString stringWithFormat:@"瑞克%d",arc4random() % 10];
            model.descString = @"这是一个很牛逼的应用";
            model.time = @"10-11";
            [_messages addObject:model];
            
        }
    }
    
    return _messages;
}


#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"MineMessageCell";
    MineMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[MineMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.delegate = self;
    cell.model = self.messages[indexPath.row];
    return cell;
}

#pragma mark - 删除按钮的代理方法
/**
 *  删除按钮的代理方法
 */
- (void)mineMessageCellDelegate:(UIButton *)button
{
    MineMessageCell * cell = (MineMessageCell *)[[button superview] superview];
    NSIndexPath * path = [self.tableView indexPathForCell:cell];
    
    [self.messages removeObjectAtIndex:path.row];
    [self.tableView deleteRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationFade];
}
//按钮显示的内容
//- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    return @"删除";
//    
//}
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    NSLog(@"........");
//}
@end
