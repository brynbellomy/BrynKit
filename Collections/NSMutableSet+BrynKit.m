

#import "NSMutableSet+BrynKit.h"
#import "NSArray+BrynKit.h"


@implementation NSMutableSet (BrynKit)

- (NSMutableOrderedSet *) bk_sort
{
    NSArray *array = [[self allObjects] bk_sort];
    return [[[self class] orderedSetWithArray:array] mutableCopy];
}



- (NSMutableOrderedSet *) bk_sortByKey:(NSString *)key
{
    NSArray *array = [self sortedArrayUsingDescriptors: @[ [[NSSortDescriptor alloc] initWithKey:key ascending:YES] ]];
    return [[NSMutableOrderedSet orderedSetWithArray: array] mutableCopy];
}

@end




