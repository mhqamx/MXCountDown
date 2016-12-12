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
}

- (void)jumpButtonOnClick {
    MXCountDownViewController *vc = [[MXCountDownViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
