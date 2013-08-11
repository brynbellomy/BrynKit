//
//  UILabel+BrynKit.m
//  BrynKit
//
//  Created by bryn austin bellomy on 8.2.13.
//  Copyright (c) 2013 signalenvelope llc. All rights reserved.
//

#import "UILabel+BrynKit.h"

@implementation UILabel (BrynKit)

- (void) bk_setLabelTextAndSizeToFit:(NSString *)newText
{
    self.text = newText;
    [self sizeToFit];
}

@end
