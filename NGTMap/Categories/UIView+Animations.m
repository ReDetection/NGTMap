//
//  UIView+Animations.m
//  Recording Application
//
//  Created by Bromot Aleksey on 28.06.13.
//  Copyright (c) 2013 Magora-Systems. All rights reserved.
//

#import "UIView+Animations.h"
#import <QuartzCore/QuartzCore.h>

#define kAnimationDuration 0.03f

@implementation UIView (Animations)

- (void)addFadeAnimation {
    CATransition *applicationLoadViewIn = [CATransition animation];
    [applicationLoadViewIn setDuration:0.3];
    [applicationLoadViewIn setType:kCATransitionFade];
    [applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [self.layer addAnimation:applicationLoadViewIn forKey:kCATransitionReveal];
}

@end
