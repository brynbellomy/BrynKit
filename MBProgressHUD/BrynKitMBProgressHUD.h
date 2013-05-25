//
//  BrynKitMBProgressHUD.h
//  BrynKit
//
//  Created by bryn austin bellomy on 2/27/2013.
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MBProgressHUD;

typedef void(^MBProgressHUDBlock)(MBProgressHUD *hud);

@interface MBProgressHUD (BrynKit)

+ (void) bryn_threadsafeShowHUDOnView:(UIView *)onView
                             setupHUD:(MBProgressHUDBlock)block_setupHUD;

@end

