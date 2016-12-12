//
//  AppDelegate.m
//  MXCountDown
//
//  Created by YISHANG on 2016/12/12.
//  Copyright © 2016年 MAX. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:[MainViewController new]];
    [self.window setRootViewController:navi];
    return YES;
}

@end
