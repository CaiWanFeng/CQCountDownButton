//
//  CQDelegateViewController.m
//  CQCountDownButton
//
//  Created by caiqiang on 2019/2/24.
//  Copyright © 2019年 caiqiang. All rights reserved.
//

#import "CQDelegateViewController.h"
#import "CQCountDownButton.h"

@interface CQDelegateViewController () <CQCountDownButtonDataSource, CQCountDownButtonDelegate>

@property (nonatomic, strong) CQCountDownButton *countDownButton;

@end

@implementation CQDelegateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"delegate版本";
    
    self.countDownButton = [[CQCountDownButton alloc] initWithFrame:CGRectMake(0, 150, self.view.bounds.size.width, 60)];
    [self.view addSubview:self.countDownButton];
    [self.countDownButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.countDownButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [self.countDownButton setTitle:@"点击获取验证码" forState:UIControlStateNormal];
    self.countDownButton.dataSource = self;
    self.countDownButton.delegate = self;
}

- (void)dealloc {
    NSLog(@"页面已释放");
}

#pragma mark - CQCountDownButton DataSource

// 设置起始倒计时秒数
- (NSUInteger)startCountDownNumOfCountDownButton:(CQCountDownButton *)countDownButton {
    return 10;
}

#pragma mark - CQCountDownButton Delegate

// 倒计时按钮点击回调
- (void)countDownButtonDidClick:(CQCountDownButton *)countDownButton {
    [self.countDownButton startCountDown];
}

// 倒计时开始时的回调
- (void)countDownButtonDidStartCountDown:(CQCountDownButton *)countDownButton {
    NSLog(@"倒计时开始");
}

// 倒计时进行中的回调
- (void)countDownButtonDidInCountDown:(CQCountDownButton *)countDownButton withRestCountDownNum:(NSInteger)restCountDownNum {
    NSString *title = [NSString stringWithFormat:@"%ld秒后重试", restCountDownNum];
    [self.countDownButton setTitle:title forState:UIControlStateNormal];
}

// 倒计时结束时的回调
- (void)countDownButtonDidEndCountDown:(CQCountDownButton *)countDownButton {
    [self.countDownButton setTitle:@"点击获取验证码" forState:UIControlStateNormal];
    NSLog(@"倒计时结束");
}

@end
