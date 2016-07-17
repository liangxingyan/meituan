//
//  MTCategory.h
//  美团
//
//  Created by lxy on 16/6/19.
//  Copyright © 2016年 lxy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTCategory : NSObject

/** 名称 */
@property (nonatomic, copy) NSString *name;
/** 子数据 */
@property (nonatomic, strong) NSArray *subcategories;
/** 小高亮图片 */
@property (nonatomic, copy) NSString *small_highlighted_icon;
/** 小图片 */
@property (nonatomic, copy) NSString *small_icon;
/** 图片 */
@property (nonatomic, copy) NSString *icon;
/** 高亮图片 */
@property (nonatomic, copy) NSString *highlighted_icon;
/** 地图中的图片 */
@property (nonatomic, copy) NSString *map_icon;
@end
