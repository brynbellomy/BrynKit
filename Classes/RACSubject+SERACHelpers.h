//
//  RACSubject+SERACHelpers.h
//  Stan
//
//  Created by bryn austin bellomy on 3.13.13.
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACReplaySubject.h>

@class RACFuture;

#define RACDefaultUnit RACUnit.defaultUnit

typedef void(^RACFutureBlock)(RACFuture *future);



//
// RACFuture
//
// (this will contain more stuff later)
//
@interface RACFuture : RACReplaySubject
@end



@interface RACSubject (SERACHelpers)

- (void) sendUnit;
- (void) sendUnitAndComplete;

- (void) await;
- (void) resolve;

@end



@interface RACStream (SERACHelpers)

- (instancetype) notNil;
- (instancetype) filterGreaterThanZero;
- (instancetype) filterZeroOrGreater;
- (instancetype) assertIsKindOfClass:(Class)klass;
- (instancetype) assertNotNilAndIsKindOfClass:(Class)klass;

@end











