////
////  RACTransformableBinding.h
////  BrynKit
////
////  Created by bryn austin bellomy on 7/18/12.
////  Copyright (c) 2012 bryn austin bellomy. All rights reserved.
////
//
//#import <ReactiveCocoa/ReactiveCocoa.h>
//#import <ReactiveCocoa/RACKVOTrampoline.h>
//
//// A binding to a KVO compliant key path on an object.
//@interface RACTransformableBinding : RACBinding
//
//// Create a new binding for `keyPath` on `target`.
//+ (instancetype)bindingWithTarget:(id)target keyPath:(NSString *)keyPath transform: (id(^)(id))transform;
//
//@property (nonatomic, strong, readwrite) id(^transform)(id obj);
//
//// The object whose key path the binding is wrapping.
//@property (atomic, unsafe_unretained) id target;
//
//// The key path the binding is wrapping.
//@property (nonatomic, readonly, copy) NSString *keyPath;
//
//// The signal exposed to callers. The binding will behave like this signal
//// towards it's subscribers.
//@property (nonatomic, readonly, strong) RACSignal *exposedSignal;
//
//// The backing subject for the binding's outgoing changes. Any time the value of
//// the key path the binding is wrapping is changed, the new value is sent to
//// this subject.
//@property (nonatomic, readonly, strong) RACSubject *exposedSignalSubject;
//
//// The backing subject for the binding's incoming changes. Any time a value is
//// sent to this subject, the key path the binding is wrapping is set to
//// that value.
//@property (nonatomic, readonly, strong) RACSubject *exposedSubscriberSubject;
//
//// The identifier of the internal KVO observer.
//@property (nonatomic, readonly, strong) RACKVOTrampoline *observer;
//
//// Whether the binding has been disposed or not. Should only be accessed while
//// synchronized on self.
//@property (nonatomic, getter = isDisposed) BOOL disposed;
//
//// Current depth of the willChangeValueForKey:/didChangeValueForKey: call stack.
//@property (nonatomic) NSUInteger stackDepth;
//
//// Whether the next change of the property that occurs while `stackDepth` is 0
//// should be ignored.
//@property (nonatomic) BOOL ignoreNextUpdate;
//
//// This method is called when the `target`'s `keyPath` will change.
//- (void)targetWillChangeValue;
//
//// This method is called when the `target`'s `keyPath` did change.
//- (void)targetDidChangeValue;
//
//// Dispose the binding, removing it from the `target`. Also terminates all
//// subscriptions to and by the binding.
//- (void)dispose;
//
//@end
