////
////  RACDispatchTimer.m
////  RACDispatchTimer
////
////  Created by bryn austin bellomy on 3.3.13.
////  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
////
//
//#import <ReactiveCocoa/ReactiveCocoa.h>
//#import <ReactiveCocoa/RACSignal+Private.h>
//#import <libextobjc/EXTScope.h>
//
//#import "Bryn.h"
//#import "BrynKitDebugging.h"
//#import "BrynKitLogging.h"
//
//#import <GCDThreadsafe/GCDThreadsafe.h>
//#import "RACHelpers.h"
//#import "RACDispatchTimer.h"
//#import "SEDispatchSource.h"
//
//@interface RACDispatchTimer ()
//    @property (nonatomic, strong, readwrite) SEDispatchSource *dispatchSource;
//
//    @property (nonatomic, strong, readonly)  RACCompoundDisposable *disposable;
//
//    @property (nonatomic, assign, readwrite) uint64_t interval;
//    @property (nonatomic, assign, readwrite) uint64_t leeway;
//    @property (nonatomic, assign, readwrite) SEDispatchSourceState state;
//    @property (nonatomic, assign, readwrite) BOOL isActive;
//    @property (nonatomic, assign, readwrite) BOOL isCanceled;
//    @property (nonatomic, assign, readwrite) BOOL isQueueSuspended;
//@end
//
//@implementation RACDispatchTimer {}
//
//#pragma mark- Lifecycle
//#pragma mark-
//
//+ (instancetype) timerWithIntervalInNanoseconds:(uint64_t)interval
//                                         leeway:(uint64_t)leeway
//{
//    return [[self alloc] initWithIntervalInNanoseconds:interval leeway:leeway];
//}
//
//
//
//- (instancetype) initWithIntervalInNanoseconds:(uint64_t)interval
//                                        leeway:(uint64_t)leeway
//{
//
//    self = [super init];
//    if (self)
//    {
//        _disposable = [RACCompoundDisposable compoundDisposable];
//
//        _interval = interval;
//        _leeway   = leeway;
//
//        @weakify(self);
//
//        {
//            dispatch_queue_t queue = dispatch_queue_create( "com.signalenvelope.RACDispatchTimer", DISPATCH_QUEUE_SERIAL );
//            BKInitializeQueue( queue );
//
//            SEDispatchSource *dispatchSource = [SEDispatchSource dispatchSourceWithType:DISPATCH_SOURCE_TYPE_TIMER
//                                                                                 handle:0 mask:0
//                                                                                  queue:queue];
//
//            bk_dispatch_release( queue );
//
//            dispatch_source_set_timer( dispatchSource.source, dispatch_walltime( NULL, 0 ), _interval, _leeway );
//
//            dispatchSource.handler      = ^{ @strongify(self); [self execute:[NSDate date]]; };
//            dispatchSource.registration = ^{};
//            dispatchSource.cancelation  = ^{ @strongify(self); [self handleCancellation]; };
//            
//            _dispatchSource = dispatchSource;
//        }
//
//        [self initializeReactiveKVO];
//    }
//    return self;
//}
//
//
//
//- (void) initializeReactiveKVO
//{
//    RAC(self.state) = RACObserve(self.dispatchSource, state);
//
//    RAC(self.isActive)   = [RACObserve(self.state)
//                                mapFromUnsignedInteger:^id (SEDispatchSourceState state) {
//
//                                    switch (state)
//                                    {
//                                        case SEDispatchSourceState_Resumed:
//                                            return @YES;
//
//                                        case SEDispatchSourceState_Canceled:
//                                        case SEDispatchSourceState_Suspended:
//                                        default:
//                                            return @NO;
//
//                                    }
//                                }];
//
//    RAC(self.isCanceled)  = [RACObserve(self.state)
//                                mapFromUnsignedInteger:^id(SEDispatchSourceState state) {
//
//                                    switch (state)
//                                    {
//                                        case SEDispatchSourceState_Canceled:
//                                            return @YES;
//
//                                        case SEDispatchSourceState_Suspended:
//                                        case SEDispatchSourceState_Resumed:
//                                        default:
//                                            return @NO;
//                                    }
//                                }];
//
//}
//
//
//
//- (void) dealloc
//{
//	[self.disposable dispose];
//    [self cancel];
//}
//
//
//
//#pragma mark- RACSubscriber
//#pragma mark-
//
//- (void)sendNext:(id)value
//{
//	[self performBlockOnEachSubscriber:^(id<RACSubscriber> subscriber) {
//		[subscriber sendNext:value];
//	}];
//}
//
//- (void)sendError:(NSError *)error {
//	[self.disposable dispose];
//
//	[self performBlockOnEachSubscriber:^(id<RACSubscriber> subscriber) {
//		[subscriber sendError:error];
//	}];
//}
//
//- (void)sendCompleted {
//	[self.disposable dispose];
//
//	[self performBlockOnEachSubscriber:^(id<RACSubscriber> subscriber) {
//		[subscriber sendCompleted];
//	}];
//}
//
//- (void) didSubscribeWithDisposable:(RACDisposable *)d {
//	if (d != nil) [self.disposable addDisposable:d];
//}
//
//
//
//#pragma mark- State changes
//#pragma mark-
//
//- (void) resume
//{
//    @synchronized (self)
//    {
//        [self.dispatchSource resume];
//    }
//}
//
//
//
//- (void) suspend
//{
//    @synchronized (self)
//    {
//        [self.dispatchSource suspend];
//    }
//}
//
//
//
//- (void) cancel
//{
//    @synchronized (self)
//    {
//        [self.dispatchSource cancel];
//    }
//}
//
//
//
//#pragma mark- Doin' work
//#pragma mark-
//
//- (void) execute:(NSDate *)date
//{
//    [self sendNext:date];
//}
//
//
//
//- (void) handleCancellation
//{
//    [self sendCompleted];
//
//    @synchronized (self)
//    {
//        self.dispatchSource = nil;
//    }
//}
//
//@end







