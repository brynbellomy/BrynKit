//
//  SEDispatchSource.h
//  BrynKit
//
//  Created by bryn austin bellomy on 1/18/13.
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//

#import "BrynKit.h"

typedef enum : NSUInteger {
    SEDispatchSourceState_Suspended = 1,
    SEDispatchSourceState_Resumed   = 2,
    SEDispatchSourceState_Canceled  = 3
} SEDispatchSourceState;

@interface SEDispatchSource : NSObject

@property (atomic, dispatch_strong, readonly) dispatch_source_t     source;
@property (atomic, dispatch_strong, readonly) dispatch_queue_t      queue;
@property (atomic, dispatch_strong, readonly) dispatch_block_t      handler, cancelation;

@property (nonatomic, assign, readonly) SEDispatchSourceState state;
@property (nonatomic, assign, readonly) BOOL isActive;
@property (nonatomic, assign, readonly) BOOL isCanceled;

- (instancetype) initWithSource:(dispatch_source_t)source onQueue:(dispatch_queue_t)queue handler:(dispatch_block_t)handler cancelation:(dispatch_block_t)cancelation;
- (void) stop;
- (void) resume;
- (void) cancel;

@end




