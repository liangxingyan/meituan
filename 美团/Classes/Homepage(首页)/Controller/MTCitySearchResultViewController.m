//
//  MTCitySearchResultViewController.m
//  美团
//
//  Created by lxy on 16/6/19.
//  Copyright © 2016年 lxy. All rights reserved.
//

#import "MTCitySearchResultViewController.h"
#import "MTCity.h"
#import "MTMetaTool.h"

@interface MTCitySearchResultViewController ()

/** 搜索出来的结果 */
@property (nonatomic, strong) NSArray *resultCities;

@end

@implementation MTCitySearchResultViewController


- (void)viewDidLoad {
    [super viewDidLoad];
 
}

- (void)setSearchText:(NSString *)searchText {
    _searchText = searchText;

    // 将其转为小写
    searchText = searchText.lowercaseString;
    
    // 谓词
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name contains %@ or pinYin contains %@ or pinYinHead contains %@", searchText, searchText, searchText];
    
    self.resultCities = [[MTMetaTool cities] filteredArrayUsingPredicate:predicate];
    
    // 刷新表格
    [self.tableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.resultCities.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }

    MTCity *city = self.resultCities[indexPath.row];
    cell.textLabel.text = city.name;

    return cell;
}

#pragma mark - tableview的代理方法
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"共有%ld个搜索结果", self.resultCities.count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MTCity *city = self.resultCities[indexPath.row];

    // 发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:MTCityDidChangeNotification object:nil userInfo:@{MTSelectCityName : city.name}];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
