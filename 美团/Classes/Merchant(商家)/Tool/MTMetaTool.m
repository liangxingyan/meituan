//
//  MTMetaTool.m
//  美团
//
//  Created by lxy on 16/6/20.
//  Copyright © 2016年 lxy. All rights reserved.
//

#import "MTMetaTool.h"
#import <MJExtension.h>
#import "MTCity.h"
#import "MTCategory.h"
#import "MTSort.h"


@implementation MTMetaTool


static NSArray *_cities;
+ (NSArray *)cities {
    if (!_cities) {
        _cities = [MTCity mj_objectArrayWithFilename:@"cities.plist"];
    }
    return _cities;
}

static NSArray *_categories;
+ (NSArray *)categories {
    if (!_categories) {
        _categories = [MTCategory mj_objectArrayWithFilename:@"categories.plist"];
    }
    return _categories;
}

static NSArray *_sorts;
+ (NSArray *)sorts {
    if (!_sorts) {
        _sorts = [MTSort mj_objectArrayWithFilename:@"sorts.plist"];
    }
    return _sorts;
}


@end
