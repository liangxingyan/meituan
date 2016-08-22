//
//  MTSortViewController.m
//  美团
//
//  Created by mac2 on 16/8/14.
//  Copyright © 2016年 lxy. All rights reserved.
//

#import "MTSortViewController.h"
#import "MTDropdown.h"
#import <Masonry.h>
#import "MTMetaTool.h"
#import "MTSort.h"

@interface MTSortViewController ()

/** 下拉框 */
@property (nonatomic, weak) MTDropdown *dropdown;

@end

@implementation MTSortViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 下拉框
    MTDropdown *dropdown = [MTDropdown dropdown];
    self.dropdown = dropdown;
    
    // 这里之前报错是因为要先将dropdown加入到父视图，再设置约束就好了
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    self.view.frame = CGRectMake(0, _menuView.height, MTScreenW, MTScreenH);
    
    [self.view addSubview:dropdown];
    [dropdown mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.mas_equalTo(self.view.mas_top);
        make.height.mas_equalTo(MTScreenH * 0.5);
    }];
    
    NSArray *sorts = [MTMetaTool sorts];
    CGFloat btnW = self.view.width - 30;
    CGFloat btnH = 30;
    CGFloat btnX = 15;
    CGFloat btnStartY = 15;
    CGFloat btnMargin = 15;
    CGFloat height = 0;
    
    for (NSInteger i = 0; i < sorts.count; i++) {
        MTSort *sort = sorts[i];
        UIButton *button = [[UIButton alloc] init];
        button.width = btnW;
        button.height = btnH;
        button.x = btnX;
        button.y = btnStartY + i * (btnH + btnMargin);
        [button setTitle:sort.label forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"bg_htl_areaFilter_cell_1_n"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"bg_map_dealListCell_selected"] forState:UIControlStateHighlighted];
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [dropdown addSubview:button];
        height = CGRectGetMaxY(button.frame);
    }
}

- (void)setMenuView:(UIView *)menuView {
    _menuView = menuView;
}

- (void)buttonClick:(UIButton *)btn {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:MTSortDidChangeNotification object:nil userInfo:@{MTSelectSort : [MTMetaTool sorts][btn.tag]}];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
