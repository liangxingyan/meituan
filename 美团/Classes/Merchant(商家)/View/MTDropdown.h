//
//  MTDropdown.h
//  美团
//
//  Created by lxy on 16/6/17.
//  Copyright © 2016年 lxy. All rights reserved.
//  菜单

#import <UIKit/UIKit.h>
@class MTDropdown;

@protocol MTDropdownDataSource <NSObject>

/** 左边的表格一共有多少行 */
- (NSInteger)numberOfRowsInLeftTable:(MTDropdown *)dropdown;

/** 某行显示的文字 */
- (NSString *)dropdown:(MTDropdown *)dropdown titleForRowLeftTable:(NSInteger)row;

/** 左边表视图的子数据 */
- (NSArray *)dropdown:(MTDropdown *)dropdown subdataForRowInLeftTable:(NSInteger)row;

@optional
/** 某行显示的图标 */
- (NSString *)dropdown:(MTDropdown *)dropdown iconForRowLeftTable:(NSInteger)row;

/** 某行显示的高亮图标 */
- (NSString *)dropdown:(MTDropdown *)dropdown selectedIconForRowLeftTable:(NSInteger)row;

@end

@interface MTDropdown : UIView

/** 创建下拉菜单 */
+ (instancetype)dropdown;


/** 数据源 */
@property (nonatomic, weak) id<MTDropdownDataSource> dataSource;


@end
