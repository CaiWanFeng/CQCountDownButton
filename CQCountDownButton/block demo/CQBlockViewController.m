//
//  CQBlockViewController.m
//  CQCountDownButton
//
//  Created by caiqiang on 2019/2/24.
//  Copyright © 2019年 caiqiang. All rights reserved.
//

#import "CQBlockViewController.h"
#import "CQCountDownButton.h"

@interface CQBlockViewController ()

@property (nonatomic, strong) CQCountDownButton *countDownButton;

@end

@implementation CQBlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"block版本";
    
    self.countDownButton = [[CQCountDownButton alloc] initWithFrame:CGRectMake(0, 140, self.view.bounds.size.width, 60)];
    [self.view addSubview:self.countDownButton];
    [self.countDownButton setTitle:@"点击获取验证码" forState:UIControlStateNormal];
    [self.countDownButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.countDownButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    
    __weak typeof(self) weakSelf = self;
    [self.countDownButton configDuration:10 buttonClicked:^{
        //========== 按钮点击 ==========//
        [weakSelf.countDownButton startCountDown];
    } countDownStart:^{
        //========== 倒计时开始 ==========//
        NSLog(@"倒计时开始");
    } countDownUnderway:^(NSInteger restCountDownNum) {
        //========== 倒计时进行中 ==========//
        NSString *title = [NSString stringWithFormat:@"%ld秒后重试", restCountDownNum];
        [weakSelf.countDownButton setTitle:title forState:UIControlStateNormal];
    } countDownCompletion:^{
        //========== 倒计时结束 ==========//
        [weakSelf.countDownButton setTitle:@"点击获取验证码" forState:UIControlStateNormal];
        NSLog(@"倒计时结束");
    }];
}

- (void)dealloc {
    NSLog(@"页面已释放");
}

@end
