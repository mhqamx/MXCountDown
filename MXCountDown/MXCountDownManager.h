//
//  MXCountDownManager.h
//  MXCountDown
//
//  Created by YISHANG on 2016/12/12.
//  Copyright © 2016年 MAX. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 使用单例
#define kCountDownManager [MXCountDownManager manager]
/// 倒计时的通知
#define kCountDownNotification @"CountDownNotification"

@interface MXCountDownManager : NSObject

/** 时间差(单位:秒) */
@property (nonatomic, assign) NSInteger timeInterval;

/** 使用单利 */
+ (instancetype)manager;

/** 开始倒计时 */
- (void)start;

/** 刷新计时器 */
- (void)reload;

/** 移除计时器 */
- (void)remove;
@end
