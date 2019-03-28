//
//  CQQuickStartController.m
//  CQCountDownButton
//
//  Created by caiqiang on 2019/3/28.
//  Copyright © 2019 kuaijiankang. All rights reserved.
//

#import "CQQuickStartController.h"
#import "CQCountDownButton.h"

@interface CQQuickStartController () <CQCountDownButtonDataSource, CQCountDownButtonDelegate>

@end

@implementation CQQuickStartController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"直接开启倒计时";
    
    //------- 直接倒计时 block版本倒计时按钮 -------//
    CQCountDownButton *blockButton = [[CQCountDownButton alloc] initWithFrame:CGRectMake(20, 150, 300, 40)];
    [self.view addSubview:blockButton];
    blockButton.backgroundColor = [UIColor orangeColor];
    __weak typeof(blockButton) weakButton = blockButton;
    [blockButton configDuration:10 buttonClicked:^{
        //------- 按钮点击 -------//
        NSLog(@"再次倒计时");
        [weakButton startCountDown];
    } countDownStart:nil countDownUnderway:^(NSInteger restCountDownNum) {
        //------- 倒计时进行中 -------//
        NSString *title = [NSString stringWithFormat:@"%ld秒后重试 block", restCountDownNum];
        [weakButton setTitle:title forState:UIControlStateNormal];
    } countDownCompletion:^{
        //------- 倒计时结束 -------//
        [weakButton setTitle:@"点击再次倒计时" forState:UIControlStateNormal];
    }];
    // 直接开始倒计时
    [blockButton startCountDown];
    
    
    //------- 直接倒计时 delegate版本倒计时按钮 -------//
    CQCountDownButton *delegateButton = [[CQCountDownButton alloc] initWithFrame:CGRectMake(20, 220, 300, 40)];
    [self.view addSubview:delegateButton];
    delegateButton.backgroundColor = [UIColor blueColor];
    delegateButton.dataSource = self;
    delegateButton.delegate = self;
    // 直接开始倒计时
    [delegateButton startCountDown];
}

- (void)dealloc {
    NSLog(@"页面释放");
}

#pragma mark - CQCountDownButton DataSource

- (NSUInteger)startCountDownNumOfCountDownButton:(CQCountDownButton *)countDownButton {
    return 10;
}

#pragma mark - CQCountDownButton Delegate

// 倒计时进行中
- (void)countDownButtonDidInCountDown:(CQCountDownButton *)countDownButton withRestCountDownNum:(NSInteger)restCountDownNum {
    NSString *title = [NSString stringWithFormat:@"%ld秒后重试 delegate", restCountDownNum];
    [countDownButton setTitle:title forState:UIControlStateNormal];
}

// 倒计时结束
- (void)countDownButtonDidEndCountDown:(CQCountDownButton *)countDownButton {
    [countDownButton setTitle:@"倒计时已结束 delegate" forState:UIControlStateNormal];
    countDownButton.backgroundColor = [UIColor grayColor];
}

@end
