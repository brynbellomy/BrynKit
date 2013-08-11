//
//  NSArray+BrynKit.h
//  BrynKit
//
//  Created by bryn austin bellomy on 8.2.13.
//  Copyright (c) 2013 signalenvelope llc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (BrynKit)

- (NSSet *) bk_set;
- (NSOrderedSet *) bk_orderedSet;
- (NSArray *) bk_sort;
- (NSArray *) bk_sortByKey:(NSString *)key;
- (NSArray *) bk_sort:(NSComparator)comparator;


@end
