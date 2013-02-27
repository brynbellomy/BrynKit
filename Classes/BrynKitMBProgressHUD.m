//
//  BrynKitMBProgressHUD.m
//  BrynKit
//
//  Created by bryn austin bellomy on 2/27/2013.
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//

#import <libextobjc/EXTScope.h>
#import <MBProgressHUD/MBProgressHUD.h>

#import "BrynKitMBProgressHUD.h"

/**
 * BrynShowMBProgressHUD()
 *
 * @param onView {UIView*}
 * @param block_setupHUD {MBProgressHUDBlock}
 * @param block_afterShowingHUD {dispatch_block_t}
 */
void BrynShowMBProgressHUD (UIView *onView, MBProgressHUDBlock block_setupHUD, dispatch_block_t block_afterShowingHUD) {
    dispatch_queue_t q = dispatch_queue_create("com.brynkit.SetupHUDQueue", 0);
    dispatch_set_target_queue(q, dispatch_get_main_queue());

    @weakify(onView);
    dispatch_async(q, ^{
        @strongify(onView);

        if (onView == nil)
            return;

        MBProgressHUD *theHUD = [MBProgressHUD HUDForView:onView] ?: [MBProgressHUD showHUDAddedTo:onView animated:YES];
        block_setupHUD(theHUD);
    });

    if (block_afterShowingHUD != nil) {
        dispatch_async(q, block_afterShowingHUD);
    }
}
