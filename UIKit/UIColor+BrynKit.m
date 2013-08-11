//
//  UIColor+BrynKit.m
//  BrynKit
//
//  Created by bryn austin bellomy on 8.10.13.
//  Copyright (c) 2013 signalenvelope llc. All rights reserved.
//

#import "UIColor+BrynKit.h"

@implementation UIColor (BrynKit)

+ (instancetype) bk_rgba:(CGFloat [4])rgba
{
    return [UIColor colorWithRed:rgba[0] green:rgba[1] blue:rgba[2] alpha:rgba[3]];
}

@end




