//
//  UIColor+BrynKit_ColorLogging.m
//  BrynKit
//
//  Created by bryn austin bellomy on 8.10.13.
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//

#import "UIColor+BrynKit_ColorLogging.h"
#import "UIColor+Expanded.h"
#import "BrynKitLogging.h"

@implementation UIColor (BrynKit_ColorLogging)

- (NSString *) bk_xcodeColorsFGString
{
    return [NSString stringWithFormat:XCODE_COLORS_ESCAPE @"fg%u,%u,%u;", (NSUInteger)(self.red * 255), (NSUInteger)(self.green * 255), (NSUInteger)(self.blue * 255)];
}

- (NSString *) bk_xcodeColorsBGString
{
    return [NSString stringWithFormat:XCODE_COLORS_ESCAPE @"bg%u,%u,%u;", (NSUInteger)(self.red * 255), (NSUInteger)(self.green * 255), (NSUInteger)(self.blue * 255)];
}

@end
