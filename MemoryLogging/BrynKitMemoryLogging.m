//
//  BrynKitMemoryLogging.m
//  BrynKit
//
//  Created by bryn austin bellomy on 2.27.2013
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//

//#import <mach/mach.h>
//#import "BrynKit-Main.h"
//#import "BrynKitMemoryLogging.h"
//
///**
// * # Memory logging helpers
// */
//
///**
// * #### BKGetFreeMemory()
// *
// * Returns the amount of free memory on the device.
// *
// * @return {natural_t} The amount of free memory in bytes.
// */
//natural_t BKGetFreeMemory()
//{
//    mach_port_t host_port;
//    mach_msg_type_number_t host_size;
//    vm_size_t pagesize;
//    host_port = mach_host_self();
//    host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
//    host_page_size(host_port, &pagesize);
//    vm_statistics_data_t vm_stat;
//    if (host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size) != KERN_SUCCESS) {
//        NSLog(@"%@", COLOR_ERROR(@"Failed to fetch vm statistics"));
//        return 0;
//    }
//    /* Stats in bytes */
//    natural_t mem_free = vm_stat.free_count * pagesize;
//    return mem_free;
//}
//
//
//
///**
// * @function BKStartOccasionalMemoryLog
// *
// * @abstract
// * Starts a GCD timer that barfs to the console the amount of memory
// * currently available on the device every so often.
// *
// * @param intervalInSeconds
// *
// * @param dispatchTheLog
// *
// * @return
// * The SEDispatchSource object wrapping the GCD timer that fires the memory alerts.
// */
//
//SEDispatchSource* BKStartOccasionalMemoryLog(Float32 intervalInSeconds, BKMemoryLogDispatchBlock dispatchTheLog)
//{
//    SEDispatchSource  *timer = nil;
//
//#if DEBUG
//
//    //
//    // create our timer source
//    //
//    dispatch_queue_t   queue  = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);          yssert_notNil(queue);
//    dispatch_source_t  source = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);        yssert_notNil(queue);
//
//    uint64_t intervalInNanoseconds = (uint64_t)(intervalInSeconds * NSEC_PER_SEC);
//    dispatch_source_set_timer(source,
//                              dispatch_time(DISPATCH_TIME_NOW, intervalInNanoseconds),
//                              intervalInNanoseconds,
//                              intervalInNanoseconds);
//
//    //
//    // provide a default log-dispatching block in case the user can't be bothered
//    //
//    if ( !dispatchTheLog )
//    {
//        dispatchTheLog = ^(natural_t freeMemBytes) {
//            NSString *memoryReadout    = $str(@"%.3fmb free", (Float32)(freeMemBytes / (1024 * 1024)));
//            NSString *logMessagePrefix = $str(@"[ BrynKit.OccasionalMemoryLog ] = %@", memoryReadout);
//            NSLog(@"%@ Current available device memory: %@", logMessagePrefix, memoryReadout);
//        };
//    }
//
////    timer = [SEDispatchSource dispatchSourceWithSource:source onQueue:queue];
//
//    timer.handler = ^{
//        natural_t freeMemBytes = BKGetFreeMemory();
//        dispatchTheLog(freeMemBytes);
//    };
//
//    yssert_notNilAndIsClass( timer, SEDispatchSource );
//
//    //
//    // now that our timer is all set to go, start it
//    //
//    [timer resume];
//
//
//#endif
//
//    return timer;
//}




