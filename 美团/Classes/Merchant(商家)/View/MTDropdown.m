//
//  MTDropdown.m
//  美团
//
//  Created by lxy on 16/6/17.
//  Copyright © 2016年 lxy. All rights reserved.
//

#import "MTDropdown.h"

@interface MTDropdown () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *leftTableView;

@property (weak, nonatomic) IBOutlet UITableView *rightTableView;

/** 左边主表选中的行号 */
@property (nonatomic, assign) NSInteger selectedLeftRow;

@end

@implementation MTDropdown

- (void)awakeFromNib {

}

+ (instancetype)dropdown {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil]  lastObject];
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.leftTableView) {
        return [self.dataSource numberOfRowsInLeftTable:self];
    } else {
        return [self.dataSource dropdown:self subdataForRowInLeftTable:self.selectedLeftRow].count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    UITableViewCell *cell = nil;
    
    if (tableView == self.leftTableView) {
        static NSString *ID = @"left-cell";
        cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
            cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_dropdown_leftpart"]];
            cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_dropdown_left_selected"]];
        }
        NSArray *subdata = [self.dataSource dropdown:self subdataForRowInLeftTable:indexPath.row];
        cell.textLabel.text = [self.dataSource dropdown:self titleForRowLeftTable:indexPath.row];
        if ([self.dataSource respondsToSelector:@selector(dropdown:iconForRowLeftTable:)]) {
            cell.imageView.image = [UIImage imageNamed:[self.dataSource dropdown:self iconForRowLeftTable:indexPath.row]];
        }
        if ([self.dataSource respondsToSelector:@selector(dropdown:selectedIconForRowLeftTable:)]) {
            cell.imageView.highlightedImage = [UIImage imageNamed:[self.dataSource dropdown:self selectedIconForRowLeftTable:indexPath.row]];
        }
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        if (subdata.count) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
    } else { // 右边的tableview
        static NSString *ID = @"right-cell";
        cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
            cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_dropdown_rightpart"]];
            cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_dropdown_right_selected"]];
        }
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        NSArray *subdata = [self.dataSource dropdown:self subdataForRowInLeftTable:self.selectedLeftRow];
        cell.textLabel.text = subdata[indexPath.row];
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTableView) {
        //被点击的分类
        self.selectedLeftRow = indexPath.row;
        // 刷新右边的数据
        [self.rightTableView reloadData];
    }
}

@end
