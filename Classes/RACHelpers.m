//
//  RACHelpers.m
//  BrynKit-RACHelpers
//
//  Created by bryn austin bellomy on 3.13.13.
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <libextobjc/EXTScope.h>
#import <RACSignal+Private.h>

#import "RACHelpers.h"
#import "BrynKit.h"



#pragma mark- RACQueueScheduler (BrynKit_RACHelpers)
#pragma mark-

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
    [self sendNext:RACUnit.defaultUnit];
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
    return [[self notNil]
                  filter:^BOOL(id value) {
                      return (value != RACTupleNil.tupleNil);
                  }];
}

- (instancetype) filterGreaterThanZero
{
    return [[self filter:^BOOL(NSNumber *value) {
        yssert([value isKindOfClass:[NSNumber class]], @"Signals sent to -[RACSignal filterGreaterThanZero] must contain values that are NSNumbers.");
        return ([value compare: @0] == NSOrderedDescending);
    }] setNameWithFormat:@"[%@] -filterGreaterThanZero", self.name];
}

- (instancetype) filterZeroOrGreater
{
    return [[self filter:^BOOL(NSNumber *value) {
        yssert([value isKindOfClass:[NSNumber class]], @"Signals sent to -[RACSignal filterGreaterThanZero] must contain values that are NSNumbers.");
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
    return [[self map:^id (id value) {
        yssert_notNilAndIsClass(value, klass);
        return value;
    }] setNameWithFormat:@"[%@] -assertNotNilAndIsKindOfClass: %@", self.name, NSStringFromClass(klass)];
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






