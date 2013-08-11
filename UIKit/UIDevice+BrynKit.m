//
//  UIDevice+BrynKit.m
//  BrynKit
//
//  Created by bryn austin bellomy on 7.27.13.
//  Copyright (c) 2013 signalenvelope llc. All rights reserved.
//

#import "BrynKit-Main.h"
#import "UIDevice+BrynKit.h"
#import "UIScreen+BrynKit.h"

@implementation UIDevice (BrynKit)

+ (BOOL)bk_isIPad
{
    return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad;
}



+ (BOOL)bk_isMultitaskingSupported
{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(isMultitaskingSupported)])
    {
        return [[UIDevice currentDevice] isMultitaskingSupported];
    }
    return NO;
}



+ (BOOL)bk_isIPhone5OrTaller
{
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone
        && [[UIScreen mainScreen] bk_actualHeight] >= 1136;
}

@end
