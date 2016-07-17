//
//  MTRegion.h
//  美团
//
//  Created by lxy on 16/6/19.
//  Copyright © 2016年 lxy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTRegion : NSObject

/** 区域名字 */
@property (nonatomic, copy) NSString *name;

/** 子区域 */
@property (nonatomic, strong) NSArray *subregions;

@end
