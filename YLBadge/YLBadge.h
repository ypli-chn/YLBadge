//
//  YLBadge.h
//  YLBadgeDemo
//
//  Created by Yunpeng Li on 2017/4/6.
//  Copyright © 2017年 Yunpeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+YLBadge.h"
#import "UIBarItem+YLBadge.h"

typedef NS_ENUM(NSInteger, YLBadgeAlignment) {
    YLBadgeAlignmentTopRightSystem = 0, // offset like system
    
    YLBadgeAlignmentTopLeft,
    YLBadgeAlignmentTopCenter,
    YLBadgeAlignmentTopRight,
    YLBadgeAlignmentMiddleLeft,
    YLBadgeAlignmentMiddleRight,
    YLBadgeAlignmentBottomLeft,
    YLBadgeAlignmentBottomCenter,
    YLBadgeAlignmentBottomRight,
};

@interface YLBadge : UIView

@property (nonatomic, copy) NSString *text;

@property (nonatomic, strong) UIColor *textColor            UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIFont *font                  UI_APPEARANCE_SELECTOR;

@property (nonatomic, assign) CGFloat cornerRadius          UI_APPEARANCE_SELECTOR;

@property (nonatomic, assign) YLBadgeAlignment alignment    UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGVector offset               UI_APPEARANCE_SELECTOR;

@property (nonatomic, assign) BOOL animateWhenChanged       UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat animationDuration     UI_APPEARANCE_SELECTOR;

@property (nonatomic, assign) CGFloat maxWidth              UI_APPEARANCE_SELECTOR;
@property (nonatomic, assign) CGFloat maxDigit              UI_APPEARANCE_SELECTOR;

@property (nonatomic, assign) CGFloat borderWidth           UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *borderColor          UI_APPEARANCE_SELECTOR;

@property (nonatomic, assign) CGRect relativeRect;


@end
