//
//  CQDelegateViewController.m
//  CQCountDownButton
//
//  Created by caiqiang on 2019/2/24.
//  Copyright © 2019年 caiqiang. All rights reserved.
//

#import "CQDelegateViewController.h"
#import "CQCountDownButton.h"
#import <SVProgressHUD.h>

@interface CQDelegateViewController () <CQCountDownButtonDataSource, CQCountDownButtonDelegate>

@property (nonatomic, strong) CQCountDownButton *countDownButton;

@end

@implementation CQDelegateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"delegate版本";
    
    self.countDownButton = [[CQCountDownButton alloc] initWithFrame:CGRectMake(100, 100, 200, 40)];
    [self.view addSubview:self.countDownButton];
    self.countDownButton.dataSource = self;
    self.countDownButton.delegate = self;
    [self.countDownButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.countDownButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [self.countDownButton setTitle:@"点击获取验证码" forState:UIControlStateNormal];
}

- (void)dealloc {
    NSLog(@"页面已释放");
}

// 设置起始倒计时秒数
- (NSInteger)startCountdownNumOfCountdownButton:(CQCountDownButton *)countdownButton {
    return 10;
}


// 倒计时按钮点击时回调
- (void)countdownButtonDidClick:(CQCountDownButton *)countdownButton {
    //------- 按钮点击 -------//
    [SVProgressHUD showWithStatus:@"正在获取验证码..."];
    // 模拟数据请求
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        int a = arc4random() % 2;
        if (a == 0) {
            // 获取成功
            [SVProgressHUD showSuccessWithStatus:@"验证码已发送"];
            // 获取到验证码后开始倒计时
            [self.countDownButton startCountDown];
        } else {
            // 获取失败
            [SVProgressHUD showErrorWithStatus:@"获取失败，请重试"];
            [self.countDownButton endCountDown];
        }
    });
}

// 倒计时进行中的回调
- (void)countdownButtonDidCountdown:(CQCountDownButton *)countdownButton withRestCountdownNum:(NSInteger)restCountdownNum {
    NSString *title = [NSString stringWithFormat:@"%ld秒后重试", restCountdownNum];
    [self.countDownButton setTitle:title forState:UIControlStateNormal];
}

// 倒计时结束时的回调
- (void)countdownButtonDidEndCountdown:(CQCountDownButton *)countdownButton {
    [self.countDownButton setTitle:@"点击获取验证码" forState:UIControlStateNormal];
    NSLog(@"倒计时结束");
}


@end
