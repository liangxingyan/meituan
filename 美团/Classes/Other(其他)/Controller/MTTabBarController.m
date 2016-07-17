//
//  MTTabBarController.m
//  美团
//
//  Created by lxy on 16/6/16.
//  Copyright © 2016年 lxy. All rights reserved.
//

#import "MTTabBarController.h"
#import "MTHomePageController.h"
#import "MTMerchantViewController.h"
#import "MTDiscoveryController.h"
#import "MTMineController.h"
#import "MTMiscController.h"
#import "MTNavigationController.h"
#import "MTTabBar.h"

@interface MTTabBarController ()

@end

@implementation MTTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 1.创建状态栏
    [self createTabBar];
    
 
}

#pragma mark - 创建状态栏
- (void)createTabBar {

    // 设置属性
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    NSMutableDictionary *sattrs = [NSMutableDictionary dictionary];
    sattrs[NSForegroundColorAttributeName] = [UIColor colorWithRed:54/255.0 green:185/255.0 blue:175/255.0 alpha:1.0];
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:sattrs forState:UIControlStateSelected];
    
    MTHomePageController *homePage = [[MTHomePageController alloc] init];
    [self setUpChildViewController:homePage title:@"首页" image:@"icon_tabbar_homepage" selectedImage:@"icon_tabbar_homepage_selected"];
    
    MTMerchantViewController *merchant = [[MTMerchantViewController alloc] init];
    [self setUpChildViewController:merchant title:@"商家" image:@"icon_tabbar_merchant_normal" selectedImage:@"icon_tabbar_merchant_selected"];
    
    MTDiscoveryController *discovery = [[MTDiscoveryController alloc] init];
    [self setUpChildViewController:discovery title:@"值得去" image:@"icon_tabbar_discovery" selectedImage:@"icon_tabbar_discovery_selected"];
    
    MTMineController *mine = [[MTMineController alloc] init];
    [self setUpChildViewController:mine title:@"我的" image:@"icon_tabbar_mine" selectedImage:@"icon_tabbar_mine_selected"];
    
    MTMiscController *misc = [[MTMiscController alloc] init];
    [self setUpChildViewController:misc title:@"更多" image:@"icon_tabbar_misc" selectedImage:@"icon_tabbar_misc_selected"];
    
    // 改用自己的tabbar
    MTTabBar *tabBar = [[MTTabBar alloc] init];
    [self setValue:tabBar forKeyPath:@"tabBar"];
    
    // 设置tabbar上选中的那项下面的图片
//    self.tabBar.selectionIndicatorImage = [UIImage imageNamed:@"share_logo_sms"];
    
   
}

- (void)setUpChildViewController:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage {
    
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    MTNavigationController *nav = [[MTNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
