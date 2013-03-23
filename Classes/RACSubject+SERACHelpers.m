//
//  RACSubject+SERACHelpers.m
//  Stan
//
//  Created by bryn austin bellomy on 3.13.13.
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import "RACSubject+SERACHelpers.h"
#import "BrynKit.h"


@implementation RACFuture

@end



@implementation RACSubject (SERACHelpers)

- (void) sendUnit
{
    [self sendNext:RACUnit.defaultUnit];
}

- (void) sendUnitAndComplete
{
    [self sendUnit];
    [self sendCompleted];
}

- (void) await
{
    [self first];
}


//- (RACDisposable *) then: (dispatch_block_t)block
//{
//    return [self subscribeCompleted:block];
//}


- (void) resolve
{
    [self sendUnitAndComplete];
}

@end



@implementation RACSignal (SERACHelpers)

- (instancetype) notNil
{
    return [[self filter:^BOOL(id value) {
        return (value != nil);
    }] setNameWithFormat:@"[%@] -notNil", self.name];
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
        yssert(value == nil || [value isKindOfClass:klass], @"Signal sent an object of class %@.  It must instead send objects of class %@.", NSStringFromClass([value class]), NSStringFromClass(klass));
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






