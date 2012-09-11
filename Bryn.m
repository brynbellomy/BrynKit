//
//  Bryn.m  
//  BrynKit  
//  
//  Created by bryn austin bellomy on 7/29/12.  
//  Copyright (c) 2012 robot bubble bath LLC. All rights reserved.
//

#import "Bryn.h"

#if MB_PROGRESS_HUD_INCLUDED == 1
void BrynShowMBProgressHUD(UIView *onView, SetupHUDBlock block_setupHUD, dispatch_block_t block_afterShowingHUD) {
  dispatch_queue_t q = dispatch_queue_create("com.brynkit.SetupHUDQueue", 0);
  dispatch_set_target_queue(q, dispatch_get_main_queue());
  
  dispatch_async(q, ^{
    if (onView == nil)
      return;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:onView animated:YES];
    block_setupHUD(hud);
  });
  
  dispatch_async(q, block_afterShowingHUD);
  dispatch_release(q);
}
#endif


/**
 * # Objective-c literals on iOS < 6
 */

#ifndef __IPHONE_6_0 

@implementation NSArray (Indexing)

- (id)objectAtIndexedSubscript:(NSUInteger)idx {
  return [self objectAtIndex:idx];
}

@end



@implementation NSMutableArray (Indexing)

- (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)idx {
  [self replaceObjectAtIndex:idx withObject:obj];
}

@end



@implementation  NSDictionary (Indexing)

- (id)objectForKeyedSubscript:(id)key {
  return [self objectForKey:key];
}

@end



@implementation  NSMutableDictionary (Indexing)

- (void)setObject:(id)obj forKeyedSubscript:(id)key {
  [self setObject:obj forKey:key];
}

@end



#endif



