//
//  UIView+Autoresizing.m
//  Stan
//
//  Taken from open-source code created by Chen Weigang on 12-2-3.
//  Copyright (c) 2012年 Fugu Mobile Limited. All rights reserved.
//

#import "UIView+Autoresizing.h"

@implementation UIView (Autoresizing)

- (void)autoresizingFixLeftTop
{
    self.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;
}

- (void)autoresizingFixLeftBottom
{
    self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin;
}

- (void)autoresizingFixRightTop
{
    self.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin;
}

- (void)autoresizingFixRightBottom
{
    self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
}

- (void)autoresizingFixTopFlexibleWidth
{
    self.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
}

- (void)autoresizingFixBottomFlexibleWidth
{
    self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
}

- (void)autoresizingFixLeftFlexibleHeight
{
    self.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
}

- (void)autoresizingFixRightFlexibleHeight
{
    self.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
}

- (void)autoresizingFlexibleWidthFlexibleHeight
{
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

@end




