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

/**!
 * ### BrynShowMBProgressHUD()
 *
 * Opens an MBProgressHUD in a block on the main thread from a background thread
 * in such a way that it ought to show up instantly rather than pausing.
 */

extern void BrynShowMBProgressHUD(UIView *onView, MBProgressHUDBlock block_setupHUD, dispatch_block_t block_afterShowingHUD);

