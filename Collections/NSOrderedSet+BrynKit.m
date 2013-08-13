#import "NSArray+BrynKit.h"
#import "NSOrderedSet+BrynKit.h"



@implementation NSOrderedSet (BrynKit)

+ (instancetype) bk_orderedSetWithIntegersInRange:(NSRange)range
{
    NSMutableOrderedSet *set = [NSMutableOrderedSet orderedSetWithCapacity: range.length];
    for (NSUInteger i = range.location; i < range.length; i++) {
        [set addObject: @( i )];
    }
    return [NSOrderedSet orderedSetWithOrderedSet: set];
}



- (instancetype) bk_sort
{
    NSArray *array = [[self array] bk_sort];
    return [[self class] orderedSetWithArray:array];
}



- (instancetype) bk_sortByKey:(NSString *)key
{
    NSArray *array = [[self array] bk_sortByKey:key];
    return [[self class] orderedSetWithArray:array];
}

@end



