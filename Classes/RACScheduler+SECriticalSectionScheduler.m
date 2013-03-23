//
//  RACScheduler+SECriticalSectionScheduler.m
//  Stan
//
//  Created by bryn austin bellomy on 3.12.13.
//  Copyright (c) 2013 robot bubble bath LLC. All rights reserved.
//

#import <BrynKit/BrynKit.h>
#import <BrynKit/GCDThreadsafe.h>
#import <ReactiveCocoa/RACQueueScheduler.h>
#import "RACScheduler+SECriticalSectionScheduler.h"

@implementation RACScheduler (SECriticalSectionScheduler)

+ (RACScheduler *) rac_criticalSectionSchedulerFor:(id<GCDThreadsafe>)object {

    yssert(object != nil, @"object is nil.");
    yssert(object.queueCritical != nil, @"object.queueCritical is nil.");

    return [[RACQueueScheduler alloc] initWithName: @"com.signalenvelope.RACScheduler.criticalSectionScheduler"
                                       targetQueue: object.queueCritical];

}

@end
