## 实用又好用的倒计时button

### 详情：

- 优雅的倒计时button：http://www.jianshu.com/p/34e87194fb83
- 清晰的倒计时button：https://www.jianshu.com/p/e2ff2260d9a3
- 用于解决循环引用的block timer：https://www.jianshu.com/p/1a4661e97f7c

### 功能：

- 支持纯代码frame布局与自动布局，也支持xib和storyboard
- 提供两种回调方式：block和delegate（block让代码更集中，delegate让代码更加层次分明）

### 用法：

#### 1.block版本

```objective-c
__weak typeof(self) weakSelf = self;
[self.countDownButton configDuration:10 buttonClickedBlock:^{
    [weakSelf.countDownButton startCountDown];
} countDownStartBlock:^{
    NSLog(@"倒计时开始");
} countDownUnderwayBlock:^(NSInteger restCountDownNum) {
    NSString *title = [NSString stringWithFormat:@"%ld秒后重试", restCountDownNum];
    [weakSelf.countDownButton setTitle:title forState:UIControlStateNormal];
} countDownCompletionBlock:^{
    [weakSelf.countDownButton setTitle:@"点击获取验证码" forState:UIControlStateNormal];
    NSLog(@"倒计时结束");
}];
```

#### 2.delegate版本

```objective-c
self.countDownButton.dataSource = self;
self.countDownButton.delegate = self;

#pragma mark - CQCountDownButton DataSource && Delegate

// 设置倒计时秒数
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

// 倒计时进行中回调
- (void)countdownButtonDidCountdown:(CQCountDownButton *)countdownButton withRestCountdownNum:(NSInteger)restCountdownNum {
    NSString *title = [NSString stringWithFormat:@"%ld秒后重试", restCountdownNum];
    [self.countDownButton setTitle:title forState:UIControlStateNormal];
}

// 倒计时结束时回调
- (void)countdownButtonDidEndCountdown:(CQCountDownButton *)countdownButton {
    [self.countDownButton setTitle:@"点击获取验证码" forState:UIControlStateNormal];
    NSLog(@"倒计时结束");
}
```

