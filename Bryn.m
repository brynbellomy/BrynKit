//
//  Bryn.m  
//  BrynKit  
//  
//  Created by bryn austin bellomy on 7/29/12.  
//  Copyright (c) 2012 robot bubble bath LLC. All rights reserved.
//

#import "Bryn.h"



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



