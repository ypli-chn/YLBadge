//
//  UIBarItem+YLBadge.h
//  YLBadgeDemo
//
//  Created by Yunpeng on 2017/4/6.
//  Copyright © 2017年 Yunpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YLBadge;

@interface UIBarItem (YLBadge)
@property (nonatomic, strong, readonly) YLBadge *yl_badge;

- (void)yl_showBadge;
- (void)yl_showBadgeNumber:(NSUInteger)num;
- (void)yl_showBadgeText:(NSString *)text;
- (void)yl_clearBadge;
@end
