//
//  RACFuture.m
//  BrynKit-RACHelpers
//
//  Created by bryn austin bellomy on 3.28.13.
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACImmediateScheduler.h>

#import "Bryn.h"
#import "BrynKitDebugging.h"
#import "BrynKitLogging.h"

#import "RACFuture.h"
#import "RACCriticalSectionScheduler.h"



@implementation RACSignal (RACFuture)

- (RACFuture *) futureFromSignal
{
    RACFuture *future = [RACFuture future];

    RACDisposable *subscription =
        [self subscribeNext:^(id x) {

            [future resolve];

        } error:^(NSError *error) {

            [future sendError:error];
            [future resolve];

        } completed:^{

            [future resolve];

        }];

    [[future rac_deallocDisposable] addDisposable:subscription];

    return future;
}

@end




@interface RACFuture ()
    @property (nonatomic, assign, readwrite) BOOL resolved;
@end

@implementation RACFuture {}

#pragma mark- Semantic syrup
#pragma mark-

+ (instancetype) future
{
    return [[self class] replaySubjectWithCapacity:1];
}



+ (instancetype) futureOnDefaultScheduler: (RACFutureBlock)block
{
    return [self futureOnScheduler: [RACScheduler scheduler]
                             block: [block copy]];
}



+ (instancetype) futureOnScheduler: (RACScheduler *)scheduler
                             block: (RACFutureBlock)block
{
    __block RACFutureBlock futureBlock = [block copy];
    __block RACFuture *future = [RACFuture future];

    [scheduler schedule:^{
        futureBlock( future );
    }];

    return future;
}



+ (instancetype) futureOnMainThread:(RACFutureBlock)block
{
    return [self futureOnScheduler: [RACScheduler mainThreadScheduler]
                             block: [block copy]];
}



+ (instancetype) futureWithError:(NSError *)error
{
    id future = [self future];
    [future sendError: error];
    return future;
}



- (instancetype) await
{
    [self first];
    return self;
}



- (instancetype) then: (RACFutureBlock)block
{
    __block RACFuture *future           = [[self class] future];
    __block RACFutureBlock futureBlock  = [block copy];

    [self subscribeCompleted:^{
        yssert_notNull( futureBlock );
        futureBlock( future );
    }];

    yssert_notNilAndIsClass( future, RACFuture );
    return future;
}


- (void) sendNext:(id)value
{
    @synchronized (self)
    {
        if ( self.resolved ) {
            yssert_fail( @"RACFuture is already resolved and cannot be resolved more than once." );
        }

        self.resolved = YES;
        [super sendNext:value];
        [self sendCompleted];
    }
}


- (void) resolve: (id)result
{
    @synchronized (self)
    {
        [self sendNext:result];
    }
}



- (void) resolve
{
    @synchronized (self)
    {
        [self resolve: RACDefaultUnit];
    }
}

@end




