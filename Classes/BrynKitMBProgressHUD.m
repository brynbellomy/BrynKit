//
//  BrynKitMBProgressHUD.m
//  BrynKit
//
//  Created by bryn austin bellomy on 2/27/2013.
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//

#import <libextobjc/EXTScope.h>
#import <MBProgressHUD/MBProgressHUD.h>

#import "BrynKit.h"
#import "BrynKitMBProgressHUD.h"

/**
 * # MBProgressHUD helpers
 */

@implementation MBProgressHUD (BrynKitThreadsafe)

/**
 * #### threadsafeShowHUDOnView:setupHUD:
 *
 * Opens an `MBProgressHUD` on the main thread.  If an `MBProgressHUD` is already
 * visible on the provided `UIView`, that HUD is used instead of opening a new
 * one.  If the provided `UIView` is `nil`, the method simply returns.
 *
 * ```
 * [MBProgressHUD threadsafeShowHUDOnView: someView
 *                               setupHUD:^(MBProgressHUD *hud) {
 *                                   hud.text = @"Blah";
 *                                   hud.mode = MBProgressHUDModeIndeterminate;
 *                               }];
 * ```
 *
 * @param onView {UIView*} The view on which to display the HUD.
 * @param block_setupHUD {MBProgressHUDBlock} A block in which the HUD can be customized or updated.
 */
+ (void) threadsafeShowHUDOnView: (UIView *)_onView
                        setupHUD: (MBProgressHUDBlock)_block_setupHUD
{
    __block UIView *onView = _onView;
    __block MBProgressHUDBlock block_setupHUD = [_block_setupHUD copy];

    dispatch_block_t block = ^{
        if (onView != nil) {
            MBProgressHUD *hud = [MBProgressHUD HUDForView:onView];
            if (hud == nil) {
                hud = [MBProgressHUD showHUDAddedTo:onView animated:YES];
            }
            yssert(hud != nil, @"hud is nil.");

            block_setupHUD(hud);
        }
    };

    if ([NSThread isMainThread]) {
        block();
    }
    else {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

@end






