//
//  MXCuntDownTableViewCell.h
//  MXCountDown
//
//  Created by YISHANG on 2016/12/12.
//  Copyright © 2016年 MAX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MXTimeModel;
@interface MXCuntDownTableViewCell : UITableViewCell
@property (nonatomic, strong) MXTimeModel  *model;

/// 可能有的不需要倒计时,如倒计时时间已到, 或者已经过了
@property (nonatomic, assign) BOOL needCountDown;

/// 倒计时到0时回调
@property (nonatomic, copy) void(^countDownZero)();
@end
