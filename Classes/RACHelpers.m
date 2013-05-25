//
//  RACHelpers.m
//  BrynKit-RACHelpers
//
//  Created by bryn austin bellomy on 3.13.13.
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACSignal+Private.h>
#import <ReactiveCocoa/RACEventTrampoline.h>
#import <libextobjc/EXTScope.h>
#import <objc/runtime.h>

#import "RACHelpers.h"
#import "BrynKit.h"



@implementation RACSignal (BrynKit)

- (RACSignal *) onMainThreadScheduler
{
    return [self deliverOn:[RACScheduler mainThreadScheduler]];
}

- (RACDisposable *)then:(void (^)(void))completedBlock
{
	yssert_notNull(completedBlock);

	RACSubscriber *o = [RACSubscriber subscriberWithNext:NULL error:NULL completed:completedBlock];
	return [self subscribe:o];
}

@end



#pragma mark-
#pragma mark-

@implementation RACEventTrampoline (BrynKit)

+ (instancetype) trampolineForGestureRecognizer:(UIGestureRecognizer *)recognizer
{
	RACEventTrampoline *trampoline = $new(self);
	[recognizer addTarget:trampoline action:@selector(didGetGestureEvent:)];
	return trampoline;
}

- (void) didGetGestureEvent:(UITapGestureRecognizer *)sender
{
	[self.subject sendNext:sender];
}

@end



@implementation UIGestureRecognizer (BrynKit_RAC)

- (RACSignal *) rac_signalForGestures
{
	RACEventTrampoline *trampoline = [RACEventTrampoline trampolineForGestureRecognizer:self];
	[trampoline.subject setNameWithFormat:@"%@ -rac_signalForGestures", self];

	NSMutableSet *controlEventTrampolines = objc_getAssociatedObject(self, RACEventTrampolinesKey);
	if (controlEventTrampolines == nil) {
		controlEventTrampolines = [NSMutableSet set];
		objc_setAssociatedObject(self, RACEventTrampolinesKey, controlEventTrampolines, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	}

	[controlEventTrampolines addObject:trampoline];

	return trampoline.subject;
}

@end




#pragma mark- RACScheduler (BrynKit)
#pragma mark-

@implementation RACScheduler (BrynKit)

+ (RACDisposable *) onMainThread:(dispatch_block_t)block
{
    return [[self mainThreadScheduler] schedule:block];
}

@end

@implementation RACQueueScheduler (BrynKit_RACHelpers)

+ (instancetype) schedulerForQueue: (dispatch_queue_t)queue
{
    const char *label = dispatch_queue_get_label(queue);
    return [[self alloc] initWithName: $str(@"%s", label)
                          targetQueue: queue];
}

@end



#pragma mark- RACSubject (BrynKit_RACHelpers)
#pragma mark-

@implementation RACSubject (BrynKit_RACHelpers)

- (void) sendUnit
{
    [self sendNext: RACDefaultUnit];
}

- (void) sendUnitAndComplete
{
    [self sendUnit];
    [self sendCompleted];
}

@end



@implementation RACStream (BrynKit_RACHelpers)

- (instancetype) notNil
{
    return [[self filter:^BOOL(id value) {
        return (value != nil);
    }] setNameWithFormat:@"[%@] -notNil", self.name];
}

- (instancetype) notNilOrRACTupleNil
{
    return [[self filter:^BOOL(id value) {
        return (value != RACTupleNil.tupleNil && value != nil);
    }] setNameWithFormat:@"[%@] -notNilOrRACTupleNil", self.name];
}

- (instancetype) notEmpty
{
    return [[self filter: ^BOOL(id collection) {
        yssert([collection respondsToSelector:@selector(count)], @"objects sent to the 'notEmpty' operator must respond to the -count selector.");
        NSUInteger count = [collection count];
        return (count > 0);
    }] setNameWithFormat:@"[%@] -notEmpty", self.name];
}

- (instancetype) filterGreaterThanZero
{
    return [[self filter:^BOOL(NSNumber *value) {
        yssert([value isKindOfClass:[NSNumber class]], @"Signals sent to -[RACSignal filterGreaterThanZero] must send values that are NSNumbers.");
        return ([value compare: @0] == NSOrderedDescending);
    }] setNameWithFormat:@"[%@] -filterGreaterThanZero", self.name];
}

- (instancetype) filterZeroOrGreater
{
    return [[self filter:^BOOL(NSNumber *value) {
        yssert([value isKindOfClass:[NSNumber class]], @"Signals sent to -[RACSignal filterGreaterThanZero] must send values that are NSNumbers.");
        NSComparisonResult comparison = [value compare: @0];
        return (comparison == NSOrderedDescending) || (comparison == NSOrderedSame);
    }] setNameWithFormat:@"[%@] -filterGreaterThanZero", self.name];
}

- (instancetype) assertIsKindOfClass:(Class)klass
{
    return [[self map:^id (id value) {
        yssert(value == nil || [value isKindOfClass:klass], @"Signal <%@> sent an object of class %@.  It must instead send objects of class %@.", self.name, NSStringFromClass([value class]), NSStringFromClass(klass));
        return value;
    }] setNameWithFormat:@"[%@] -assertNotNilAndIsKindOfClass: %@", self.name, NSStringFromClass(klass)];
}

- (instancetype) assertNotNilAndIsKindOfClass:(Class)klass
{
	Class class = self.class;

    return [[self flattenMap:^(id value) {
        yssert_notNilAndIsClass(value, klass);
		return [class return:value];
    }] setNameWithFormat:@"[%@] -assertNotNilAndIsKindOfClass: %@", self.name, NSStringFromClass(klass)];
}

- (instancetype) mapFromFloat32:(id (^)(Float32 value))block
{
	NSParameterAssert(block != nil);

	Class class = self.class;

	return [[self flattenMap:^(NSNumber *valueObj) {
        Float32 value = [valueObj floatValue];
		return [class return:block(value)];
	}] setNameWithFormat:@"[%@] -mapFromFloat32:", self.name];
}

- (instancetype) mapFromFloat64:(id (^)(Float64 value))block
{
	NSParameterAssert(block != nil);

	Class class = self.class;

	return [[self flattenMap:^(NSNumber *valueObj) {
        Float64 value = [valueObj floatValue];
		return [class return:block(value)];
	}] setNameWithFormat:@"[%@] -mapFromFloat32:", self.name];
}

- (instancetype) mapFromInteger:(id (^)(NSInteger value))block
{
	NSParameterAssert(block != nil);

	Class class = self.class;

	return [[self flattenMap:^(NSNumber *valueObj) {
        NSInteger value = [valueObj integerValue];
		return [class return:block(value)];
	}] setNameWithFormat:@"[%@] -mapFromInteger:", self.name];
}

- (instancetype) mapFromUnsignedInteger:(id (^)(NSUInteger value))block
{
	NSParameterAssert(block != nil);

	Class class = self.class;

	return [[self flattenMap:^(NSNumber *valueObj) {
        NSUInteger value = [valueObj integerValue];
		return [class return:block(value)];
	}] setNameWithFormat:@"[%@] -mapFromUnsignedInteger:", self.name];
}

- (instancetype) mapFromBool:(id (^)(BOOL value))block
{
	NSParameterAssert(block != nil);

	Class class = self.class;

	return [[self flattenMap:^(NSNumber *valueObj) {
        BOOL value = valueObj.boolValue;
		return [class return:block(value)];
	}] setNameWithFormat:@"[%@] -mapFromBool:", self.name];
}

- (instancetype) mapFromCGRect:(id (^)(CGRect value))block
{
	NSParameterAssert(block != nil);

	Class class = self.class;

	return [[self flattenMap:^(NSValue *valueObj) {
        CGRect value = valueObj.CGRectValue;
		return [class return:block(value)];
	}] setNameWithFormat:@"[%@] -mapFromCGRect:", self.name];
}

- (instancetype) pluck:(NSString *)key
{
    return [[self map:^id(id obj) {
        return [obj valueForKey:key];
    }] setNameWithFormat:@"[%@] -pluck: %@", self.name, key];
}



@end




@implementation RACSignal (BrynKit_RACHelpers_BetterLogging)

- (instancetype) lllogAll
{
	return [[[self lllogNext] lllogError] lllogCompleted];
}

- (instancetype) lllogNext
{
	return [[self doNext:^(id x) {
		NSLog(COLOR_GREEN(@"%@ next: %@"), self, x);
	}] setNameWithFormat:@"%@", self.name];
}

- (instancetype) lllogError
{
	return [[self doError:^(NSError *error) {
		NSLog(COLOR_ERROR(@"%@ error: %@"), self, error);
	}] setNameWithFormat:@"%@", self.name];
}

- (instancetype) lllogCompleted
{
	return [[self doCompleted:^{
		NSLog(COLOR_PURPLE(@"%@ completed"), self);
	}] setNameWithFormat:@"%@", self.name];
}

@end



@implementation NSObject (BrynKit_RACHelpers)

- (BOOL) isNotNilAndNotRACTupleNil
{
    return (self != nil) && (self != RACTupleNil.tupleNil);
}

@end






