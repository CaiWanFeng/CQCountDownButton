//
//  CQXibViewController.m
//  CQCountDownButton
//
//  Created by caiqiang on 2019/2/22.
//  Copyright © 2019年 kuaijiankang. All rights reserved.
//

#import "CQXibViewController.h"
#import "CQCountDownButton.h"
#import <SVProgressHUD.h>

@interface CQXibViewController ()

@property (weak, nonatomic) IBOutlet CQCountDownButton *countDownButton;

@end

@implementation CQXibViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"xib测试";
    
    __weak typeof(self) weakSelf = self;
    
    [self.countDownButton configDuration:10 buttonClickedBlock:^{
        NSLog(@"按钮点击");
        //------- 按钮点击 -------//
        [SVProgressHUD showSuccessWithStatus:@"验证码已发送"];
        // 获取到验证码后开始倒计时
        [weakSelf.countDownButton startCountDown];
    } countDownStartBlock:^{
        //------- 倒计时开始 -------//
        NSLog(@"倒计时开始");
    } countDownUnderwayBlock:^(NSInteger restCountDownNum) {
        //------- 倒计时进行中 -------//
        [weakSelf.countDownButton setTitle:[NSString stringWithFormat:@"再次获取(%ld秒)", restCountDownNum] forState:UIControlStateNormal];
    } countDownCompletionBlock:^{
        //------- 倒计时结束 -------//
        [weakSelf.countDownButton setTitle:@"点击获取验证码" forState:UIControlStateNormal];
        NSLog(@"倒计时结束");
    }];
}

- (void)dealloc {
    NSLog(@"controller已释放");
}

@end
