//
//  NSTimer+CQBlockSupport.m
//  CQCountDownButton
//
//  Created by caiqiang on 2018/12/5.
//  Copyright © 2018年 caiqiang. All rights reserved.
//

#import "NSTimer+CQBlockSupport.h"

@implementation NSTimer (CQBlockSupport)

+ (NSTimer *)cq_scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(NSTimer *timer))block {
    return [self scheduledTimerWithTimeInterval:interval target:self selector:@selector(cq_callBlock:) userInfo:[block copy] repeats:repeats];
}

+ (void)cq_callBlock:(NSTimer *)timer {
    void (^block)(NSTimer *timer) = timer.userInfo;
    !block ?: block(timer);
}

@end
