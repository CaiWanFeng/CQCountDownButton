//
//  SecondViewController.m
//  CQCountDownButton
//
//  Created by 蔡强 on 2017/9/8.
//  Copyright © 2017年 kuaijiankang. All rights reserved.
//

#import "SecondViewController.h"
#import "CQCountDownButton.h"
#import <SVProgressHUD.h>

@interface SecondViewController ()

@property (nonatomic, strong) CQCountDownButton *countDownButton;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    __weak __typeof__(self) weakSelf = self;
    
    self.countDownButton = [[CQCountDownButton alloc] initWithFrame:CGRectMake(90, 90, 150, 30) duration:10 buttonClicked:^{
        //------- 按钮点击 -------//
        [SVProgressHUD showWithStatus:@"正在获取验证码..."];
        // 请求数据
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            int a = arc4random() % 2;
            if (a == 0) {
                // 获取成功
                [SVProgressHUD showSuccessWithStatus:@"验证码已发送"];
                // 获取到验证码后开始倒计时
                [weakSelf.countDownButton startCountDown];
            } else {
                // 获取失败
                [SVProgressHUD showErrorWithStatus:@"获取失败，请重试"];
                weakSelf.countDownButton.enabled = YES;
            }
        });
    } countDownStart:^{
        //------- 倒计时开始 -------//
        NSLog(@"倒计时开始");
    } countDownUnderway:^(NSInteger restCountDownNum) {
        //------- 倒计时进行中 -------//
        [weakSelf.countDownButton setTitle:[NSString stringWithFormat:@"再次获取(%ld秒)", restCountDownNum] forState:UIControlStateNormal];
    } countDownCompletion:^{
        //------- 倒计时结束 -------//
        [weakSelf.countDownButton setTitle:@"点击获取验证码" forState:UIControlStateNormal];
        NSLog(@"倒计时结束");
    }];
    
    [self.view addSubview:self.countDownButton];
    [self.countDownButton setTitle:@"点击获取验证码" forState:UIControlStateNormal];
    [self.countDownButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.countDownButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
}


- (void)dealloc {
    [SVProgressHUD showSuccessWithStatus:@"页面2已释放"];
}

@end
