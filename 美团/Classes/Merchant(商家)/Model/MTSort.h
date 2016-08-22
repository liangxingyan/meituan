//
//  MTSort.h
//  美团
//
//  Created by mac2 on 16/8/14.
//  Copyright © 2016年 lxy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTSort : NSObject

/** 排序名称 */
@property (nonatomic, copy) NSString *label;
/** 排序的值(发给服务器) */
@property (nonatomic, assign) int value;

@end
