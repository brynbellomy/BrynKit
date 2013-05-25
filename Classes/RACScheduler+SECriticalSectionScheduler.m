//
//  RACScheduler+SECriticalSectionScheduler.m
//  Stan
//
//  Created by bryn austin bellomy on 3.12.13.
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//

#import <ReactiveCocoa/RACQueueScheduler.h>
#import "BrynKit.h"
#import "GCDThreadsafe.h"
#import "RACScheduler+SECriticalSectionScheduler.h"

@implementation RACScheduler (SECriticalSectionScheduler)

+ (RACScheduler *) rac_criticalSectionSchedulerFor:(NSObject<GCDThreadsafe> *)object
{
    yssert_notNilAndConformsToProtocol(object, GCDThreadsafe);
    yssert_notNil(object.queueCritical);


    return [[RACQueueScheduler alloc] initWithName: @"com.signalenvelope.RACScheduler.criticalSectionScheduler"
                                       targetQueue: object.queueCritical];

}

@end
