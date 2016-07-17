//
//  UIBarButtonItem+MTExtension.m
//  美团
//
//  Created by lxy on 16/6/16.
//  Copyright © 2016年 lxy. All rights reserved.
//

#import "UIBarButtonItem+MTExtension.h"

@implementation UIBarButtonItem (MTExtension)

+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    button.size = button.currentBackgroundImage.size;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[self alloc] initWithCustomView:button];
}
@end
