//
//  MXCuntDownTableViewCell.m
//  MXCountDown
//
//  Created by YISHANG on 2016/12/12.
//  Copyright © 2016年 MAX. All rights reserved.
//

#import "MXCuntDownTableViewCell.h"
#import "MXTimeModel.h"
#import "MXCountDownManager.h"

@interface MXCuntDownTableViewCell ()
@property (nonatomic, strong) UILabel  *titlelabel;
@property (nonatomic, strong) UILabel  *timeLabel;
@end

@implementation MXCuntDownTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 监听通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(countDownNotification) name:kCountDownNotification object:nil];
        [self configUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(countDownNotification) name:kCountDownNotification object:nil];
        [self configUI];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)configUI {
    self.titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 24)];
    [self.contentView addSubview:self.titlelabel];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 10, 200, 24)];
    self.timeLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.timeLabel];
}

- (void)countDownNotification {
    /// 判断是否需要倒计时 -- 可能有的cell不需要倒计时,根据真实需求来进行判断
    if (self.needCountDown == YES) {
        return;
    }
    
    /// 计算倒计时
    NSInteger countDown = [self.model.count integerValue] - kCountDownManager.timeInterval;
    if (countDown < 0) return;
    /// 重新赋值
    self.timeLabel.text = [NSString stringWithFormat:@"倒计时%02zd:%02zd:%02zd", countDown/3600, (countDown/60)%60, countDown%60];
    /// 当倒计时到了进行回调
    if (countDown == 0) {
        // 计时到0不再进行计时
        self.timeLabel.text = @"活动开始";
        if (self.countDownZero) {
            self.countDownZero();
        }
    }
}

- (void)setModel:(MXTimeModel *)model {
    _model = model;
    self.titlelabel.text = model.title;
    // 手动调用通知回调
    [self countDownNotification];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
