//
//  NSArray+BrynKit.m
//  BrynKit
//
//  Created by bryn austin bellomy on 8.2.13.
//  Copyright (c) 2013 signalenvelope llc. All rights reserved.
//

#import "NSArray+BrynKit.h"



@implementation NSArray (BrynKit)

- (NSSet *) bk_set
{
    return [NSSet setWithArray: self];
}



- (NSOrderedSet *) bk_orderedSet
{
    return [NSOrderedSet orderedSetWithArray: self];
}



- (NSArray *) bk_sort
{
    return [self sortedArrayUsingSelector:@selector(compare:)];
}



- (NSArray *) bk_sortByKey:(NSString *)key
{
    return [self sortedArrayUsingDescriptors: @[ [[NSSortDescriptor alloc] initWithKey:key ascending:YES] ]];
}



- (NSArray *) bk_sort:(NSComparator)comparator
{
    return [self sortedArrayUsingComparator:comparator];
}



@end

