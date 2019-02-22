//
//  CQCountDownButton.h
//  CQCountDownButton
//
//  Created by 蔡强 on 2017/9/8.
//  Copyright © 2017年 kuaijiankang. All rights reserved.
//

//========== 倒计时button ==========//

#import <UIKit/UIKit.h>

typedef void(^ButtonClickedBlock)();
typedef void(^CountDownStartBlock)();
typedef void(^CountDownUnderwayBlock)(NSInteger restCountDownNum);
typedef void(^CountDownCompletionBlock)();

@interface CQCountDownButton : UIButton

/** 开始倒计时 */
- (void)startCountDown;
/** 结束倒计时 */
- (void)endCountDown;

#pragma mark - 如果是纯代码可以直接使用此方法完成所有设置
/**
 构造方法
 
 @param duration 倒计时总时间
 @param buttonClicked 按钮点击事件的回调
 @param countDownStart 倒计时开始时的回调
 @param countDownUnderway 倒计时进行中的回调（每秒一次）
 @param countDownCompletion 倒计时完成时的回调
 @return 倒计时button
 */
- (instancetype)initWithDuration:(NSInteger)duration
                buttonClicked:(void(^)())buttonClicked
               countDownStart:(void(^)())countDownStart
            countDownUnderway:(void(^)(NSInteger restCountDownNum))countDownUnderway
          countDownCompletion:(void(^)())countDownCompletion;

#pragma mark - xib或storyboard通过此方法配置回调
/**
 xib或storyboard不能调用自定义方法，可以通过此方法配置回调

 @param duration 倒计时总时间
 @param buttonClickedBlock 按钮点击事件的回调
 @param countDownStartBlock 倒计时开始时的回调
 @param countDownUnderwayBlock 倒计时进行中的回调（每秒一次）
 @param countDownCompletionBlock 倒计时完成时的回调
 */
- (void)configDuration:(NSInteger)duration buttonClickedBlock:(ButtonClickedBlock)buttonClickedBlock countDownStartBlock:(CountDownStartBlock)countDownStartBlock countDownUnderwayBlock:(CountDownUnderwayBlock)countDownUnderwayBlock countDownCompletionBlock:(CountDownCompletionBlock)countDownCompletionBlock;

@end
