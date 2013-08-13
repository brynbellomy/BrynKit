//
//  UIView+BrynKit.m
//  BrynKit
//
//  Created by bryn austin bellomy on 8.2.13.
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "UIView+BrynKit.h"

@implementation UIView (BrynKit)

- (void) bk_animateKey: (NSString *)key
               toValue: (id)toValue
              duration: (CFTimeInterval)duration
          autoreverses: (BOOL)autoreverses
{
    [self bk_animateKey:key
              fromValue:[self.layer valueForKey:key]
                toValue:toValue
               duration:duration
           autoreverses:autoreverses];
}



- (void) bk_animateKey: (NSString *)key
             fromValue: (id)fromValue
               toValue: (id)toValue
              duration: (CFTimeInterval)duration
          autoreverses: (BOOL)autoreverses
{
    CABasicAnimation *animation = [CABasicAnimation animation];

    if (fromValue) animation.fromValue = fromValue;
    if (toValue)   animation.toValue   = toValue;

    animation.duration     = duration;
    animation.autoreverses = autoreverses;

    if ( !autoreverses ) {
        animation.fillMode = kCAFillModeForwards;
    }

    [self.layer addAnimation:animation forKey:key];

    if ( !autoreverses ) {
        [self.layer setValue:toValue forKey:key];
    }
}

@end

