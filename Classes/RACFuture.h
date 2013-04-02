//
//  RACFuture.h
//  BrynKit-RACHelpers
//
//  Created by bryn austin bellomy on 3.13.13.
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import "RACFuture.h"
#import "RACHelpers.h"

@class RACFuture, RACCriticalSectionScheduler;



@interface RACSignal (RACFuture)

- (RACFuture *) future;

@end



@interface RACFuture : RACReplaySubject

//@property (nonatomic, assign, readonly) dispatch_queue_t queue;
//@property (nonatomic, strong, readonly) RACCriticalSectionScheduler *scheduler;

//
// semantic syrup
//
+ (instancetype) future;

- (instancetype) await;
- (void) resolve;
- (RACFuture *) then: (RACFutureBlock)block;

//
// the meat
//
//+ (RACFuture *) runOnCriticalSectionQueue: (dispatch_queue_t)queue
//                    criticalMutationBlock: (RACFutureBlock)blockCritical;
//
//+ (RACFuture *) runOnCriticalSectionScheduler: (RACCriticalSectionScheduler *)criticalSectionScheduler
//                        criticalMutationBlock: (RACFutureBlock)blockCritical;

@end
