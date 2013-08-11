//
//  UIScreen+BrynKit.m
//  BrynKit
//
//  Created by bryn austin bellomy on 7.27.13.
//  Copyright (c) 2013 signalenvelope llc. All rights reserved.
//

#import "UIScreen+BrynKit.h"

@implementation UIScreen (BrynKit)

- (CGFloat) bk_scaledHeight
{
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    return height;
}



- (CGFloat) bk_scaledWidth
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    return width;
}



- (CGFloat) bk_actualHeight
{
    CGFloat scale  = [UIScreen mainScreen].scale;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;

    return height * scale;
}



- (CGFloat) bk_actualWidth
{
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;

    return width * scale;
}

@end
