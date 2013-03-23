//
//  BrynKitMemoryLogging.m
//  BrynKit
//
//  Created by bryn austin bellomy on 2.27.2013
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//

#import <mach/mach.h>
#import <mach/mach_host.h>
#import "BrynKitLogging.h"

/**
 * # Memory logging helpers
 */

/**
 * #### BrynKit_GetFreeMemory()
 *
 * Returns the amount of free memory on the device.
 *
 * @return {natural_t} The amount of free memory in bytes.
 */
natural_t BrynKit_GetFreeMemory()
{
    mach_port_t host_port;
    mach_msg_type_number_t host_size;
    vm_size_t pagesize;
    host_port = mach_host_self();
    host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    host_page_size(host_port, &pagesize);
    vm_statistics_data_t vm_stat;
    if (host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size) != KERN_SUCCESS) {
        BrynFnLog(COLOR_ERROR(@"Failed to fetch vm statistics"));
        return 0;
    }
    /* Stats in bytes */
    natural_t mem_free = vm_stat.free_count * pagesize;
    return mem_free;
}



/**
 * #### BrynKit_StartOccasionalMemoryLog()
 *
 * Starts a GCD timer that spits out the memory currently available on the
 * device every few seconds.
 */
void BrynKit_StartOccasionalMemoryLog()
{
#if DEBUG
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

    // create our timer source
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    NSUInteger step = 3; // 3 seconds
    dispatch_source_set_timer(timer,
                              dispatch_time(DISPATCH_TIME_NOW, step * NSEC_PER_SEC),
                              step * NSEC_PER_SEC,
                              step * NSEC_PER_SEC);

    dispatch_source_set_event_handler(timer, ^{
        natural_t freeMemBytes = BrynKit_GetFreeMemory();
        BrynFnLog(COLOR_OLIVE(@"Free memory: %f"), (double)(freeMemBytes / (1024 * 1024)));
    });

    // now that our timer is all set to go, start it
    dispatch_resume(timer);
#endif
}

