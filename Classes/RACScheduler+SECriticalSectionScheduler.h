//
//  RACScheduler+SECriticalSectionScheduler.h
//  Stan
//
//  Created by bryn austin bellomy on 3.12.13.
//  Copyright (c) 2013 robot bubble bath LLC. All rights reserved.
//

#import "GCDThreadsafe.h"
#import "RACScheduler.h"

@interface RACScheduler (SECriticalSectionScheduler)

+ (RACScheduler *) rac_criticalSectionSchedulerFor:(NSObject<GCDThreadsafe> *)object;

@end
