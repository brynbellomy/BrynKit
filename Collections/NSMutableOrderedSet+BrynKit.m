
#import "NSArray+BrynKit.h"
#import "NSMutableOrderedSet+BrynKit.h"


@implementation NSMutableOrderedSet (BrynKit)

- (instancetype) bk_sort
{
    NSArray *array = [[self array] bk_sort];
    return [[[self class] orderedSetWithArray:array] mutableCopy];
}



- (instancetype) bk_sortByKey:(NSString *)key
{
    NSArray *array = [[self array] bk_sortByKey:key];
    return [[[self class] orderedSetWithArray:array] mutableCopy];
}

@end




