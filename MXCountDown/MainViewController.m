//
//  MainViewController.m
//  MXCountDown
//
//  Created by YISHANG on 2016/12/12.
//  Copyright © 2016年 MAX. All rights reserved.
//

#import "MainViewController.h"
#import "MXCountDownViewController.h"
@interface MainViewController ()
/** 跳转按钮 */
@property (nonatomic, strong) UIButton  *jumpButton;

@end

@implementation MainViewController

#pragma mark - lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"计时器";
    self.view.backgroundColor = [UIColor whiteColor];
    [self configUI];
}

#pragma mark - privateMethods
- (void)configUI {
    self.jumpButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 100)];
    [self.jumpButton setTitle:@"跳转计时器TableView" forState:(UIControlStateNormal)];
    self.jumpButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.jumpButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    self.jumpButton.backgroundColor = [UIColor blackColor];
    [self.jumpButton addTarget:self action:@selector(jumpButtonOnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.jumpButton];
    
    UIButton *countDownBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    countDownBtn.frame = CGRectMake(0, 250, self.view.frame.size.width, 100);
    countDownBtn.backgroundColor = [UIColor blackColor];
    [countDownBtn setTitle:@"倒计时" forState:UIControlStateNormal];
    countDownBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [countDownBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [countDownBtn addTarget:self action:@selector(countDownBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:countDownBtn];
    
}

- (void)jumpButtonOnClick {
    MXCountDownViewController *vc = [[MXCountDownViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)countDownBtnOnClick:(UIButton *)sender {
    //设置倒计时时间
    //通过检验发现，方法调用后，timeout会先自动-1，所以如果从15秒开始倒计时timeout应该写16
    //__block 如果修饰指针时，指针相当于弱引用，指针对指向的对象不产生引用计数的影响
    __block int timeout = 60;
    //获取全局队列
    dispatch_queue_t global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //创建一个定时器，并将定时器的任务交给全局队列执行(并行，不会造成主线程阻塞)
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, global);
    // 设置触发的间隔时间
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    //1.0 * NSEC_PER_SEC  代表设置定时器触发的时间间隔为1s
    //0 * NSEC_PER_SEC    代表时间允许的误差是 0s
    
    //block内部 如果对当前对象的强引用属性修改 应该使用__weak typeof(self)weakSelf 修饰  避免循环调用
    __weak typeof(self)weakSelf = self;
    //设置定时器的触发事件
    dispatch_source_set_event_handler(timer, ^{
        //倒计时  刷新button上的title ，当倒计时时间为0时，结束倒计时
        //1. 每调用一次 时间-1s
        timeout --;
        
        //2.对timeout进行判断时间是停止倒计时，还是修改button的title
        if (timeout <= 0) {
            //停止倒计时，button打开交互，背景颜色还原，title还原
            //关闭定时器
            dispatch_source_cancel(timer);
            //MRC下需要释放，这里不需要
            // dispatch_realse(timer);
            //button上的相关设置
            //注意: button是属于UI，在iOS中多线程处理时，UI控件的操作必须是交给主线程(主队列)
            //在主线程中对button进行修改操作
            dispatch_async(dispatch_get_main_queue(), ^{
                [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                sender.userInteractionEnabled = YES;//开启交互性
                [sender setTitle:@"获取验证码" forState:UIControlStateNormal];
            });
        }else {
            //处于正在倒计时，在主线程中刷新button上的title，时间-1秒
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString * title = [NSString stringWithFormat:@"已发送(%ds)",timeout];
                [sender setTitle:title forState:UIControlStateNormal];
                [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                sender.userInteractionEnabled = NO;//关闭交互性
            });
        }
    });
    dispatch_resume(timer);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
