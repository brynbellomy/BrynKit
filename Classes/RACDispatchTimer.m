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
#import "RACDispatchTimer.h"

typedef enum : NSUInteger {
    SEDispatchSourceState_Suspended = 1,
    SEDispatchSourceState_Resumed   = 2,
    SEDispatchSourceState_Canceled  = 3
} SEDispatchSourceState;

@interface RACDispatchTimer ()
    @property (nonatomic, assign, readwrite) uint64_t interval;
    @property (nonatomic, assign, readwrite) uint64_t leeway;
    @property (nonatomic, assign, readwrite) SEDispatchSourceState dispatchSourceState;
    @property (nonatomic, assign, readwrite) BOOL isActive;
    @property (nonatomic, assign, readwrite) BOOL isCanceled;
    @property (nonatomic, assign, readwrite) dispatch_source_t dispatchSource;
    @property (nonatomic, assign, readwrite) dispatch_queue_t dispatchQueue;
@end

@implementation RACDispatchTimer

/**
 * #### +timerWithInterval:leeway
 *
 * @param {uint64_t} interval
 * @param {uint64_t} leeway
 *
 * @return {instancetype}
 */

+ (instancetype) timerWithInterval:(uint64_t)interval
                            leeway:(uint64_t)leeway
{
    return [[self alloc] initWithInterval:interval leeway:leeway];
}

/**
 * #### initWithInterval:leeway:
 *
 * @param {uint64_t} interval
 * @param {uint64_t} leeway
 *
 * @return {instancetype}
 */

- (instancetype) initWithInterval:(uint64_t)interval
                           leeway:(uint64_t)leeway
{

    self = [super init];
    if (self) {
        _interval = interval;
        _leeway   = leeway;

        _dispatchQueue       = dispatch_queue_create("com.signalenvelope.RACDispatchTimer", 0);
        _dispatchSource      = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, _dispatchQueue);
        _dispatchSourceState = SEDispatchSourceState_Suspended;

        dispatch_source_set_timer(_dispatchSource, dispatch_walltime(NULL, 0), interval, leeway);

        @weakify(self);

        dispatch_source_set_event_handler(_dispatchSource, ^{
            @strongify(self);
            [self execute:[NSDate date]];
		});

        dispatch_source_set_cancel_handler(_dispatchSource, ^{
            @strongify(self);
            [self handleCancellation];
        });
        
        RAC(self.isActive)   = [RACAbleWithStart(self.dispatchSourceState)
                                    map:^id (NSNumber *dispatchSourceState) {

                                        switch ((SEDispatchSourceState)dispatchSourceState.unsignedIntegerValue)
                                        {
                                            case SEDispatchSourceState_Canceled:
                                            case SEDispatchSourceState_Suspended:
                                                return @NO;

                                            case SEDispatchSourceState_Resumed:
                                                return @YES;
                                        }
                                    }];

        RAC(self.isCanceled)  = [RACAbleWithStart(self.dispatchSourceState)
                                    map:^id (NSNumber *dispatchSourceState) {

                                        switch ((SEDispatchSourceState)dispatchSourceState.unsignedIntegerValue)
                                        {
                                            case SEDispatchSourceState_Canceled:
                                                return @YES;

                                            case SEDispatchSourceState_Suspended:
                                            case SEDispatchSourceState_Resumed:
                                                return @NO;
                                        }
                                    }];
        
    }
    return self;
}

- (void) execute:(NSDate *)date {
    [self sendNext:date];
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



/**
 * #### start
 *
 * @return {void}
 */

- (void) start
{
    @synchronized (self)
    {
        switch (self.dispatchSourceState)
        {
            case SEDispatchSourceState_Suspended:
                dispatch_resume(self.dispatchSource);
                break;

            case SEDispatchSourceState_Canceled:
                yssert(NO, @"Canceled RACDispatchTimer was told to -start.");
                break; // @@TODO: throw exception?

            case SEDispatchSourceState_Resumed:
                break; // no-op.
        }

        self.dispatchSourceState = SEDispatchSourceState_Resumed;
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
        switch (self.dispatchSourceState)
        {
            case SEDispatchSourceState_Resumed:
                dispatch_suspend(self.dispatchSource);
                break;

            case SEDispatchSourceState_Canceled:
                break; // @@TODO: throw exception?

            case SEDispatchSourceState_Suspended:
                break; // no-op.
        }

        self.dispatchSourceState = SEDispatchSourceState_Suspended;
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
        if (self.dispatchSource != nil)
        {
            switch (self.dispatchSourceState)
            {
                case SEDispatchSourceState_Suspended:
                    dispatch_resume(self.dispatchSource);

                // ** intentional fall through ** //

                case SEDispatchSourceState_Resumed:
                    dispatch_source_cancel(self.dispatchSource);
                    break;

                case SEDispatchSourceState_Canceled:
                    break;
            }
        }

        self.dispatchSourceState = SEDispatchSourceState_Canceled;
    }
}



/**
 * #### handleCancellation
 *
 * @return {void}
 */

- (void) handleCancellation {

    @synchronized (self)
    {
        if (self.dispatchSource != nil) {
            dispatch_release(self.dispatchSource);
            self.dispatchSource = nil;
        }

        if (self.dispatchQueue != nil) {
            dispatch_release(self.dispatchQueue);
            self.dispatchQueue = nil;
        }
    }
}

@end







