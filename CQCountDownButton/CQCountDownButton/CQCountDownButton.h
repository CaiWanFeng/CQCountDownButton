//
//  CQCountDownButton.h
//  CQCountDownButton
//
//  Created by CaiQiang on 2017/9/8.
//  Copyright © 2017年 caiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

// 按钮被点击时回调的block
typedef void(^ButtonClickedBlock)();
// 倒计时开始时回调的block
typedef void(^CountDownStartBlock)();
// 倒计时进行中回调的block
typedef void(^CountDownUnderwayBlock)(NSInteger restCountDownNum);
// 倒计时结束时回调的block
typedef void(^CountDownCompletionBlock)();

@class CQCountDownButton;

@protocol CQCountDownButtonDataSource <NSObject>

@required
// 设置起始倒计时秒数
- (NSInteger)startCountDownNumOfCountDownButton:(CQCountDownButton *)countDownButton;

@end

@protocol CQCountDownButtonDelegate <NSObject>

@optional
// 倒计时按钮点击回调
- (void)countDownButtonDidClick:(CQCountDownButton *)countDownButton;
// 倒计时开始时的回调
- (void)countDownButtonDidStartCountDown:(CQCountDownButton *)countDownButton;

@required
// 倒计时进行中的回调
- (void)countDownButtonDidCountDown:(CQCountDownButton *)countDownButton withRestCountDownNum:(NSInteger)restCountDownNum;
// 倒计时结束时的回调
- (void)countDownButtonDidEndCountDown:(CQCountDownButton *)countDownButton;

@end

@interface CQCountDownButton : UIButton

#pragma mark - 开始/结束 倒计时

/** 开始倒计时 */
- (void)startCountDown;
/** 结束倒计时（倒计时结束时会自动调用此方法） */
- (void)endCountDown;

#pragma mark - block版本

/**
 所有回调通过block配置
 
 @param duration            倒计时总时间
 @param buttonClicked       按钮点击的回调
 @param countDownStart      倒计时开始时的回调
 @param countDownUnderway   倒计时进行中的回调
 @param countDownCompletion 倒计时完成时的回调
 */
- (void)configDuration:(NSInteger)duration
         buttonClicked:(ButtonClickedBlock)buttonClicked
        countDownStart:(CountDownStartBlock)countDownStart
     countDownUnderway:(CountDownUnderwayBlock)countDownUnderway
   countDownCompletion:(CountDownCompletionBlock)countDownCompletion;

#pragma mark - delegate版本

@property (nonatomic, weak) id <CQCountDownButtonDataSource> dataSource;
@property (nonatomic, weak) id <CQCountDownButtonDelegate> delegate;

@end
