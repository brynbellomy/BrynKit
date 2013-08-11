//
//  RACCriticalSectionScheduler.m
//  BrynKit-RACHelpers
//
//  Created by bryn austin bellomy on 3.28.13.
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//

#import <ReactiveCocoa/RACTargetQueueScheduler.h>
#import <ReactiveCocoa/RACScheduler+Private.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <GCDThreadsafe/GCDThreadsafe.h>
#import <libextobjc/EXTScope.h>

#import "BrynKit-Main.h"

#import "RACHelpers.h"
#import "RACCriticalSectionScheduler.h"
#import "RACFuture.h"



@interface RACTargetQueueScheduler ()
    @property (nonatomic, readonly) dispatch_queue_t queue;
@end



@interface RACCriticalSectionScheduler () <GCDThreadsafe>
@end


@implementation RACCriticalSectionScheduler

static void currentSchedulerRelease(void *context)
{
	CFBridgingRelease(context);
}


BKImplementConvenienceInitializer(scheduler,WithName:, NSString *, name,
                                         targetQueue:, dispatch_queue_t, targetQueue)



- (instancetype) initWithName: (NSString *)name
                  targetQueue: (dispatch_queue_t)targetQueue
{
    self = [super initWithName:name targetQueue:targetQueue];
    if (self)
    {
        self.queueCritical = targetQueue;
        GCDInitializeQueue( self.queueCritical );
    }
    return self;
}



- (void) performAsCurrentScheduler: (RACFutureBlock)block
                        withFuture: (RACFuture *)future
{
    yssert_notNull( block );
    yssert_notNilAndIsClass( future, RACFuture );

    dispatch_queue_set_specific( self.queue, (__bridge void *)RACSchedulerCurrentSchedulerKey, (void *)CFBridgingRetain( self ), currentSchedulerRelease );
    block( future );
    dispatch_queue_set_specific( self.queue, (__bridge void *)RACSchedulerCurrentSchedulerKey, nil, currentSchedulerRelease );
}



- (RACFuture *) scheduleCritical: (RACFutureBlock)block
{
    yssert_notNil(block);

    __block RACFuture *subscribableFuture = [RACFuture future];
    yssert_notNilAndIsClass(subscribableFuture, RACFuture);

    if ( GCDCurrentQueueIs( self.queueCritical ) )
    {
        block( subscribableFuture );
    }
    else
    {
        @weakify(self)
        dispatch_barrier_async(self.queueCritical, ^{
            @strongify(self);
            [self performAsCurrentScheduler:block withFuture:subscribableFuture];
        });
    }

    return subscribableFuture;
}



- (RACFuture *) after: (dispatch_time_t)when
     scheduleCritical: (RACFutureBlock)block
{
    yssert_notNil(block);

    RACFuture *subscribableFuture = [RACFuture future];
    yssert_notNil(subscribableFuture);

    @weakify(self);
    dispatch_after(when, self.queue, ^{
        @strongify(self);
        [self performAsCurrentScheduler:block withFuture:subscribableFuture];
    });

    return subscribableFuture;
}



@end







