//
//  RACFutureSpec.m
//  BrynKit
//
//  Created by bryn austin bellomy on 6.1.13.
//  Copyright (c) 2013 signalenvelope llc. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import <libextobjc/EXTScope.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

#import "RACFuture.h"

SPEC_BEGIN(RACFutureSpec)

context(@"an initialized RACFuture", ^{
    __block RACFuture *testFuture = nil;

    describe(@"after initialization", ^{

        beforeEach(^{
            testFuture = [RACFuture future];
        });

        it(@"should send subscribers a 'next' when it resolves containing a RACUnit.defaultUnit", ^{

            __block NSNumber *flag_isARACUnit = @NO;

            [testFuture subscribeNext:^(id next) {
                if (next == [RACUnit defaultUnit]) {
                    flag_isARACUnit = @YES;
                }
            }];

            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [testFuture resolve];
            });

            [[expectFutureValue(flag_isARACUnit) shouldEventuallyBeforeTimingOutAfter(2.0)] equal:@YES];

        });

        it(@"should also complete when it resolves", ^{

            __block NSNumber *flag_didComplete = @NO;

            [testFuture subscribeCompleted:^{
                flag_didComplete = @YES;
            }];

            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [testFuture resolve];
            });

            [[expectFutureValue(flag_didComplete) shouldEventuallyBeforeTimingOutAfter(2.0)] equal:@YES];

        });

        it(@"should pause the current queue when -await is called and stay paused until -resolve is called on the future", ^{

            __block NSNumber *resolved = @NO;

            [testFuture subscribeCompleted:^{
                resolved = @YES;
            }];

            [[resolved should] equal:@NO];

            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [testFuture resolve];
            });

            [[expectFutureValue(resolved) shouldEventuallyBeforeTimingOutAfter(2.0)] equal:@YES];

        });

    });

});

SPEC_END






