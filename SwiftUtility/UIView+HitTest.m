//
//  UIView+HitTest.m
//  CTPay
//
//  Created by zmjios on 16/3/4.
//  Copyright © 2016年 ctrip. All rights reserved.
//

#import "UIView+HitTest.h"
#import <objc/runtime.h>

@implementation UIView (HitTest)

const static NSString *STHitTestViewBlockKey = @"STHitTestViewBlockKey";
const static NSString *STPointInsideBlockKey = @"STPointInsideBlockKey";

+ (void)load {
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(hitTest:withEvent:)),
                                   class_getInstanceMethod(self, @selector(st_hitTest:withEvent:)));
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(pointInside:withEvent:)),
                                   class_getInstanceMethod(self, @selector(st_pointInside:withEvent:)));
}

- (UIView *)st_hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    NSMutableString *spaces = [NSMutableString stringWithCapacity:20];
    UIView *superView = self.superview;
    while (superView) {
        [spaces appendString:@"----"];
        superView = superView.superview;
    }
    NSLog(@"%@%@:[hitTest:withEvent:]", spaces, NSStringFromClass(self.class));
    UIView *deliveredView = nil;
    // 如果有hitTestBlock的实现，则调用block
    if (self.hitTestBlock) {
        BOOL returnSuper = NO;
        deliveredView = self.hitTestBlock(point, event, &returnSuper);
        if (returnSuper) {
            deliveredView = [self st_hitTest:point withEvent:event];
        }
    } else {
        deliveredView = [self st_hitTest:point withEvent:event];
        if ([self isKindOfClass:NSClassFromString(@"CTPFloatingView")]) {
            NSLog(@"======deliveredView=%@,ponit=%@,event=%@",deliveredView,NSStringFromCGPoint(point),event);
        }
    }
    //    NSLog(@"%@%@:[hitTest:withEvent:] Result:%@", spaces, NSStringFromClass(self.class), NSStringFromClass(deliveredView.class));
    return deliveredView;
}

- (BOOL)st_pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    NSMutableString *spaces = [NSMutableString stringWithCapacity:20];
    UIView *superView = self.superview;
    while (superView) {
        [spaces appendString:@"----"];
        superView = superView.superview;
    }
    NSLog(@"%@%@:[pointInside:withEvent:]", spaces, NSStringFromClass(self.class));
    BOOL pointInside = NO;
    if (self.pointInsideBlock) {
        BOOL returnSuper = NO;
        pointInside =  self.pointInsideBlock(point, event, &returnSuper);
        if (returnSuper) {
            pointInside = [self st_pointInside:point withEvent:event];
        }
    } else {
        pointInside = [self st_pointInside:point withEvent:event];
        if ([self isKindOfClass:NSClassFromString(@"CTPFloatingView")]) {
            NSLog(@"pointInside=%d,ponit=%@,event=%@",pointInside,NSStringFromCGPoint(point),event);
        }
    }
    return pointInside;
}

- (void)setHitTestBlock:(STHitTestViewBlock)hitTestBlock {
    objc_setAssociatedObject(self, (__bridge const void *)(STHitTestViewBlockKey), hitTestBlock, OBJC_ASSOCIATION_COPY);
}

- (STHitTestViewBlock)hitTestBlock {
    return objc_getAssociatedObject(self, (__bridge const void *)(STHitTestViewBlockKey));
}

- (void)setPointInsideBlock:(STPointInsideBlock)pointInsideBlock {
    objc_setAssociatedObject(self, (__bridge const void *)(STPointInsideBlockKey), pointInsideBlock, OBJC_ASSOCIATION_COPY);
}

- (STPointInsideBlock)pointInsideBlock {
    return objc_getAssociatedObject(self, (__bridge const void *)(STPointInsideBlockKey));
}


- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;  
}

@end
