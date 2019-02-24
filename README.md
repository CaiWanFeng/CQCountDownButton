## 实用又好用的倒计时button

### 详情：

- 优雅的倒计时button：http://www.jianshu.com/p/34e87194fb83
- 清晰的倒计时button：https://www.jianshu.com/p/e2ff2260d9a3
- 用于解决循环引用的block timer：https://www.jianshu.com/p/1a4661e97f7c

### 功能

- 支持纯代码frame布局与自动布局，也支持xib和storyboard
- 提供两种回调方式：block和delegate（block让代码更集中，delegate让代码更加层次分明）

### 用法：

#### 1.纯代码版本

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

#### 2.xib或storyboard版本

```objective-c
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
```

#### 3.delegate版本

