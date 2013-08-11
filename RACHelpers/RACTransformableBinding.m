////
////  RACTransformableBinding.m
////  BrynKit
////
////  Created by bryn austin bellomy on 7/18/12.
////  Copyright (c) 2012 bryn austin bellomy. All rights reserved.
////
//
//#import "Bryn.h"
//#import "BrynKitLogging.h"
//#import "BrynKitDebugging.h"
//#import "RACHelpers.h"
//
//#import "RACTransformableBinding.h"
//#import <ReactiveCocoa/ReactiveCocoa.h>
//#import <ReactiveCocoa/RACBinding+Private.h>
//#import <libextobjc/EXTScope.h>
//#import <ReactiveCocoa/NSObject+RACDescription.h>
//#import <ReactiveCocoa/NSString+RACKeyPathUtilities.h>
//#import <ReactiveCocoa/RACKVOTrampoline.h>
//#import <ReactiveCocoa/RACSignal+Private.h>
//#import <ReactiveCocoa/RACSwizzling.h>
//
//
//// Name of exceptions thrown by RACKVOBinding when an object calls
//// -didChangeValueForKey: without a corresponding -willChangeValueForKey:.
//BKDefineStringKey(RACKVOTransformableBindingExceptionName, @"RACKVOTransformableBinding exception");
//
//// Name of the key associated with the instance that threw the exception in the
//// userInfo dictionary in exceptions thrown by RACKVOBinding, if applicable.
//BKDefineStringKey(RACKVOTransformableBindingExceptionBindingKey);
//
//
//
//@implementation RACTransformableBinding
//
//#pragma mark RACSignal
//
//- (RACDisposable *)subscribe:(id<RACSubscriber>)subscriber {
//	return [self.exposedSignal subscribe:subscriber];
//}
//
//#pragma mark <RACSubscriber>
//
//- (void)sendNext:(id)value {
//	[self.exposedSubscriberSubject sendNext:value];
//}
//
//- (void)sendError:(NSError *)error {
//	[self.exposedSubscriberSubject sendError:error];
//}
//
//- (void)sendCompleted {
//	[self.exposedSubscriberSubject sendCompleted];
//}
//
//- (void)didSubscribeWithDisposable:(RACDisposable *)disposable {
//	[self.exposedSubscriberSubject didSubscribeWithDisposable:disposable];
//}
//
//#pragma mark API
//
//+ (instancetype)bindingWithTarget: (id)target
//                          keyPath: (NSString *)keyPath
//                        transform: (id(^)(id))transform
//{
//	RACTransformableBinding *binding = [[self alloc] init];
//	if (binding == nil) return nil;
//
//	@weakify(binding);
//    binding->_transform = [transform copy];
//	binding->_target = target;
//	binding->_keyPath = [keyPath copy];
//
//	binding->_exposedSignal = [[RACSignal createSignal:^(id<RACSubscriber> subscriber) {
//		@strongify(binding);
//		[subscriber sendNext:[binding.target valueForKeyPath:binding.keyPath]];
//		return [binding.exposedSignalSubject subscribe:subscriber];
//	}] setNameWithFormat:@"[+propertyWithTarget: %@ keyPath: %@] -binding", [target rac_description], keyPath];
//
//	binding->_exposedSignalSubject = [RACSubject subject];
////	[[[binding->_exposedSignalSubject setNameWithFormat: COLOR_BLUE(@"%@ / exposed signal subject"), binding->_exposedSignal.name] lllogAll] subscribeNext:^(id x) {}];
//
//	binding->_exposedSubscriberSubject = [RACSubject subject];
////	[[[binding->_exposedSubscriberSubject setNameWithFormat: COLOR_YELLOW(@"%@ / exposed subscriber subject"), binding->_exposedSignal.name] lllogAll] subscribeNext:^(id x) {}];
//
//	[binding->_exposedSubscriberSubject subscribeNext:^(id x) {
//		@strongify(binding);
//		if (binding.keyPath.rac_keyPathComponents.count > 1 && [binding.target valueForKeyPath:binding.keyPath.rac_keyPathByDeletingLastKeyPathComponent] == nil)
//        {
//			return;
//		}
//
//		binding.ignoreNextUpdate = YES;
//		[binding.target setValue:x forKeyPath:binding.keyPath];
//	}];
//
//	binding->_observer = [target rac_addObserver:binding forKeyPath:keyPath options:NSKeyValueObservingOptionPrior block:^(id target, id observer, NSDictionary *change) {
//		@strongify(binding);
//		if ([change[ NSKeyValueChangeNotificationIsPriorKey ] boolValue])
//        {
//			[binding targetWillChangeValue];
//		}
//        else
//        {
//			[binding targetDidChangeValue];
//		}
//	}];
//
//	[target rac_addDeallocDisposable:[RACDisposable disposableWithBlock:^{
//		@strongify(binding);
//		[binding dispose];
//	}]];
//
//	return binding;
//}
//
//- (void)targetWillChangeValue {
//	++self.stackDepth;
//}
//
//- (void)targetDidChangeValue {
//	--self.stackDepth;
//	if (self.stackDepth == NSUIntegerMax) @throw [NSException exceptionWithName:RACKVOTransformableBindingExceptionName reason:@"Receiver called -didChangeValueForKey: without corresponding -willChangeValueForKey:" userInfo:@{ RACKVOTransformableBindingExceptionBindingKey : self }];
//	if (self.stackDepth != 0) return;
//	if (self.ignoreNextUpdate) {
//		self.ignoreNextUpdate = NO;
//		return;
//	}
//	__strong id value = [self.target valueForKeyPath:self.keyPath];
//    if (self.transform != nil)
//    {
//        __strong id _value = self.transform(value);
//        value = _value;
//    }
//	[self.exposedSignalSubject sendNext:value];
//}
//
//- (void)dispose {
//	self.target = nil;
//
//	@synchronized(self) {
//		if (self.disposed) return;
//		self.disposed = YES;
//		[self.exposedSignalSubject sendCompleted];
//		[self.exposedSubscriberSubject sendCompleted];
//		[self.observer stopObserving];
//	}
//}
//
//@end
