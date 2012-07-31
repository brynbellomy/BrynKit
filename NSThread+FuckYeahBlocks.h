//
//  NSThread+FuckYeahBlocks.h
//  Bryn.h
//
//  Created by bryn austin bellomy on 7/29/12.
//  Copyright (c) 2012 robot bubble bath LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSThread (FuckYeahBlocks)

+ (void) FuckYeah_performBlockOnMainThread: (dispatch_block_t)block;
+ (void) FuckYeah_performBlockInBackground: (dispatch_block_t)block;
+ (void) FuckYeah_runBlock: (dispatch_block_t)block;
- (void) FuckYeah_performBlock:(dispatch_block_t)block;
- (void) FuckYeah_performBlock: (dispatch_block_t)block waitUntilDone: (BOOL)wait;
- (void) FuckYeah_performBlock: (dispatch_block_t)block afterDelay: (NSTimeInterval)delay;

@end




