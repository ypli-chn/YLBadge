//
//  UIView+YLBadge.m
//  YLBadgeDemo
//
//  Created by Yunpeng Li on 2017/4/5.
//  Copyright © 2017年 Yunpeng. All rights reserved.
//

#import "UIView+YLBadge.h"
#import "YLBadge.h"
#import <objc/runtime.h>
@implementation UIView (YLBadge)
@dynamic yl_badge;
- (void)yl_showBadge {
    self.yl_badge.hidden = NO;
}

- (void)yl_showBadgeNumber:(NSUInteger)num {
    self.yl_badge.hidden = NO;
    self.yl_badge.text = [NSString stringWithFormat:@"%td", num];
}

- (void)yl_showBadgeText:(NSString *)text {
    self.yl_badge.hidden = NO;
    self.yl_badge.text = text;
}

- (void)yl_clearBadge {
    self.yl_badge.text = nil;
    self.yl_badge.hidden = YES;
}

- (YLBadge *)yl_badge {
    YLBadge *badge = objc_getAssociatedObject(self, _cmd);
    if (badge == nil) {
        badge = [[YLBadge alloc] init];
        badge.hidden = YES;
        [self addSubview:badge];
        objc_setAssociatedObject(self, _cmd, badge, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return objc_getAssociatedObject(self, _cmd);
}
@end
