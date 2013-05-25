//
//  MGBox+BrynKit_Animations.m
//  BrynKit
//
//  Created by bryn austin bellomy on 4.23.13.
//  Copyright (c) 2013 robot bubble bath LLC. All rights reserved.
//

#import "MGBox+BrynKit_Animations.h"

@implementation MGBox (BrynKit_Animations)

- (void) bryn_pulseBackground: (UIColor *)pulseColor
            durationInSeconds: (CFTimeInterval)durationInSeconds
{
    yssert_notNil(self.backgroundColor);

    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.fromValue    = (id)self.backgroundColor.CGColor;
    animation.toValue      = (id)pulseColor.CGColor;
    animation.autoreverses = YES;
    animation.duration = durationInSeconds;
    [self.layer addAnimation:animation forKey:@"backgroundColor"];
}

@end
