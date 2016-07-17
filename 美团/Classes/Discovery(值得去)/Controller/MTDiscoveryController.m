//
//  MTDiscoveryController.m
//  美团
//
//  Created by lxy on 16/6/16.
//  Copyright © 2016年 lxy. All rights reserved.
//

#import "MTDiscoveryController.h"

@implementation MTDiscoveryController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置状态栏的背景色， 用图片不能这样做
    UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, MTScreenW, 20)];
    statusBarView.backgroundColor = MTColor(179, 183, 187);
    [self.navigationController.navigationBar addSubview:statusBarView];
    
    // 设置导航栏的背景
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_navigationbar_center"] forBarMetrics:UIBarMetricsDefault];
    
    self.view.backgroundColor = MTGlobalBg;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
