### 通用倒计时button

#### 详情：

- 优雅的倒计时button：http://www.jianshu.com/p/34e87194fb83
- 用于解决循环引用的block timer：https://www.jianshu.com/p/1a4661e97f7c

#### 用法：

```objective-c
 __weak typeof(self) weakSelf = self;
 
 self.countDownButton = [[CQCountDownButton alloc] initWithDuration:10 buttonClicked:^{
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
 self.countDownButton.frame = CGRectMake(90, 90, 200, 30);
 [self.countDownButton setTitle:@"点击获取验证码" forState:UIControlStateNormal];
 [self.countDownButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
 [self.countDownButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
```





