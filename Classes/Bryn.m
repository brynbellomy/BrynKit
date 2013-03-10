//
//  Bryn.m
//  BrynKit
//
//  Created by bryn austin bellomy on 7/29/12.
//  Copyright (c) 2012 bryn austin bellomy. All rights reserved.
//

#import "Bryn.h"

/**!
 * ### dispatch_safe_sync()
 *
 * Exactly like `dispatch_sync()`, except that it prevents you from deadlocking
 * the current queue by calling `dispatch_sync()` on it.  If the `queue`
 * parameter turns out to be the current queue (or the current queue is the main
 * queue, which you can't call `dispatch_sync()` on), it will just call `block()`.
 *
 * @param {dispatch_queue_t} queue The queue on which to execute the block.
 * @param {dispatch_block_t} block The block to execute.
 */
void dispatch_safe_sync(dispatch_queue_t queue, dispatch_block_t block) {
    if ((dispatch_get_main_queue() == queue && [NSThread isMainThread]) || dispatch_get_current_queue() == queue)
        block();
    else
        dispatch_sync(queue, block);
}







