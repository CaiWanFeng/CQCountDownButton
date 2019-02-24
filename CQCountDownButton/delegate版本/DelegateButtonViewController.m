//
//  DelegateButtonViewController.m
//  CQCountDownButton
//
//  Created by caiqiang on 2019/2/23.
//  Copyright © 2019年 kuaijiankang. All rights reserved.
//

#import "DelegateButtonViewController.h"
#import "CQCountDownButton.h"

@interface DelegateButtonViewController () <CQCountDownButtonDataSource, CQCountDownButtonDelegate>

@property (nonatomic, strong) CQCountDownButton *countDownButton;

@end

@implementation DelegateButtonViewController

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
    [self.countDownButton startCountDown];
    NSLog(@"按钮点击");
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
