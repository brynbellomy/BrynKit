//
//  NSObject+GCDThreadsafe.h
//  BrynKit
//
//  Created by bryn austin bellomy on 2.23.13.
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Threadsafe)
    @property (nonatomic, assign, readonly) dispatch_queue_t queueCritical;

    - (void) runCriticalMutableSection:(dispatch_block_t)blockCritical;
    - (void) runCriticalReadonlySection:(dispatch_block_t)blockCritical;
@end
