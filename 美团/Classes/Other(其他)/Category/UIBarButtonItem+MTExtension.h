//
//  UIBarButtonItem+MTExtension.h
//  美团
//
//  Created by lxy on 16/6/16.
//  Copyright © 2016年 lxy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (MTExtension)

+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;

@end
