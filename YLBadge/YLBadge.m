//
//  YLBadge.m
//  YLBadgeDemo
//
//  Created by Yunpeng Li on 2017/4/6.
//  Copyright © 2017年 Yunpeng. All rights reserved.
//

#import "YLBadge.h"
static NSInteger const YLBadgeDefaultMaxDigit = 2;
static CGFloat const YLBadgeRedDotLength = 10;
static CGFloat const YLBadgeDefaultHeight = 18;
static CGFloat const YLAutoCornerRadius = -1;

@interface YLBadge() {
    CAShapeLayer *borderLayer;
    CAShapeLayer *backgroundLayer;
    
    UIColor *_badgeBackgroundColor;
}
@property (nonatomic, strong) UILabel *badgeLabel;
@property (nonatomic, assign) BOOL needAjustFrame;
@end

@implementation YLBadge
@synthesize cornerRadius = _cornerRadius;

- (instancetype)init {
    return [self initWithFrame:CGRectMake(0, 0, YLBadgeRedDotLength, YLBadgeRedDotLength)];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.userInteractionEnabled = NO;
    self.clipsToBounds = NO;
    
    _badgeBackgroundColor = [UIColor clearColor];
    _textColor = [UIColor whiteColor];
    _font = [UIFont systemFontOfSize:13.0 weight:UIFontWeightMedium];
    _badgeBackgroundColor = [UIColor redColor];
    _cornerRadius = self.frame.size.height / 2;
    _alignment = YLBadgeAlignmentTopRightSystem;
    _animateWhenChanged = YES;
    _animationDuration = 0.2;
    _borderWidth = 0.0;
    _borderColor = [UIColor whiteColor];
    _cornerRadius = YLAutoCornerRadius;
    _needAjustFrame = NO;
    _relativeRect = CGRectZero;
    _maxDigit = YLBadgeDefaultMaxDigit;
    
    _maxWidth = CGFLOAT_MAX;
    
    borderLayer = [CAShapeLayer layer];
    borderLayer.strokeColor = self.borderColor.CGColor;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    borderLayer.lineWidth = self.borderWidth;
    borderLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    borderLayer.contentsScale = [UIScreen mainScreen].scale;
    
    backgroundLayer = [CAShapeLayer layer];
    backgroundLayer.fillColor = self.backgroundColor.CGColor;
    backgroundLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    backgroundLayer.contentsScale = [UIScreen mainScreen].scale;
    
    [self.layer addSublayer:backgroundLayer];
    [self.layer addSublayer:borderLayer];
    [self addSubview:self.badgeLabel];
    
    CABasicAnimation *frameAnimation = [CABasicAnimation animation];
    frameAnimation.duration = _animationDuration;
    frameAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    NSDictionary *actions = @{@"path": frameAnimation};
    backgroundLayer.actions = actions;
    borderLayer.actions = actions;
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // avoid repeated calls when init
    self.needAjustFrame = YES;
    [self adjustBadgeFrameIfNeeded];
}


#pragma mark - Private API
- (void)adjustBadgeFrameIfNeeded {
    if(!self.needAjustFrame) {
        return;
    }
    
    CGRect frame = self.frame;
    if (self.text.length > 0) {
        frame.size.height = MAX(frame.size.height, YLBadgeDefaultHeight);
        frame.size.width = MAX(frame.size.width, YLBadgeDefaultHeight);
        
        CGFloat textWidth = [self sizeForString:self.text autoPadding:YES].width;
        frame.size.width = MAX(frame.size.width, textWidth);
        frame.size.width = MIN(frame.size.width, self.maxWidth);
    }
    
    
    CGRect relativeRect;
    
    if (CGRectIsEmpty(self.relativeRect)) {
        relativeRect =  CGRectMake(0, 0, self.superview.frame.size.width, self.superview.frame.size.height);
    } else {
        relativeRect = self.relativeRect;
    }
    
    CGFloat top = CGRectGetMinY(relativeRect) - (frame.size.height / 2) + self.offset.dy;
    CGFloat middle = CGRectGetMidY(relativeRect) - (frame.size.height / 2.0) + self.offset.dy;
    CGFloat bottom = CGRectGetMaxY(relativeRect) - (frame.size.height / 2.0) + self.offset.dy;
    
    
    CGFloat left = CGRectGetMinX(relativeRect) - (frame.size.width / 2) + self.offset.dx;
    CGFloat center = CGRectGetMidX(relativeRect) - (frame.size.width / 2) + self.offset.dx;
    CGFloat right = CGRectGetMaxX(relativeRect) - (frame.size.width / 2) + self.offset.dx;
    
    
    switch (self.alignment) {
        case YLBadgeAlignmentTopRightSystem: {
            frame.origin.x = CGRectGetMaxX(relativeRect) - 5;
            frame.origin.y = CGRectGetMinY(relativeRect) - 3;
            break;
        }
            
        case YLBadgeAlignmentTopRight: {
            frame.origin.x = right;
            frame.origin.y = top;
            break;
        }
        case YLBadgeAlignmentTopCenter: {
            frame.origin.x = center;
            frame.origin.y = top;
            break;
        }
        case YLBadgeAlignmentTopLeft: {
            frame.origin.x = left;
            frame.origin.y = top;
            break;
        }
        case YLBadgeAlignmentMiddleLeft: {
            frame.origin.x = left;
            frame.origin.y = middle;
            break;
        }
        case YLBadgeAlignmentMiddleRight: {
            frame.origin.x = right;
            frame.origin.y = middle;
            break;
        }
        case YLBadgeAlignmentBottomLeft: {
            frame.origin.x = left;
            frame.origin.y = bottom;
            break;
        }
        case YLBadgeAlignmentBottomRight: {
            frame.origin.x = right;
            frame.origin.y = bottom;
            break;
        }
        case YLBadgeAlignmentBottomCenter: {
            frame.origin.x = center;
            frame.origin.y = bottom;
            break;
        }
        default:
            break;
    }
    
    self.frame = frame;
    
    CGRect subFrame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    self.badgeLabel.frame = subFrame;
    backgroundLayer.frame =  subFrame;
    borderLayer.frame = subFrame;
    [self updateShapeLayer];
}

- (void)updateShapeLayer {
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.cornerRadius];
    backgroundLayer.path = path.CGPath;
    borderLayer.path = path.CGPath;
}


- (CGSize)sizeForString:(NSString *)string autoPadding:(BOOL)autoPadding {
    if (!self.font) {
        return CGSizeZero;
    }
    
    CGFloat widthPadding = self.font.pointSize * 0.375;
    
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:(string ?: @"") attributes:@{NSFontAttributeName : _font}];
    
    CGSize textSize = [attrStr boundingRectWithSize:(CGSize){CGFLOAT_MAX, CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    
    if (autoPadding) {
        textSize.width += widthPadding * 2;
    }

    return textSize;
}

- (BOOL)isPureInt:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

#pragma mark - Getter && Setter

- (void)setText:(NSString *)text {
    if(text.length > self.maxDigit && [self isPureInt:text]) {
        text = [NSString stringWithFormat:@"%td+",(NSInteger)(pow(10, self.maxDigit) - 1)];
    }
    _text = text;
    self.badgeLabel.text = text;
    [self adjustBadgeFrameIfNeeded];
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    self.badgeLabel.textColor = textColor;
}

- (UIColor *)backgroundColor {
    return _badgeBackgroundColor;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    _badgeBackgroundColor = backgroundColor;
    backgroundLayer.fillColor = backgroundColor.CGColor;
}

- (CGFloat)cornerRadius {
    if (fabs(_cornerRadius - YLAutoCornerRadius)<1e-3) {
        return self.frame.size.height / 2;
    }
    return _cornerRadius;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    [self updateShapeLayer];
}

- (void)setAlignment:(YLBadgeAlignment)alignment {
    _alignment = alignment;
    [self adjustBadgeFrameIfNeeded];
}

- (void)setOffset:(CGVector)offset {
    _offset = offset;
    [self adjustBadgeFrameIfNeeded];
}

- (void)setMaxWidth:(CGFloat)maxWidth {
    _maxWidth = maxWidth;
    [self adjustBadgeFrameIfNeeded];
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
    borderLayer.lineWidth = borderWidth;
}

- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    borderLayer.strokeColor = borderColor.CGColor;
}

- (void)setRelativeRect:(CGRect)relativeRect {
    _relativeRect = relativeRect;
    [self adjustBadgeFrameIfNeeded];
}

- (UILabel *)badgeLabel {
    if (_badgeLabel == nil) {
        _badgeLabel = [[UILabel alloc] initWithFrame:
                       CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        _badgeLabel.font = self.font;
        _badgeLabel.textColor = self.textColor;
        _badgeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _badgeLabel;
}
@end
