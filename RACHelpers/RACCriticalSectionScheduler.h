//
//  RACCriticalSectionScheduler.h
//  BrynKit-RACHelpers
//
//  Created by bryn austin bellomy on 3.28.13.
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//

#import <ReactiveCocoa/RACTargetQueueScheduler.h>
#import "RACHelpers.h"

@class RACFuture;

@interface RACCriticalSectionScheduler : RACTargetQueueScheduler

+ (instancetype) schedulerWithName:(NSString *)name targetQueue:(dispatch_queue_t)targetQueue;
- (instancetype)      initWithName:(NSString *)name targetQueue:(dispatch_queue_t)targetQueue;

- (RACFuture *) scheduleCritical:(RACFutureBlock)block;
- (RACFuture *) after:(dispatch_time_t)when scheduleCritical:(RACFutureBlock)block;

@end





