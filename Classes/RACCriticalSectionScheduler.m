//
//  RACCriticalSectionScheduler.m
//  BrynKit-RACHelpers
//
//  Created by bryn austin bellomy on 3.28.13.
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACQueueScheduler.h>
#import <ReactiveCocoa/RACScheduler+Private.h>
#import <libextobjc/EXTScope.h>

#import "RACHelpers.h"
#import "RACCriticalSectionScheduler.h"
#import "BrynKit.h"
#import "RACHelpers.h"
#import "RACFuture.h"



@interface RACQueueScheduler ()

@property (nonatomic, readonly) dispatch_queue_t queue;

@end



@implementation RACCriticalSectionScheduler

static void currentSchedulerRelease(void *context) {
	CFBridgingRelease(context);
}

/**
 * performAsCurrentScheduler:withFuture:
 *
 * @param {RACFutureBlock} block
 * @param {RACFuture*} future
 */

- (void) performAsCurrentScheduler: (RACFutureBlock)block
                        withFuture: (RACFuture *)future
{
    yssert_notNil(block);
    yssert_notNil(future);

    dispatch_queue_set_specific(self.queue, RACSchedulerCurrentSchedulerKey, (void *)CFBridgingRetain(self), currentSchedulerRelease);
    block(future);
    dispatch_queue_set_specific(self.queue, RACSchedulerCurrentSchedulerKey, nil, currentSchedulerRelease);
}



/**
 * scheduleCritical:
 *
 * @param {RACFutureBlock} block
 * @return {RACFuture*}
 */

- (RACFuture *) scheduleCritical: (RACFutureBlock)block
{
    yssert_notNil(block);

    __block RACFuture *subscribableFuture = RACFuture.future;
    yssert_notNil(subscribableFuture);

//    if ((self.queue == dispatch_get_current_queue()) || (RACScheduler.currentScheduler == self))
//    {
//        block(subscribableFuture);
//    }
//    else
//    {
    @weakify(self)
    dispatch_barrier_async(self.queue, ^{
        @strongify(self);
        [self performAsCurrentScheduler:block withFuture:subscribableFuture];
    });
//    }

    return subscribableFuture;
}



/**
 * after:scheduleCritical:
 *
 * @param {dispatch_time_T} when
 * @param {RACFutureBlock} block
 * @return {RACFuture*}
 */

- (RACFuture *) after: (dispatch_time_t)when
     scheduleCritical: (RACFutureBlock)block
{
    yssert_notNil(block);

    RACFuture *subscribableFuture = RACFuture.future; yssert_notNil(subscribableFuture);

    @weakify(self);
    dispatch_after(when, self.queue, ^{
        @strongify(self);
        [self performAsCurrentScheduler:block withFuture:subscribableFuture];
    });

    return subscribableFuture;
}



@end
