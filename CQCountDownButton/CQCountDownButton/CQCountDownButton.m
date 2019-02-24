//
//  CQCountDownButton.m
//  CQCountDownButton
//
//  Created by CaiQiang on 2017/9/8.
//  Copyright © 2017年 kuaijiankang. All rights reserved.
//

//========== 倒计时button ==========//

#import "CQCountDownButton.h"
#import "NSTimer+CQBlockSupport.h"

@interface CQCountDownButton ()

/** 控制倒计时的timer */
@property (nonatomic, strong) NSTimer *timer;
/** 按钮点击事件的回调 */
@property (nonatomic, copy) ButtonClickedBlock buttonClickedBlock;
/** 倒计时开始时的回调 */
@property (nonatomic, copy) CountDownStartBlock countDownStartBlock;
/** 倒计时进行中的回调（每秒一次） */
@property (nonatomic, copy) CountDownUnderwayBlock countDownUnderwayBlock;
/** 倒计时完成时的回调 */
@property (nonatomic, copy) CountDownCompletionBlock countDownCompletionBlock;

@end

@implementation CQCountDownButton {
    /** 倒计时开始值 */
    NSInteger _startCountDownNum;
    /** 剩余倒计时的值 */
    NSInteger _restCountDownNum;
    
    // 使用block（若使用block则不能再使用delegate）
    BOOL _useBlock;
}

#pragma mark - init

// 纯代码init和initWithFrame方法调用
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

// xib和storyboard调用
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

#pragma mark - dealloc

// 检验是否释放
- (void)dealloc {
    NSLog(@"倒计时按钮已释放");
}

#pragma mark - block版本

/**
 配置属性和回调

 @param duration 倒计时总时间
 @param buttonClickedBlock 按钮点击回调
 @param countDownStartBlock 倒计时开始回调
 @param countDownUnderwayBlock 倒计时进行中回调
 @param countDownCompletionBlock 倒计时结束回调
 */
- (void)configDuration:(NSInteger)duration buttonClickedBlock:(ButtonClickedBlock)buttonClickedBlock countDownStartBlock:(CountDownStartBlock)countDownStartBlock countDownUnderwayBlock:(CountDownUnderwayBlock)countDownUnderwayBlock countDownCompletionBlock:(CountDownCompletionBlock)countDownCompletionBlock {
    if (_dataSource || _delegate) {
        [self showError];
    }
    _useBlock = YES; // 表示使用block，不能再用delegate
    _startCountDownNum = duration;
    self.buttonClickedBlock       = buttonClickedBlock;
    self.countDownStartBlock      = countDownStartBlock;
    self.countDownUnderwayBlock   = countDownUnderwayBlock;
    self.countDownCompletionBlock = countDownCompletionBlock;
}

#pragma mark - delegate版本

- (void)setDataSource:(id<CQCountDownButtonDataSource>)dataSource {
    if (_useBlock) {
        [self showError];
    }
    _dataSource = dataSource;
}

- (void)setDelegate:(id<CQCountDownButtonDelegate>)delegate {
    if (_useBlock) {
        [self showError];
    }
    _delegate = delegate;
}

#pragma mark - 事件处理

/** 按钮点击 */
- (void)buttonClicked:(CQCountDownButton *)sender {
    sender.enabled = NO;
    !self.buttonClickedBlock ?: self.buttonClickedBlock();
    if ([_delegate respondsToSelector:@selector(countdownButtonDidClick:)]) {
        _startCountDownNum = [_dataSource startCountdownNumOfCountdownButton:self];
        [_delegate countdownButtonDidClick:self];
    }
}

/** 开始倒计时 */
- (void)startCountDown {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    _restCountDownNum = _startCountDownNum;
    // 倒计时开始的回调
    !self.countDownStartBlock ?: self.countDownStartBlock();
    __weak typeof(self) weakSelf = self;
    self.timer = [NSTimer cq_scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer *timer) {
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf handleCountDown];
    }];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

/** 倒计时进行中 */
- (void)handleCountDown {
    // 调用倒计时进行中的回调
    !self.countDownUnderwayBlock ?: self.countDownUnderwayBlock(_restCountDownNum);
    if ([_delegate respondsToSelector:@selector(countdownButtonDidCountdown:withRestCountdownNum:)]) {
        [_delegate countdownButtonDidCountdown:self withRestCountdownNum:_restCountDownNum];
    }
    if (_restCountDownNum == 0) { // 倒计时完成
        [self endCountDown];
    }
    _restCountDownNum --;
}

/** 结束倒计时 */
- (void)endCountDown {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    // 重置剩余倒计时
    _restCountDownNum = _startCountDownNum;
    // 倒计时结束的回调
    !self.countDownCompletionBlock ?: self.countDownCompletionBlock();
    if ([_delegate respondsToSelector:@selector(countdownButtonDidEndCountdown:)]) {
        [_delegate countdownButtonDidEndCountdown:self];
    }
    // 恢复按钮的enabled状态
    self.enabled = YES;
}

#pragma mark - 提示错误

- (void)showError {
    NSAssert(nil, @"不能同时使用block和delegate");
}

@end
