//
//  SEDispatchSource.m
//  BrynKit
//
//  Created by bryn austin bellomy on 1/18/13.
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>

#import "Bryn.h"
#import "BrynKitDebugging.h"
#import "BrynKitLogging.h"

#import "RACHelpers.h"
#import "SEDispatchSource.h"

@interface SEDispatchSource ()

@property (atomic, dispatch_strong, readwrite) dispatch_source_t     source;
@property (atomic, dispatch_strong, readwrite) dispatch_queue_t      queue;
@property (atomic, dispatch_strong, readwrite) dispatch_block_t      handler, cancelation;

@property (nonatomic, assign, readwrite) SEDispatchSourceState state;
@property (nonatomic, assign, readwrite) BOOL isActive;
@property (nonatomic, assign, readwrite) BOOL isCanceled;

@end


@implementation SEDispatchSource

/**
 * #### initWithSource:onQueue:
 *
 * @param {dispatch_source_t} source
 * @param {dispatch_queue_t} queue
 */

- (instancetype) initWithSource: (dispatch_source_t)source
                        onQueue: (dispatch_queue_t)queue
                        handler: (dispatch_block_t)handler
                    cancelation: (dispatch_block_t)cancelation
{
    self = [super init];

    if (self)
    {
        yssert(dispatch_source_testcancel(source) == 0, @"Don't pass an already-canceled dispatch_source_t to [SEDispatchSource initWithSource:onQueue:handler:].");

        _queue = queue;
        dispatch_retain(_queue);

        _source = source;
        dispatch_retain(_source);

        _handler = handler;
        if (_handler != nil) {
            dispatch_source_set_event_handler(_source, _handler);
        }

        _cancelation = cancelation;
        if (_cancelation != nil) {
            dispatch_source_set_cancel_handler(_source, _cancelation);
        }

        _state  = SEDispatchSourceState_Suspended;
    }

    return self;
}



/**
 * #### dealloc
 *
 * Automatically cancels the `dispatch_source_t` correctly upon `dealloc`-ing.
 */

- (void) dealloc
{
    [self cancel];
}



- (void) initializeReactiveKVO
{
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
 * #### stop
 */

- (void) stop
{
    @synchronized(self)
    {
        if (self.state == SEDispatchSourceState_Resumed) {
            dispatch_suspend(_source);
            self.state = SEDispatchSourceState_Suspended;
        }
    }
}



/**
 * #### resume
 */

- (void) resume
{
    @synchronized(self)
    {
        if ((_state == SEDispatchSourceState_Suspended) || (_state == SEDispatchSourceState_Canceled)) {
            dispatch_resume(_source);
            _state = SEDispatchSourceState_Resumed;
        }
    }
}



- (void) cancel
{
    @synchronized(self)
    {
        // when cancelling, must make sure we resume first if we're suspended
        if (_state == SEDispatchSourceState_Suspended) {
            dispatch_resume(_source);
        }

        dispatch_source_cancel(_source);
        dispatch_release(_source);
        _source = nil;

        dispatch_release(_queue);
        _queue = nil;

        _state = SEDispatchSourceState_Canceled;
    }
}




@end






