//
//  MTLocationViewController.m
//  美团
//
//  Created by lxy on 16/6/19.
//  Copyright © 2016年 lxy. All rights reserved.
//

#import "MTLocationViewController.h"
#import "MTCitySearchResultViewController.h"
#import <Masonry.h>
#import "MTCityGroup.h"
#import <MJExtension.h>


@interface MTLocationViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

/** 遮盖 */
@property (weak, nonatomic) IBOutlet UIButton *cover;

/** 城市数据 */
@property (nonatomic, strong) NSArray *cityGrops;

/** 搜索结果控制器 */
@property (nonatomic, weak) MTCitySearchResultViewController *citySearchResult;

@end

@implementation MTLocationViewController

// 懒加载
- (MTCitySearchResultViewController *)citySearchResult {
    /* 这里老是想不通啊 
     _citySearchResult == nil 意思就是没有值就执行 ，有值就不执行
     !_citySearchResult 这两个等价 ， 意思就是 _citySearchResult有值 我取非 ，就是不执行
     */
    if (_citySearchResult == nil) {
        MTCitySearchResultViewController *citySearchResult = [[MTCitySearchResultViewController alloc] init];
        
        // 这里一定要成为父子关系---特重要
        [self addChildViewController:citySearchResult];
        self.citySearchResult = citySearchResult;
    }
    return _citySearchResult;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.title = @"切换城市";
    
    // 设置右边文字颜色
    self.tableView.sectionIndexColor = MTColor(53, 181, 172);
    
    // 加载城市数据
    self.cityGrops = [MTCityGroup mj_objectArrayWithFilename:@"cityGroups.plist"];
    

}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.cityGrops.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    MTCityGroup *group = self.cityGrops[section];
    return group.cities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    MTCityGroup *group = self.cityGrops[indexPath.section];
    
    cell.textLabel.text = group.cities[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    MTCityGroup *group = self.cityGrops[section];
    return group.title;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    // kvc
    // 意思是找cityGrops里面的title属性， 由于cityGrops是数组，所有title也存入一个数组中
    return [self.cityGrops valueForKeyPath:@"title"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MTCityGroup *group = self.cityGrops[indexPath.section];
    // 发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:MTCityDidChangeNotification object:nil userInfo:@{MTSelectCityName : group.cities[indexPath.row]}];
    
    // 销毁
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - 搜索框的代理方法
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
    // 显示搜索框右边的取消按钮
    [searchBar setShowsCancelButton:YES animated:YES];
    
    // 显示遮盖
    [UIView animateWithDuration:0.5 animations:^{
        self.cover.alpha = 0.5;
    }];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    
    // 隐藏搜索框右边的取消按钮
    [searchBar setShowsCancelButton:NO animated:YES];
    
    // 隐藏遮盖
    [UIView animateWithDuration:0.5 animations:^{
        self.cover.alpha = 0.0;
    }];
    
    // 清除搜索结果
    [self.citySearchResult.view removeFromSuperview];
    searchBar.text = nil;
    
}

// 取消按钮点击
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

// 搜索框里面的文字变化就调用
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    
    if (searchText.length) {
        [self.view addSubview:self.citySearchResult.view];
        [self.citySearchResult.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left);
            make.right.equalTo(self.view.mas_right);
            make.bottom.equalTo(self.view.mas_bottom);
            make.top.equalTo(self.searchBar.mas_bottom);
        }];
        
        self.citySearchResult.searchText = searchText;
        
    } else {
        [self.citySearchResult.view removeFromSuperview];
    }
}



#pragma mark - 遮盖点击事件
/**
 *  遮盖点击退下
 */
- (IBAction)coverClick {
    
    [self.searchBar resignFirstResponder];
    
}

@end
