//
//  GCDThreadsafe.h
//  BrynKit
//
//  Created by bryn austin bellomy on 2.23.13.
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <libextobjc/metamacros.h>

@protocol GCDThreadsafe

@required
    @property (nonatomic, assign, readonly) dispatch_queue_t queueCritical;
    - (void) runCriticalMutableSection:(dispatch_block_t)criticalMutation;
    - (void) runCriticalReadonlySection:(dispatch_block_t)criticalRead;
@end

#define gcd_threadsafe_init(concurrency, queueLabel) \
    try{}@finally{} \
    do { \
        _queueCritical = dispatch_queue_create(queueLabel, metamacro_concat(DISPATCH_QUEUE_,concurrency)); \
    } while(0)

#define gcd_threadsafe \
    class NSObject;\
\
    @synthesize queueCritical = _queueCritical; \
    - (void) runCriticalMutableSection: (dispatch_block_t)criticalMutation \
    { \
        yssert(self.queueCritical != nil, @"critical queue is nil."); \
\
        if (dispatch_get_current_queue() == self.queueCritical) { \
            criticalMutation(); \
        } \
        else { \
            dispatch_barrier_async(self.queueCritical, criticalMutation); \
        } \
    } \
\
    - (void) runCriticalReadonlySection: (dispatch_block_t)criticalRead \
    { \
        yssert(self.queueCritical != nil, @"critical queue is nil."); \
\
        if (dispatch_get_current_queue() == self.queueCritical) { \
            criticalRead(); \
        } \
        else { \
            dispatch_safe_sync(self.queueCritical, criticalRead); \
        } \
    }

