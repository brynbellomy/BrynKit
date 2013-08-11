//
//  RACScheduler+SECriticalSectionScheduler.m
//  BrynKit
//
//  Created by bryn austin bellomy on 3.12.13.
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//

#import <ReactiveCocoa/RACTargetQueueScheduler.h>
#import <GCDThreadsafe/GCDThreadsafe.h>

#import "Bryn.h"
#import "BrynKitDebugging.h"
#import "BrynKitLogging.h"

#import "RACScheduler+SECriticalSectionScheduler.h"

@implementation RACScheduler (SECriticalSectionScheduler)

+ (RACScheduler *) rac_criticalSectionSchedulerFor:(NSObject<GCDThreadsafe> *)object
{
    yssert_notNilAndConformsToProtocol( object, GCDThreadsafe );
    yssert_notNil( object.queueCritical );

    return [[RACTargetQueueScheduler alloc] initWithName: @"com.signalenvelope.RACScheduler.criticalSectionScheduler"
                                             targetQueue: object.queueCritical];

}

@end




