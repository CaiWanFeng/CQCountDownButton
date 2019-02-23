//
//  CQCountDownButton.m
//  CQCountDownButton
//
//  Created by 蔡强 on 2017/9/8.
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
}

#pragma mark - init

/**
 自定义构造方法，供纯代码玩家使用
 
 @param duration 倒计时时间
 @param buttonClicked 按钮点击事件的回调
 @param countDownStart 倒计时开始时的回调
 @param countDownUnderway 倒计时进行中的回调（每秒一次）
 @param countDownCompletion 倒计时完成时的回调
 @return 倒计时button
 */
- (instancetype)initWithDuration:(NSInteger)duration
                buttonClicked:(ButtonClickedBlock)buttonClicked
               countDownStart:(CountDownStartBlock)countDownStart
            countDownUnderway:(CountDownUnderwayBlock)countDownUnderway
          countDownCompletion:(CountDownCompletionBlock)countDownCompletion {
    if (self = [super init]) {
        [self configDuration:duration buttonClickedBlock:buttonClicked countDownStartBlock:countDownStart countDownUnderwayBlock:countDownUnderway countDownCompletionBlock:countDownCompletion];
        [self addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

// xib和storyboard会调用此构造方法
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

#pragma mark - dealloc

- (void)dealloc {
    NSLog(@"倒计时按钮已释放");
}

#pragma mark - 配置属性和回调

- (void)configDuration:(NSInteger)duration buttonClickedBlock:(ButtonClickedBlock)buttonClickedBlock countDownStartBlock:(CountDownStartBlock)countDownStartBlock countDownUnderwayBlock:(CountDownUnderwayBlock)countDownUnderwayBlock countDownCompletionBlock:(CountDownCompletionBlock)countDownCompletionBlock {
    _startCountDownNum = duration;
    self.buttonClickedBlock       = buttonClickedBlock;
    self.countDownStartBlock      = countDownStartBlock;
    self.countDownUnderwayBlock   = countDownUnderwayBlock;
    self.countDownCompletionBlock = countDownCompletionBlock;
}


/** 按钮点击 */
- (void)buttonClicked:(CQCountDownButton *)sender {
    sender.enabled = NO;
    self.buttonClickedBlock();
}

/** 开始倒计时 */
- (void)startCountDown {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    _restCountDownNum = _startCountDownNum;
    !self.countDownStartBlock ?: self.countDownStartBlock(); // 调用倒计时开始的block
    __weak typeof(self) weakSelf = self;
    self.timer = [NSTimer cq_scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer *timer) {
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf handleCountDown];
    }];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)handleCountDown {
    // 调用倒计时进行中的回调
    !self.countDownUnderwayBlock ?: self.countDownUnderwayBlock(_restCountDownNum);
    if (_restCountDownNum == 0) { // 倒计时完成
        // 将timer置为nil
        [self.timer invalidate];
        self.timer = nil;
        // 重置剩余倒计时
        _restCountDownNum = _startCountDownNum;
        // 调用倒计时完成的回调
        !self.countDownCompletionBlock ?: self.countDownCompletionBlock();
        // 恢复按钮的enabled状态
        self.enabled = YES;
    }
    _restCountDownNum --;
}

/** 结束倒计时 */
- (void)endCountDown {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    self.enabled = YES;
    !self.countDownCompletionBlock ?: self.countDownCompletionBlock();
}

@end
