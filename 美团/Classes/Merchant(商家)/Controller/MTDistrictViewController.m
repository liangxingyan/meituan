//
//  MTDistrictViewController.m
//  美团
//
//  Created by lxy on 16/6/20.
//  Copyright © 2016年 lxy. All rights reserved.
//

#import "MTDistrictViewController.h"
#import "MTDropdown.h"
#import <MJExtension.h>
#import <Masonry.h>
#import "MTRegion.h"
#import "MTMetaTool.h"

@interface MTDistrictViewController () <MTDropdownDataSource>
/** 下拉框 */
@property (nonatomic, weak) MTDropdown *dropdown;
@end

@implementation MTDistrictViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 下拉框
    MTDropdown *dropdown = [MTDropdown dropdown];
    self.dropdown = dropdown;
    dropdown.dataSource = self;
    
    // 这里之前报错是因为要先将dropdown加入到父视图，再设置约束就好了
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    self.view.frame = CGRectMake(0, _menuView.height, MTScreenW, MTScreenH);
    
    [self.view addSubview:dropdown];
    [dropdown mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.mas_equalTo(self.view.mas_top);
        make.height.mas_equalTo(MTScreenH * 0.4);
    }];
    
}

- (void)setMenuView:(UIView *)menuView {
    _menuView = menuView;
}


// 在这里将self.view当做遮盖，点击遮盖， 让self.view隐藏
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

#pragma mark - MTDropdownDataSource
- (NSInteger)numberOfRowsInLeftTable:(MTDropdown *)dropdown {
    return self.regions.count;
}

- (NSString *)dropdown:(MTDropdown *)dropdown titleForRowLeftTable:(NSInteger)row {
    MTRegion *region = self.regions[row];
    return region.name;
}


- (NSArray *)dropdown:(MTDropdown *)dropdown subdataForRowInLeftTable:(NSInteger)row {
    MTRegion *region = self.regions[row];
    return region.subregions;
}


@end
