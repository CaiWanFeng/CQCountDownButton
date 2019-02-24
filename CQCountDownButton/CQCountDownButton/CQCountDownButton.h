//
//  CQCountDownButton.h
//  CQCountDownButton
//
//  Created by CaiQiang on 2017/9/8.
//  Copyright © 2017年 kuaijiankang. All rights reserved.
//

//========== 倒计时button ==========//

#import <UIKit/UIKit.h>

// 按钮点击回调的block
typedef void(^ButtonClickedBlock)();
// 倒计时开始回调的block
typedef void(^CountDownStartBlock)();
// 倒计时进行中回调的block
typedef void(^CountDownUnderwayBlock)(NSInteger restCountDownNum);
// 倒计时结束时回调的block
typedef void(^CountDownCompletionBlock)();

@class CQCountDownButton;

@protocol CQCountDownButtonDataSource <NSObject>

// 设置起始倒计时秒数
- (NSInteger)startCountdownNumOfCountdownButton:(CQCountDownButton *)countdownButton;

@end

@protocol CQCountDownButtonDelegate <NSObject>

// 倒计时按钮点击时回调
- (void)countdownButtonDidClick:(CQCountDownButton *)countdownButton;
// 倒计时进行中的回调
- (void)countdownButtonDidCountdown:(CQCountDownButton *)countdownButton withRestCountdownNum:(NSInteger)restCountdownNum;
// 倒计时结束时的回调
- (void)countdownButtonDidEndCountdown:(CQCountDownButton *)countdownButton;

@end

@interface CQCountDownButton : UIButton

#pragma mark - 开始/结束 倒计时

/** 开始倒计时 */
- (void)startCountDown;
/** 结束倒计时（按钮倒计时结束时会自动调用此方法，一般不需要主动调用） */
- (void)endCountDown;

#pragma mark - 如果是纯代码可以直接使用此方法完成所有设置
/**
 自定义构造方法，供纯代码玩家使用
 
 @param duration 倒计时总时间
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
             countDownCompletion:(CountDownCompletionBlock)countDownCompletion;

#pragma mark - xib和storyboard通过此方法配置回调
/**
 xib或storyboard不能调用自定义方法，可以通过此方法配置回调
 
 @param duration 倒计时总时间
 @param buttonClickedBlock 按钮点击事件的回调
 @param countDownStartBlock 倒计时开始时的回调
 @param countDownUnderwayBlock 倒计时进行中的回调（每秒一次）
 @param countDownCompletionBlock 倒计时完成时的回调
 */
- (void)configDuration:(NSInteger)duration
    buttonClickedBlock:(ButtonClickedBlock)buttonClickedBlock
   countDownStartBlock:(CountDownStartBlock)countDownStartBlock
countDownUnderwayBlock:(CountDownUnderwayBlock)countDownUnderwayBlock
countDownCompletionBlock:(CountDownCompletionBlock)countDownCompletionBlock;

#pragma mark - 代理版本

@property (nonatomic, weak) id <CQCountDownButtonDataSource> dataSource;
@property (nonatomic, weak) id <CQCountDownButtonDelegate> delegate;

@end
