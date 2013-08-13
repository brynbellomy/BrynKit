//
//  MGBoxHelpers.h
//  BrynKit
//
//  Created by bryn austin bellomy on 4.2.2013.
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MGBox2/MGBox.h>
#import <MGBox2/MGLine.h>
#import <MGBox2/MGTableBox.h>

#define SEMGBoxFlattenAppearance(box) \
    do { \
        box.layer.shadowColor = nil; \
        box.layer.shadowOffset = CGSizeZero; \
        box.layer.shadowRadius = 0; \
        box.layer.shadowOpacity = 0; \
        box.borderStyle = MGBorderNone; \
    } while(0)



@interface MGBox (BrynKit)

+ (instancetype) boxThatWraps:(UIView *)view;

@end


@interface UIView (BrynKit_MoreMGBoxEasyFrame)

- (void)setBoundsSize:(CGSize)size;
- (void)setBoundsWidth:(CGFloat)width;
- (void)setBoundsHeight:(CGFloat)height;
- (void)setBoundsOrigin:(CGPoint)origin;
- (void)setBoundsX:(CGFloat)x;
- (void)setBoundsY:(CGFloat)y;

- (CGSize)  boundsSize;
- (CGFloat) boundsWidth;
- (CGFloat) boundsHeight;
- (CGPoint) boundsOrigin;
- (CGFloat) boundsX;
- (CGFloat) boundsY;

@end












