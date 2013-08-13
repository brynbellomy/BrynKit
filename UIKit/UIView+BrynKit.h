//
//  UIView+BrynKit.h
//  BrynKit
//
//  Created by bryn austin bellomy on 8.2.13.
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (BrynKit)

- (void)bk_animateKey:(NSString *)key fromValue:(id)fromValue toValue:(id)toValue duration:(CFTimeInterval)duration autoreverses:(BOOL)autoreverses;
- (void)bk_animateKey:(NSString *)key toValue:(id)toValue duration:(CFTimeInterval)duration autoreverses:(BOOL)autoreverses;

@end
