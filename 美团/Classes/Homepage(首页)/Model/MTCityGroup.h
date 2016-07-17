//
//  MTCityGroup.h
//  美团
//
//  Created by lxy on 16/6/19.
//  Copyright © 2016年 lxy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTCityGroup : NSObject
/** 组名字 */
@property (nonatomic, copy) NSString *title;

/** 这组的所有城市 */
@property (nonatomic, strong) NSArray *cities;
@end
