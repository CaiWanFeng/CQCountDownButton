## 你或许想不到，一个简单的倒计时按钮还能这样玩。。。

### 详情：

- 优雅的倒计时button：http://www.jianshu.com/p/34e87194fb83
- 清晰的倒计时button：https://www.jianshu.com/p/e2ff2260d9a3
- 用于解决循环引用的block timer：https://www.jianshu.com/p/1a4661e97f7c
- block与delegate在代码组织上的特点：https://www.jianshu.com/p/4e2182fc3355

### 功能：

- 支持纯代码frame布局和自动布局，也支持xib和storyboard
- 提供block与delegate两种回调方式

### 用法：

#### 1.block版本

```objective-c
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
```

#### 2.delegate版本

```objective-c
self.countDownButton.dataSource = self;
self.countDownButton.delegate = self;

#pragma mark - CQCountDownButton DataSource

// 设置倒计时总时间
- (NSInteger)startCountDownNumOfCountDownButton:(CQCountDownButton *)countDownButton {
    return 10;
}

#pragma mark - CQCountDownButton Delegate

// 倒计时按钮点击时回调
- (void)countDownButtonDidClick:(CQCountDownButton *)countDownButton {
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

// 倒计时开始的回调
- (void)countDownButtonDidStartCountDown:(CQCountDownButton *)countDownButton {
    NSLog(@"倒计时开始");
}

// 倒计时进行中的回调
- (void)countDownButtonDidCountDown:(CQCountDownButton *)countDownButton withRestCountDownNum:(NSInteger)restCountDownNum {
    NSString *title = [NSString stringWithFormat:@"%ld秒后重试", restCountDownNum];
    [self.countDownButton setTitle:title forState:UIControlStateNormal];
}

// 倒计时结束时的回调
- (void)countDownButtonDidEndCountDown:(CQCountDownButton *)countDownButton {
    [self.countDownButton setTitle:@"点击获取验证码" forState:UIControlStateNormal];
    NSLog(@"倒计时结束");
}
```

