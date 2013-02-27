//
//  NSObject+GCDThreadsafe.m
//  BrynKit
//
//  Created by bryn austin bellomy on 2.23.13.
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//

#import "NSObject+GCDThreadsafe.h"

@implementation NSObject (Threadsafe)

/**
 * # Instance methods
 */

/**
 * #### queueCritical
 *
 * Returns the dispatch queue on which critical sections are run.
 *
 * @return {dispatch_queue_t}
 */

- (dispatch_queue_t) queueCritical
{
    static dispatch_queue_t queue = nil;

    if (queue == nil) {
        queue = dispatch_queue_create("com.signalenvelope.NSObject-Threadsafe", 0);
    }

    return queue;
}



/**
 * #### runCriticalMutableSection:
 *
 * Runs the given block on the critical section queue asynchronously, but as a barrier block
 * that blocks any other critical operations until it completes.
 *
 * @param {dispatch_block_t} blockCritical
 * @return {void}
 */

- (void) runCriticalMutableSection: (dispatch_block_t)blockCritical
{
    dispatch_barrier_async(self.queueCritical, blockCritical);
}



/**
 * runCriticalReadonlySection:
 *
 * Runs the given block on the critical section queue synchronously so that surrounding code
 * can make use of
 *
 * @param {dispatch_block_t} blockCritical
 * @return {void}
 */

- (void) runCriticalReadonlySection: (dispatch_block_t)blockCritical
{
    if (dispatch_get_current_queue() == self.queueCritical) {
        blockCritical();
    }
    else {
        dispatch_sync(self.queueCritical, blockCritical);
    }
}



@end



