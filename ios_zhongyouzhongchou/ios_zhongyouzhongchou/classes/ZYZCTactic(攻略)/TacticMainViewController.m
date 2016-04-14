//
//  TacticMainViewController.m
//  ios_zhongyouzhongchou
//
//  Created by liuliang on 16/4/13.
//  Copyright © 2016年 liuliang. All rights reserved.
//

#import "TacticMainViewController.h"

#define  SITEDATA @"http://121.40.225.119:8080/viewSpot/getViewSpot.action?viewId=90"
@interface TacticMainViewController ()
{
    NSArray *textArr;
}
@property (nonatomic, strong) UITextView *textView;
@end

@implementation TacticMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _textView=[[UITextView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_W, KSCREEN_H-KTABBAR_HEIGHT)];
    _textView.font=[UIFont systemFontOfSize:17];
    _textView.editable=NO;
    [self.view addSubview:_textView];
    [self getHttpData];
    
}

-(void)getHttpData
{
    [ZYZCHTTPTool  getHttpDataByURL:SITEDATA withSuccessGetBlock:^(id result, BOOL isSuccess) {
//        NSLog(@"%@",result);
        NSDictionary *dict = result;
//        NSLog(@"%@",dict);
//        NSLog(@"%@",dict[@"data"][@"viewText"]);
        _textView.text=[NSString stringWithFormat:@"%@",dict[@"data"][@"viewText"]];
        
//        textArr=[_textView.text componentsSeparatedByString:@"\r\n\r\n"];
//        
//        NSMutableArray *newTextArr=[NSMutableArray array];
//        [newTextArr addObject:textArr[0]];
//        if (textArr.count>=1) {
//            for (int i=1; i<textArr.count; i++) {
//                NSArray *subTextArr=[textArr[i] componentsSeparatedByString:@"\r\n"];
//               NSMutableAttributedString *attrStr=[[NSMutableAttributedString alloc]initWithString:subTextArr[0]];
//                [attrStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:17] range:NSMakeRange(0, attrStr.length)];
//                NSMutableArray *newArr=[NSMutableArray array];
//                [newArr addObject:attrStr];
//                for (int i=1; i<subTextArr.count; i++) {
//                    [newArr addObject:subTextArr[i]];
//                }
//                
//                NSString *newStr=[newArr componentsJoinedByString:@"\r\n"];
//                [newTextArr addObject:newStr];
//            }
//        }
//        NSString *finalText=[newTextArr componentsJoinedByString:@"\r\n\r\n"];
//        _textView.text=finalText;
        
    } andFailBlock:^(id failResult) {
        NSLog(@"%@",failResult);
    }];
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
