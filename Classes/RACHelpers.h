//
//  RACHelpers.h
//  BrynKit-RACHelpers
//
//  Created by bryn austin bellomy on 3.13.13.
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACQueueScheduler.h>

#define RACDefaultUnit RACUnit.defaultUnit


@class RACFuture;
typedef void(^RACFutureBlock)(RACFuture *future);



@interface RACQueueScheduler (BrynKit_RACHelpers)

+ (instancetype) schedulerForQueue: (dispatch_queue_t)queue;

@end



@interface RACSubject (BrynKit_RACHelpers)

- (void) sendUnit;
- (void) sendUnitAndComplete;

@end



@interface RACStream (BrynKit_RACHelpers)

- (instancetype) notNil;
- (instancetype) notNilOrRACTupleNil;
- (instancetype) filterGreaterThanZero;
- (instancetype) filterZeroOrGreater;
- (instancetype) assertIsKindOfClass:(Class)klass;
- (instancetype) assertNotNilAndIsKindOfClass:(Class)klass;

@end



@interface RACSignal (BrynKit_RACHelpers_BetterLogging)

- (instancetype) lllogAll;
- (instancetype) lllogNext;
- (instancetype) lllogError;
- (instancetype) lllogCompleted;

@end



@interface NSObject (BrynKit_RACHelpers)

- (BOOL) isNotNilAndNotRACTupleNil;

@end





