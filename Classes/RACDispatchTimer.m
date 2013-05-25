//
//  RACDispatchTimer.m
//  RACDispatchTimer
//
//  Created by bryn austin bellomy on 3.3.13.
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <libextobjc/EXTScope.h>

#import "BrynKit.h"
#import "RACHelpers.h"
#import "RACDispatchTimer.h"
#import "SEDispatchSource.h"



@interface RACDispatchTimer ()
    @property (nonatomic, strong,          readwrite) SEDispatchSource *dispatchSource;
    @property (nonatomic, dispatch_strong, readwrite) dispatch_source_t source;
    @property (nonatomic, dispatch_strong, readwrite) dispatch_queue_t queue;

    @property (nonatomic, assign, readwrite) uint64_t interval;
    @property (nonatomic, assign, readwrite) uint64_t leeway;
    @property (nonatomic, assign, readwrite) SEDispatchSourceState state;
    @property (nonatomic, assign, readwrite) BOOL isActive;
    @property (nonatomic, assign, readwrite) BOOL isCanceled;
    @property (nonatomic, assign, readwrite) BOOL isQueueSuspended;
@end

@implementation RACDispatchTimer {}

#pragma mark- Lifecycle
#pragma mark-

/**
 * #### timerWithIntervalInNanoseconds:leeway:
 *
 * @param {uint64_t} interval
 * @param {uint64_t} leeway
 *
 * @return {instancetype}
 */

+ (instancetype) timerWithIntervalInNanoseconds:(uint64_t)interval
                                         leeway:(uint64_t)leeway
{
    return [[self alloc] initWithIntervalInNanoseconds:interval leeway:leeway];
}

/**
 * #### initWithIntervalInNanoseconds:leeway:
 *
 * @param {uint64_t} interval
 * @param {uint64_t} leeway
 *
 * @return {instancetype}
 */

- (instancetype) initWithIntervalInNanoseconds:(uint64_t)interval
                                        leeway:(uint64_t)leeway
{

    self = [super init];
    if (self) {
        _interval = interval;
        _leeway   = leeway;

        _queue          = dispatch_queue_create("com.signalenvelope.RACDispatchTimer", 0);
        _source         = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, _queue);
        dispatch_source_set_timer(_source, dispatch_walltime(NULL, 0), _interval, _leeway);

        @weakify(self);

        _dispatchSource = [[SEDispatchSource alloc] initWithSource:_source onQueue:_queue
                                                           handler: ^{ @strongify(self); [self execute:[NSDate date]]; }
                                                       cancelation: ^{ @strongify(self); [self handleCancellation];    }];

        [self initializeReactiveKVO];
    }
    return self;
}



- (void) initializeReactiveKVO
{
    RAC(self.state) = RACAbleWithStart(_dispatchSource, state);

    RAC(self.isActive)   = [RACAbleWithStart(self.state)
                                mapFromUnsignedInteger:^id (SEDispatchSourceState state) {

                                    switch (state)
                                    {
                                        case SEDispatchSourceState_Resumed:
                                            return @YES;

                                        case SEDispatchSourceState_Canceled:
                                        case SEDispatchSourceState_Suspended:
                                        default:
                                            return @NO;

                                    }
                                }];

    RAC(self.isCanceled)  = [RACAbleWithStart(self.state)
                                mapFromUnsignedInteger:^id(SEDispatchSourceState state) {

                                    switch (state)
                                    {
                                        case SEDispatchSourceState_Canceled:
                                            return @YES;

                                        case SEDispatchSourceState_Suspended:
                                        case SEDispatchSourceState_Resumed:
                                        default:
                                            return @NO;
                                    }
                                }];
    
}



/**
 * #### dealloc
 *
 * @return {void}
 */

- (void) dealloc
{
    [self cancel];
}



#pragma mark- State changes
#pragma mark-

/**
 * #### resume
 *
 * @return {void}
 */

- (void) resume
{
    @synchronized (self)
    {
//        if (self.isQueueSuspended == YES) {
//            dispatch_resume(self.queue);
//            self.isQueueSuspended = NO;
//        }

        [self.dispatchSource resume];
    }
}



/**
 * #### stop
 *
 * @return {void}
 */

- (void) stop
{
    @synchronized (self)
    {
//        if (self.isQueueSuspended == NO) {
//            dispatch_suspend(self.queue);
//            self.isQueueSuspended = YES;
//        }
        [self.dispatchSource stop];
    }
}



/**
 * #### cancel
 *
 * @return {void}
 */

- (void) cancel
{
    @synchronized (self)
    {
//        if (self.isQueueSuspended == NO) {
//            dispatch_suspend(self.queue);
//            self.isQueueSuspended = YES;
//        }
        [self.dispatchSource cancel];
    }
}



#pragma mark- Doin' work
#pragma mark-

/**
 * #### execute:
 *
 * @param  {NSDate*} date
 * @return {void}
 */

- (void) execute:(NSDate *)date
{
    [self sendNext:date];
}



/**
 * #### handleCancellation
 *
 * @return {void}
 */

- (void) handleCancellation
{
    [self sendCompleted];

    @synchronized (self)
    {
//        if (self.dispatchSource != nil) {
//            dispatch_release(self.source);
            self.dispatchSource = nil;
//        }

//        if (self.queue != nil) {
//            dispatch_release(self.queue);
            self.queue = nil;
//        }

        self.source = nil;
    }
}

@end







