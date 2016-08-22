//
//  MTCategoryViewController.m
//  美团
//
//  Created by lxy on 16/6/19.
//  Copyright © 2016年 lxy. All rights reserved.
//

#import "MTCategoryViewController.h"
#import "MTDropdown.h"
#import <MJExtension.h>
#import <Masonry.h>
#import "MTMetaTool.h"
#import "MTCategory.h"

@interface MTCategoryViewController () <MTDropdownDataSource>

@end

@implementation MTCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 下拉框
    MTDropdown *dropdown = [MTDropdown dropdown];
    dropdown.dataSource = self;
    
    // 这里之前报错是因为要先将dropdown加入到父视图，再设置约束就好了
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    self.view.frame = CGRectMake(0, _menuView.height, MTScreenW, MTScreenH);
    
    // 添加到父视图
    [self.view addSubview:dropdown];
    [dropdown mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.mas_equalTo(self.view.mas_top);
        make.height.mas_equalTo(MTScreenH * 0.5);
    }];

}

- (void)setMenuView:(UIView *)menuView {
    _menuView = menuView;
}

// 在这里将self.view当做遮盖，点击遮盖， 让self.view隐藏
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"...");
}

#pragma mark - MTDropdownDataSource
- (NSInteger)numberOfRowsInLeftTable:(MTDropdown *)dropdown {
    return [MTMetaTool categories].count;
}

- (NSString *)dropdown:(MTDropdown *)dropdown titleForRowLeftTable:(NSInteger)row {
    MTCategory *category = [MTMetaTool categories][row];
    return category.name;
}

- (NSString *)dropdown:(MTDropdown *)dropdown iconForRowLeftTable:(NSInteger)row {
    MTCategory *category = [MTMetaTool categories][row];
    return category.small_icon;
}

- (NSString *)dropdown:(MTDropdown *)dropdown selectedIconForRowLeftTable:(NSInteger)row {
    MTCategory *category = [MTMetaTool categories][row];
    return category.small_highlighted_icon;
}

- (NSArray *)dropdown:(MTDropdown *)dropdown subdataForRowInLeftTable:(NSInteger)row {
    MTCategory *category = [MTMetaTool categories][row];
    return category.subcategories;
}


@end
