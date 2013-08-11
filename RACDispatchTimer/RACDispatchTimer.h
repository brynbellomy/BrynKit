////
////  RACDispatchTimer.h
////  BrynKit
////
////  Created by bryn austin bellomy on 3.3.13.
////  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
////
//
//#import <ReactiveCocoa/ReactiveCocoa.h>
//#import "SEDispatchSource.h"
//
//@interface RACDispatchTimer : RACSignal <RACSubscriber>
//
//@property (nonatomic, assign, readonly) uint64_t interval;
//@property (nonatomic, assign, readonly) uint64_t leeway;
//@property (nonatomic, assign, readonly) BOOL isCanceled;
//@property (nonatomic, assign, readonly) BOOL isActive;
//
///**---------------------------------------------------------------------------------------
// * @name Initialization
// *  ---------------------------------------------------------------------------------------
// */
//
//#pragma mark- Initialization
//#pragma mark-
//
///**
// * Create a timer with the given nanosecond interval and leeway.
// *
// * @param interval The number of nanoseconds between each `RACEvent` sent by the timer.
// * @param leeway The amount of leeway (in nanoseconds) that the timer is allowed while attempting to schedule on-time `RACEvents`.
// * @return An initialized (but unstarted) `RACDispatchTimer`.
// *
// * @see dispatch_source_set_timer
// **/
//+ (instancetype) timerWithIntervalInNanoseconds:(uint64_t)interval leeway:(uint64_t)leeway;
//
//
//
///**
// * The designated initializer.  Initializes a timer with the given nanosecond interval and leeway.
// *
// * @param interval The number of nanoseconds between each `RACEvent` sent by the timer.
// * @param leeway The amount of leeway (in nanoseconds) that the timer is allowed while attempting to schedule on-time `RACEvents`.
// * @return An initialized (but unstarted) `RACDispatchTimer`.
// *
// * @see dispatch_source_set_timer
// **/
//- (instancetype)  initWithIntervalInNanoseconds:(uint64_t)interval leeway:(uint64_t)leeway;
//
//
//
///**---------------------------------------------------------------------------------------
// * @name Starting and stopping the timer
// *  ---------------------------------------------------------------------------------------
// */
//#pragma mark- Starting and stopping the timer
//#pragma mark-
//
///**
// * Resume a stopped (or new and unstarted) timer.
// *
// * For example:
//
//     RACDispatchTimer *timer = [RACDispatchTimer timerWithIntervalInNanoseconds: (0.1f * NSEC_PER_SEC)
//                                                                         leeway: (0.01f * NSEC_PER_SEC)];
//     [timer resume];
//
// */
//- (void) resume;
//
//
//
///**
// * Stop a started timer.
// *
// * In terms of the Grand Central Dispatch calls made behind the scenes, this method
// * calls `dispatch_suspend(...)` on the `dispatch_source_t` object upon which `RACDispatchTimer` relies.
// *
// * The `dispatch_source_t` object isn't canceled until the `RACDispatchTimer` object deallocates.
// *
// * @see dispatch_suspend
// */
//- (void) suspend;
//
//@end






