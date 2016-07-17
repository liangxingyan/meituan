//
//  MTTabBar.m
//  美团
//
//  Created by lxy on 16/6/16.
//  Copyright © 2016年 lxy. All rights reserved.
//

#import "MTTabBar.h"

@implementation MTTabBar


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
         [self setBackgroundImage:[UIImage imageNamed:@"bg_tabbar"]];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
