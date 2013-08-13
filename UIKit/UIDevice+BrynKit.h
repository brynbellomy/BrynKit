//
//  UIDevice+BrynKit.h
//  BrynKit
//
//  Created by bryn austin bellomy on 7.27.13.
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (BrynKit)

+ (BOOL)bk_isMultitaskingSupported;
+ (BOOL)bk_isIPhone5OrTaller;
+ (BOOL)bk_isIPad;

@end
