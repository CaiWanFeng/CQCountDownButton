//
//  CQCountDownButton.h
//  CQCountDownButton
//
//  Created by CaiQiang on 2017/9/8.
//  Copyright © 2017年 caiqiang. All rights reserved.
//
//  Repo Detail: https://github.com/CaiWanFeng/CQCountDownButton
//  About Author: https://www.jianshu.com/u/4212f351f6b5
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CQCountDownButton;

@protocol CQCountDownButtonDataSource <NSObject>

@required
// 设置起始倒计时秒数
- (NSUInteger)startCountDownNumOfCountDownButton:(CQCountDownButton *)countDownButton;

@end

@protocol CQCountDownButtonDelegate <NSObject>

@optional
// 倒计时按钮点击回调
- (void)countDownButtonDidClick:(CQCountDownButton *)countDownButton;
// 倒计时开始时的回调
- (void)countDownButtonDidStartCountDown:(CQCountDownButton *)countDownButton;

@required
// 倒计时进行中的回调
- (void)countDownButtonDidInCountDown:(CQCountDownButton *)countDownButton withRestCountDownNum:(NSInteger)restCountDownNum;
// 倒计时结束时的回调
- (void)countDownButtonDidEndCountDown:(CQCountDownButton *)countDownButton;

@end

@interface CQCountDownButton : UIButton

#pragma mark - block版本

/**
 所有回调通过block配置
 
 @param duration            设置起始倒计时秒数
 @param buttonClicked       倒计时按钮点击回调
 @param countDownStart      倒计时开始时的回调
 @param countDownUnderway   倒计时进行中的回调
 @param countDownCompletion 倒计时结束时的回调
 */
- (void)configDuration:(NSUInteger)duration
         buttonClicked:(dispatch_block_t)buttonClicked
        countDownStart:(dispatch_block_t)countDownStart
     countDownUnderway:(void (^)(NSInteger restCountDownNum))countDownUnderway
   countDownCompletion:(dispatch_block_t)countDownCompletion;

#pragma mark - delegate版本

@property (nonatomic, weak, nullable) id <CQCountDownButtonDataSource> dataSource;
@property (nonatomic, weak, nullable) id <CQCountDownButtonDelegate> delegate;

#pragma mark - 开始/结束 倒计时

/** 开始倒计时 */
- (void)startCountDown;
/** 结束倒计时（倒计时结束时会自动调用此方法） */
- (void)endCountDown;

@end

NS_ASSUME_NONNULL_END
