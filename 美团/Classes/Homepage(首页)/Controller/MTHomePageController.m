//
//  MTHomePageController.m
//  美团
//
//  Created by lxy on 16/6/16.
//  Copyright © 2016年 lxy. All rights reserved.
//

#import "MTHomePageController.h"
#import "MTLocationViewController.h"
#import <Masonry.h>

@interface MTHomePageController ()

/** 切换城市 */
@property (nonatomic, weak) UIButton  *cityName;

@end

@implementation MTHomePageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = MTGlobalBg;
    
    // 初始化导航栏
    [self setupNav];
    
    // 监听城市改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(citySelect:) name:MTCityDidChangeNotification object:nil];
    
}


#pragma mark - 设置导航栏
- (void)setupNav {
    
    // 设置导航栏的背景
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_navigationBar"] forBarMetrics:UIBarMetricsDefault];


    // 设置搜索按钮
    // 这里我任务是按钮，因为选择文本框之后它却跳到另一个界面
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(0, 0, 200, 30);
    
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"background_home_searchBar"] forState:UIControlStateNormal];
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"background_home_searchBar"] forState:UIControlStateHighlighted];
    [searchBtn setImage:[UIImage imageNamed:@"icon_food_homepage_search"] forState:UIControlStateNormal];
    [searchBtn setTitle:@"输入商家、分类或商圈" forState:UIControlStateNormal];
    [searchBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    searchBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    
    // 这里是设置按钮里面图片的边距
    searchBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    
    // 这里是设置按钮里面文字的边距
    searchBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
    self.navigationItem.titleView = searchBtn;
    
    // 设置左边按钮
    UIButton *locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cityName = locationBtn;
    [locationBtn setImage:[UIImage imageNamed:@"icon_homepage_downArrow"] forState:UIControlStateNormal];
    locationBtn.frame = CGRectMake(0, 0, 50, 30);
    locationBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    // 这里应该先用GPS定位
    [locationBtn setTitle:@"永州" forState:UIControlStateNormal];
    
    // 这里是设置按钮里面图片的边距
    locationBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 72, 0, 0);
    // 这里是设置按钮里面文字的边距
    locationBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
    
    [locationBtn addTarget:self action:@selector(locationAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:locationBtn];
    
    // 设置右边按钮
    self.navigationItem.rightBarButtonItems = @[
                                                
                                                [UIBarButtonItem itemWithImage:@"icon_homepage_message" highImage:@"icon_homepage_message_normal" target:self action:@selector(messageAction)],
                                                
                                                [UIBarButtonItem itemWithImage:@"icon_homepage_quickentry" highImage:@"icon_homepage_quickentry_pressed" target:self action:@selector(scanTwoDimensionCode)]
                                                
                                                ];
    
}

// 定位
- (void)locationAction {
    MTLocationViewController *locationVc = [[MTLocationViewController alloc] init];
    [self.navigationController pushViewController:locationVc animated:YES];
}

// 消息通知
- (void)messageAction {
    MTLogFunc;
}

// 二维码
- (void)scanTwoDimensionCode {
    MTLogFunc;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 通知事件处理
- (void)citySelect:(NSNotification *)notification {
    NSString *cityName = notification.userInfo[MTSelectCityName];
    [self.cityName setTitle:cityName forState:UIControlStateNormal];
}

#pragma mak - 通知的销毁
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
