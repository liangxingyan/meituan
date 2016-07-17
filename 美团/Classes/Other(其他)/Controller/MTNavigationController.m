//
//  MTNavigationController.m
//  美团
//
//  Created by lxy on 16/6/16.
//  Copyright © 2016年 lxy. All rights reserved.
//

#import "MTNavigationController.h"

@interface MTNavigationController ()

@end

@implementation MTNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 重写push方法, 用来拦截push进来的视图
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    // 这里判断是否进入push视图
    if (self.childViewControllers.count > 0) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [btn setImage:[UIImage imageNamed:@"icon_navigationItem_back_white"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"icon_navigationItem_back_white_highlighted"] forState:UIControlStateHighlighted];
        btn.size = CGSizeMake(70, 30);

        // 设置按钮内容左对齐
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        // 内边距
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [btn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        // 隐藏tabTar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    // 这里写在下面，给外面权利修改按钮
    [super pushViewController:viewController animated:animated];
}

#pragma mark - 返回(Pop)
- (void)backAction {
    [self popViewControllerAnimated:YES];
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
