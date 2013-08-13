//
//  NSDictionary+BrynKit.m
//  BrynKit
//
//  Created by bryn austin bellomy on 8.2.13.
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//

#import <libextobjc/EXTScope.h>

#import "NSDictionary+BrynKit.h"
#import "BrynKitDebugging.h"
#import "NSArray+BrynKit.h"



@implementation NSDictionary (BrynKit)

- (NSDictionary *) bk_remapKeys:(BKRemapBlock)block
{
    yssert_notNil( block );

    __block NSMutableDictionary *dict = @{}.mutableCopy;
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        id newVal = block( key, obj );
        dict[ key ] = newVal;
    }];

    return [NSDictionary dictionaryWithDictionary: dict];
}



- (NSArray *) bk_sortedKeysByComparingSubkey:(NSString *)subkey
{
    @weakify(self);
    return [[self allKeys] bk_sort:^NSComparisonResult(id key1, id key2) {
        @strongify(self);

        id<BKComparable> key1SubkeyValue = [self[ key1 ] valueForKey:subkey];
        id<BKComparable> key2SubkeyValue = [self[ key2 ] valueForKey:subkey];

        yssert_notNilAndRespondsToSelector(key1SubkeyValue, compare:);
        yssert_notNilAndRespondsToSelector(key2SubkeyValue, compare:);

        return [key1SubkeyValue compare:key2SubkeyValue];
    }];
}


@end





