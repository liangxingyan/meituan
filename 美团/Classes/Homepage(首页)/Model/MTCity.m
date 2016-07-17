//
//  MTCity.m
//  美团
//
//  Created by lxy on 16/6/19.
//  Copyright © 2016年 lxy. All rights reserved.
//

#import "MTCity.h"
#import <MJExtension.h>
#import "MTRegion.h"

@implementation MTCity

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"regions" : [MTRegion class]};
}

@end
