//
//  UIView+YLBadge.h
//  YLBadgeDemo
//
//  Created by Yunpeng Li on 2017/4/5.
//  Copyright © 2017年 Yunpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YLBadge;
@interface UIView (YLBadge)
@property (nonatomic, strong, readonly) YLBadge *yl_badge;

- (void)yl_showBadge;
- (void)yl_showBadgeNumber:(NSUInteger)num;
- (void)yl_showBadgeText:(NSString *)text;
- (void)yl_clearBadge;
@end
