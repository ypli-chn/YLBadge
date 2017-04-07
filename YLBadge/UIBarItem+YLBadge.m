//
//  UIBarItem+YLBadge.m
//  YLBadgeDemo
//
//  Created by Yunpeng on 2017/4/6.
//  Copyright © 2017年 Yunpeng. All rights reserved.
//

#import "UIBarItem+YLBadge.h"
#import "YLBadge.h"
#import <objc/runtime.h>
@implementation UIBarItem (YLBadge)
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
        
        UIView *superview = [self valueForKeyPath:@"_view"];
        [superview.subviews enumerateObjectsUsingBlock:^(UIView *subview, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([subview isKindOfClass:[UIImageView class]]) {
                if (subview.clipsToBounds) {
                    [superview addSubview:badge];
                    badge.relativeRect = subview.frame;
                } else {
                    [subview addSubview:badge];
                }
                *stop = YES;
            }
        }];
        objc_setAssociatedObject(self, _cmd, badge, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return objc_getAssociatedObject(self, _cmd);
}
@end
