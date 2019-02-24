//
//  NSTimer+CQBlockSupport.h
//  CQCountDownButton
//
//  Created by caiqiang on 2018/12/5.
//  Copyright © 2018年 caiqiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (CQBlockSupport)

+ (NSTimer *)cq_scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(NSTimer *timer))block;

@end
