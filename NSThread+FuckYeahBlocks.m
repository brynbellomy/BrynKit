//
//  NSThread+FuckYeahBlocks.m
//  Bryn.h
//
//  Created by bryn austin bellomy on 7/29/12.
//  Copyright (c) 2012 robot bubble bath LLC. All rights reserved.
//

#import "NSThread+FuckYeahBlocks.h"

@implementation NSThread (FuckYeahBlocks)

+ (void) FuckYeah_performBlockOnMainThread: (dispatch_block_t)block {
	[[NSThread mainThread] FuckYeah_performBlock:[block copy]];
}



+ (void) FuckYeah_performBlockInBackground: (dispatch_block_t)block {
	[NSThread performSelectorInBackground: @selector(FuckYeah_runBlock:)
                             withObject: [block copy]];
}



+ (void) FuckYeah_runBlock: (dispatch_block_t)block {
  BrynFnLog(@"beginning FuckYeah_runBlock");
  NSAssert(block != nil, @"block argument is nil.");
	block();
  BrynFnLog(@"end of FuckYeah_runBlock");
}



- (void) FuckYeah_performBlock:(dispatch_block_t)block {
	if ([[NSThread currentThread] isEqual:self])
    block();
	else
    [self FuckYeah_performBlock:[block copy] waitUntilDone:NO];
}



- (void) FuckYeah_performBlock: (dispatch_block_t)block
                 waitUntilDone: (BOOL)wait {
  
	[NSThread performSelector: @selector(FuckYeah_runBlock:)
                   onThread: self
                 withObject: [block copy]
              waitUntilDone: wait];
}



- (void) FuckYeah_performBlock: (dispatch_block_t)block
                    afterDelay: (NSTimeInterval)delay {
  
	[self performSelector: @selector(FuckYeah_performBlock:)
             withObject: [block copy]
             afterDelay: delay];
}

@end
