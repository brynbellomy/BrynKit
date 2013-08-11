//
//  RACFuture.h
//  BrynKit-RACHelpers
//
//  Created by bryn austin bellomy on 3.13.13.
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import "RACHelpers.h"

@class RACFuture, RACCriticalSectionScheduler;

@interface RACSignal (RACFuture)

- (RACFuture *) futureFromSignal;

@end



@interface RACFuture : RACReplaySubject

@property (nonatomic, assign, readonly)  BOOL resolved;

+ (instancetype) future;
+ (instancetype) futureOnScheduler:(RACScheduler *)scheduler block:(RACFutureBlock)block __attribute__(( nonnull (1, 2) ));
+ (instancetype) futureOnDefaultScheduler:(RACFutureBlock)block __attribute__(( nonnull (1) ));
+ (instancetype) futureOnMainThread:(RACFutureBlock)block __attribute__(( nonnull (1) ));
+ (instancetype) futureWithError:(NSError *)error __attribute__(( nonnull (1) ));

- (void) resolve;
- (void) resolve: (id)result __attribute__(( nonnull (1) ));

- (instancetype) await;
- (instancetype) then: (RACFutureBlock)block __attribute__(( nonnull (1) ));

@end





