//
//  MXCountDownManager.m
//  MXCountDown
//
//  Created by YISHANG on 2016/12/12.
//  Copyright © 2016年 MAX. All rights reserved.
//

#import "MXCountDownManager.h"

@interface MXCountDownManager ()

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation MXCountDownManager

+ (instancetype)manager {
    static MXCountDownManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[MXCountDownManager alloc] init];
    });
    return manager;
}

- (void)dealloc {
    [self remove];
}

- (void)start {
    // 启动定时器
    [self timer];
}

- (void)reload {
    // 刷新时叫时间差为0
    _timeInterval = 0;
}

- (void)remove {
    [_timer invalidate];
    _timer = nil;
}

- (void)timerAction {
    // 时间差++
    _timeInterval++;
    // 发出通知可以将时间差传递出去, 或者直接属性通知类属性获取
    [[NSNotificationCenter defaultCenter] postNotificationName:kCountDownNotification object:nil userInfo:@{@"TimeInterval":@(_timeInterval)}];
}

- (NSTimer *)timer {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}

@end
