//
//  MXCountDownViewController.m
//  MXCountDown
//
//  Created by YISHANG on 2016/12/12.
//  Copyright © 2016年 MAX. All rights reserved.
//

#import "MXCountDownViewController.h"
#import "MXCuntDownTableViewCell.h"
#import "MXCountDownManager.h"
#import "MXTimeModel.h"
@interface MXCountDownViewController ()<UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>
/** 主tableView */
@property (nonatomic, strong) UITableView  *mainTableiew;
/** 数据源 */
@property (nonatomic, strong) NSMutableArray  *dataArr;
@end

@implementation MXCountDownViewController
#pragma lifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"定时器倒计时";
    self.view.backgroundColor = [UIColor whiteColor];
    [kCountDownManager start];
    [self configUI];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [kCountDownManager remove];
}

#pragma mark - lazyInitlization
- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        NSMutableArray *arrM = [NSMutableArray array];
        for (NSInteger i=0; i<50; i++) {
            // 模拟从服务器取得数据 -- 例如:服务器返回的数据为剩余时间数
            NSInteger count = arc4random_uniform(10000+1); //生成0-1万之间的随机正整数
            MXTimeModel *model = [[MXTimeModel alloc]init];
            model.count = [NSString stringWithFormat: @"%zd", count];
            model.title = [NSString stringWithFormat:@"第%zd条数据", i];
            [arrM addObject:model];
        }
        _dataArr = arrM.copy;
    }
    return _dataArr;
}

#pragma mark - privateMethods
- (void)configUI {
    self.mainTableiew = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:(UITableViewStylePlain)];
    self.mainTableiew.rowHeight = 50;
    self.mainTableiew.delegate = self;
    self.mainTableiew.dataSource = self;
    [self.view addSubview:self.mainTableiew];
}

#pragma mark - 刷新数据
- (void)reloadData {
    // 网络加载数据
    
    // 调用[kCountDownManager reload]
    [kCountDownManager reload];
    // 刷新
    [self.mainTableiew reloadData];
}

#pragma mark - tableViewDelegate

#pragma mark ---------- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *tag =  @"cell";
    MXCuntDownTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tag];
    if (cell == nil) {
        cell = [[MXCuntDownTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:tag];
    }
    __weak typeof(cell)wCell;
    
    cell.countDownZero = ^(void) {
        wCell.needCountDown = YES;
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"倒计时为0" delegate:self cancelButtonTitle:@"好的" otherButtonTitles: nil];
        [alter show];
    };
    cell.model = self.dataArr[indexPath.row];
    return cell;
}

#pragma mark ---------- UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
