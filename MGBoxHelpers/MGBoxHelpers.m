//
//  MGBoxHelpers.m
//  BrynKit
//
//  Created by bryn austin bellomy on 4.2.2013.
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MGBox2/MGBox.h>
#import <MGBox2/MGTableBox.h>
#import <MGBox2/MGLine.h>

#import "BrynKit-Main.h"

@implementation UIView (BrynKit_MoreMGBoxEasyFrame)

- (void)setBoundsSize:(CGSize)size {
    CGRect bounds = self.bounds;
    bounds.size = size;
    self.bounds = bounds;
}

- (void)setBoundsWidth:(CGFloat)width {
    CGSize size = self.size;
    size.width = width;
    self.size = size;
}

- (void)setBoundsHeight:(CGFloat)height {
    CGSize size = self.size;
    size.height = height;
    self.size = size;
}

- (void)setBoundsOrigin:(CGPoint)origin {
    CGRect bounds = self.bounds;
    bounds.origin = origin;
    self.bounds = bounds;
}

- (void)setBoundsX:(CGFloat)x {
    CGPoint origin = self.origin;
    origin.x = x;
    self.origin = origin;
}

- (void)setBoundsY:(CGFloat)y {
    CGPoint origin = self.origin;
    origin.y = y;
    self.origin = origin;
}

#pragma mark - Getters

- (CGSize) boundsSize {
    return self.bounds.size;
}

- (CGFloat) boundsWidth {
    return self.size.width;
}

- (CGFloat) boundsHeight {
    return self.size.height;
}

- (CGPoint) boundsOrigin {
    return self.bounds.origin;
}

- (CGFloat) boundsX {
    return self.origin.x;
}

- (CGFloat) boundsY {
    return self.origin.y;
}


@end


@implementation MGBox (BrynKit)

+ (instancetype) boxThatWraps:(UIView *)view
{
    MGBox *box = [MGBox boxWithSize: view.size];
    yssert_notNilAndIsClass(box, MGBox);

    [box addSubview: view];
    view.x = 0.0f;
    view.y = 0.0f;

//    dispatch_async(dispatch_get_main_queue(), ^{
//        [box layout];
//    });

    return box;
}

@end


