//
//  RACDispatchTimer.m
//  RACDispatchTimer
//
//  Created by bryn austin bellomy on 3.3.13.
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACSignal+Private.h>
#import <libextobjc/EXTScope.h>

#import "Bryn.h"
#import "BrynKitDebugging.h"
#import "BrynKitLogging.h"

#import "RACHelpers.h"
#import "RACDispatchTimer.h"
#import "SEDispatchSource.h"

@interface RACDispatchTimer ()
    @property (nonatomic, strong,          readwrite) SEDispatchSource *dispatchSource;
    @property (nonatomic, dispatch_strong, readwrite) dispatch_source_t source;
    @property (nonatomic, dispatch_strong, readwrite) dispatch_queue_t queue;

    @property (nonatomic, strong, readonly) RACCompoundDisposable *disposable;

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

+ (instancetype) timerWithIntervalInNanoseconds:(uint64_t)interval
                                         leeway:(uint64_t)leeway
{
    return [[self alloc] initWithIntervalInNanoseconds:interval leeway:leeway];
}



- (instancetype) initWithIntervalInNanoseconds:(uint64_t)interval
                                        leeway:(uint64_t)leeway
{

    self = [super init];
    if (self)
    {
        _disposable = [RACCompoundDisposable compoundDisposable];

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
    RAC(self.state) = RACAbleWithStart(self.dispatchSource, state);

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



- (void) dealloc
{
	[self.disposable dispose];
    [self cancel];
}



#pragma mark- RACSubscriber
#pragma mark-

- (void)sendNext:(id)value
{
	[self performBlockOnEachSubscriber:^(id<RACSubscriber> subscriber) {
		[subscriber sendNext:value];
	}];
}

- (void)sendError:(NSError *)error {
	[self.disposable dispose];

	[self performBlockOnEachSubscriber:^(id<RACSubscriber> subscriber) {
		[subscriber sendError:error];
	}];
}

- (void)sendCompleted {
	[self.disposable dispose];

	[self performBlockOnEachSubscriber:^(id<RACSubscriber> subscriber) {
		[subscriber sendCompleted];
	}];
}

- (void) didSubscribeWithDisposable:(RACDisposable *)d {
	if (d != nil) [self.disposable addDisposable:d];
}



#pragma mark- State changes
#pragma mark-

- (void) resume
{
    @synchronized (self)
    {
        [self.dispatchSource resume];
    }
}



- (void) stop
{
    @synchronized (self)
    {
        [self.dispatchSource stop];
    }
}



- (void) cancel
{
    @synchronized (self)
    {
        [self.dispatchSource cancel];
    }
}



#pragma mark- Doin' work
#pragma mark-

- (void) execute:(NSDate *)date
{
    [self sendNext:date];
}



- (void) handleCancellation
{
    [self sendCompleted];

    @synchronized (self)
    {
        self.dispatchSource = nil;
        self.queue          = nil;
        self.source         = nil;
    }
}

@end







