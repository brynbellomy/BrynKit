//
//  GCDThreadsafe.h
//  BrynKit
//
//  Created by bryn austin bellomy on 2.23.13.
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <libextobjc/metamacros.h>

#import "Bryn.h"
#import "BrynKitDebugging.h"
#import "BrynKitLogging.h"

#import "RACHelpers.h"
#import "RACFuture.h"
#import "RACCriticalSectionScheduler.h"

@protocol GCDThreadsafe

@required
    @property (nonatomic, assign, readonly) dispatch_queue_t queueCritical;
    - (void) runCriticalMutableSection:(dispatch_block_t)criticalMutation;
    - (void) runCriticalReadonlySection:(dispatch_block_t)criticalRead;
@end

@protocol GCDReactiveThreadsafe <GCDThreadsafe>

@required
    @property (nonatomic, strong, readwrite) RACCriticalSectionScheduler *criticalScheduler;

@end



#define gcd_threadsafe_init(concurrency, queueLabel) \
    try{}@finally{} \
    do { \
        _queueCritical = dispatch_queue_create(queueLabel, metamacro_concat(DISPATCH_QUEUE_,concurrency)); \
        dispatch_queue_set_specific(_queueCritical, &GCDThreadsafeQueueKey, (__bridge void *)self, NULL); \
        yssert_notNil(_queueCritical); \
    } while(0)




#define gcd_threadsafe \
    class NSObject;\
\
    static char GCDThreadsafeQueueKey; \
    @synthesize queueCritical = _queueCritical; \
    - (void) runCriticalMutableSection: (dispatch_block_t)criticalMutation \
    { \
        yssert_notNil(self.queueCritical); \
\
        if (dispatch_queue_get_specific(self.queueCritical, &GCDThreadsafeQueueKey) == self.queueCritical) { \
            criticalMutation(); \
        } \
        else { \
            dispatch_barrier_async(self.queueCritical, criticalMutation); \
        } \
    } \
\
    - (void) runCriticalReadonlySection: (dispatch_block_t)criticalRead \
    { \
        yssert_notNil(self.queueCritical); \
\
        if (dispatch_queue_get_specific(self.queueCritical, &GCDThreadsafeQueueKey) == self.queueCritical) { \
            criticalRead(); \
        } \
        else { \
            dispatch_safe_sync(self.queueCritical, criticalRead); \
        } \
    } \
\




#define gcd_reactive_threadsafe_init() \
    try{}@finally{} \
    do { \
        self.criticalScheduler = [RACCriticalSectionScheduler schedulerForQueue: _queueCritical]; \
    } while(0)





