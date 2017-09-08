//
//  CQCountDownButton.h
//  CQCountDownButton
//
//  Created by 蔡强 on 2017/9/8.
//  Copyright © 2017年 kuaijiankang. All rights reserved.
//

//========== 倒计时button ==========//

#import <UIKit/UIKit.h>

@interface CQCountDownButton : UIButton

/**
 构造方法

 @param frame frame
 @param duration 倒计时时间
 @param countDownStart 倒计时开始时的回调
 @param countDownUnderway 倒计时进行中的回调（每秒一次）
 @param countDownCompletion 倒计时完成时的回调
 @return 倒计时button
 */
- (instancetype)initWithFrame:(CGRect)frame
                     duration:(NSInteger)duration
               countDownStart:(void(^)())countDownStart
            countDownUnderway:(void(^)(NSInteger restCountDownNum))countDownUnderway
          countDownCompletion:(void(^)())countDownCompletion;

/** 开始倒计时 */
- (void)startCountDown;

@end
