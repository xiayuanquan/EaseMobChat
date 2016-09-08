//
//  ViewController.m
//  EaseMobChat
//
//  Created by mac on 16/9/8.
//  Copyright © 2016年 xiayuanquan. All rights reserved.
//

#import "ViewController.h"
#import "CustomChatViewController.h"
#import "ChatViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"手势点击就可以跳转到聊天界面";
    
    
    //注册账号
    [[EaseMob sharedInstance].chatManager asyncRegisterNewAccount:@"easeuidemo" password:@"1" withCompletion:^(NSString *username, NSString *password, EMError *error) {
        NSLog(@"%@",error);
        if (!error) {
            NSLog(@"注册成功");
        }
    } onQueue:nil];
    
    
    //登录账号
    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:@"easeuidemo" password:@"1" completion:^(NSDictionary *loginInfo, EMError *error) {
        if (!error && loginInfo) {
            NSLog(@"%@",error);
            NSLog(@"登陆成功");
            //获取数据库中数据
            [[EaseMob sharedInstance].chatManager loadDataFromDatabase];
        }
    } onQueue:nil];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //单聊(视频和电话未实现）
    //ChatViewController *chatVC = [[ChatViewController alloc] initWithConversationChatter:@"111" conversationType:eConversationTypeChat];
    //[self.navigationController pushViewController:chatVC animated:YES];
    
    
    //除了单聊，还可以视频和电话
    CustomChatViewController *cusChatVC = [[CustomChatViewController alloc] initWithConversationChatter:@"111" conversationType:eConversationTypeChat];
    [self.navigationController pushViewController:cusChatVC animated:YES];
}

@end
