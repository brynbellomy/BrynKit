//
//  RACDispatchTimer.h
//  RACDispatchTimer
//
//  Created by bryn austin bellomy on 3.3.13.
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>

@interface RACDispatchTimer : RACSubject

@property (nonatomic, assign, readonly) uint64_t interval;
@property (nonatomic, assign, readonly) uint64_t leeway;
@property (nonatomic, assign, readonly) BOOL isActive;
@property (nonatomic, assign, readonly) BOOL isCanceled;


+ (instancetype) timerWithIntervalInNanoseconds:(uint64_t)interval leeway:(uint64_t)leeway;
- (instancetype)  initWithIntervalInNanoseconds:(uint64_t)interval leeway:(uint64_t)leeway;

- (void) resume;
- (void) stop;

@end






