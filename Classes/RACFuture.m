//
//  RACFuture.m
//  BrynKit-RACHelpers
//
//  Created by bryn austin bellomy on 3.28.13.
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACImmediateScheduler.h>
//#import <Brynstagram/BrynstagramCommon-Private.h>

#import "BrynKit.h"
#import "RACFuture.h"
#import "RACCriticalSectionScheduler.h"



@implementation RACSignal (RACFuture)

- (RACFuture *) future
{
    RACFuture *future = RACFuture.future;

    RACDisposable *subscription =
        [self subscribeNext:^(id x) {

            [future resolve];

        } error:^(NSError *error) {

            [future sendError:error];
            [future resolve];

        } completed:^{

            [future resolve];

        }];

    [future rac_addDeallocDisposable: subscription];

    return future;
}

@end




@interface RACFuture ()

//@property (nonatomic, assign, readwrite) dispatch_queue_t queue;
//@property (nonatomic, strong, readwrite) RACCriticalSectionScheduler *scheduler;

@end



@implementation RACFuture

#pragma mark- Semantic syrup
#pragma mark-

+ (instancetype) future
{
    return [[self class] subject];
}

//+ (instancetype) error:(NSError *)error
//{
//	return [[self createSignal:^ RACDisposable * (id<RACSubscriber> subscriber) {
//		[subscriber sendError:error];
//		return nil;
//	}] setNameWithFormat:@"+error: %@", error];
//}

- (void) sendError:(NSError *)error
{
    //lllog(Error, @"ERROR ON FUTURE = %@", error);
    [super sendError:error];
}

- (instancetype) await
{
    [self first];
    return self;
}

- (RACFuture *) then: (RACFutureBlock)block
{
    __block RACFuture *future = RACFuture.future;

    [[self future]
           subscribeCompleted:^{
               block(future);
           }];

    return future;
}

- (void) resolve
{
    [self sendUnitAndComplete];
}



#pragma mark- The meat
#pragma mark-



//+ (RACFuture *) xrac_runOnCriticalSectionScheduler: (RACScheduler *)criticalSectionScheduler
//                             criticalMutationBlock: (RACFutureBlock)blockCritical
//{
//    yssert_notNil(blockCritical);
//    yssert_notNil(criticalSectionScheduler);
//
//    RACFuture *subscribableFuture = RACFuture.future;                                      yssert_notNil(subscribableFuture);
//
//    @weakify(self, subscribableFuture);
//    subscribableFuture.didSubscribe = ^(id<RACSubscriber> subscriber) {
//        @strongify(self, subscribableFuture);
//
//        yssert_notNil(subscriber);
//        yssert_notNil(blockCritical);
//        yssert_notNil(criticalSectionScheduler);
//
//        RACFuture     *innerFuture            = RACFuture.future;                                      yssert_notNil(innerFuture);
//        RACScheduler  *scheduler              = nil;
//        RACDisposable *schedulerDisposable    = nil;
//        RACDisposable *subscriptionDisposable = [subscribableFuture subscribe:subscriber];              yssert_notNil(subscriptionDisposable);
//        RACCompoundDisposable *compoundDisposable = RACCompoundDisposable.compoundDisposable;           yssert_notNil(compoundDisposable);
//        [compoundDisposable addDisposable:subscriptionDisposable];
//
//        if (RACScheduler.currentScheduler == criticalSectionScheduler || dispatch_get_current_queue() == queue)
//        {
//            scheduler = $new(RACImmediateScheduler);
//        }
//        else
//        {
//            scheduler = criticalSectionScheduler;
//        }
//
//        //
//        // schedule the block on whichever scheduler we prepared
//        //
//        schedulerDisposable = [scheduler schedule:^{
//            yssert_notNil(blockCritical);
//            yssert_notNil(innerFuture);
//
//            blockCritical(innerFuture);
//            [innerFuture await];
//            [subscribableFuture resolve];
//        }];
//
//        [compoundDisposable addDisposable:schedulerDisposable];
//
//        return compoundDisposable;
//    };
//
//    return [subscribableFuture setNameWithFormat:@"- rac_runOnCriticalSectionScheduler: %@ criticalMutationBlock: %@", criticalSectionScheduler, blockCritical];
//}



///**
// * #### rac_runOnCriticalSectionQueue:criticalMutationBlock:
// *
// * Runs the given block on the critical section queue asynchronously, but as a barrier block
// * that blocks any other critical operations until it completes.  This apparently has an
// * advantage for performance.
// *
// * @param {dispatch_queue_t} queue
// * @param {RACFutureBlock} blockCritical
// * @return {RACFuture*}
// */
//
//+ (RACFuture *) rac_runOnCriticalSectionQueue: (dispatch_queue_t)queue
//                        criticalMutationBlock: (RACFutureBlock)blockCritical
//{
//    yssert_notNil(queue);
//    yssert_notNil(blockCritical);
//
//    RACCriticalSectionScheduler *scheduler = [RACCriticalSectionScheduler schedulerForQueue: queue];
//    yssert_notNil(scheduler);
//
//    return [scheduler scheduleCritical:blockCritical];
//}

@end




