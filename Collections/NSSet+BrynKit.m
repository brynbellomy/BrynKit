
#import "NSSet+BrynKit.h"
#import "NSArray+BrynKit.h"



@implementation NSSet (BrynKit)

- (NSOrderedSet *) bk_sort
{
    NSArray *array = [[self allObjects] bk_sort];
    return [NSOrderedSet orderedSetWithArray:array];
}



- (NSOrderedSet *) bk_sortByKey:(NSString *)key
{
    NSArray *array = [self sortedArrayUsingDescriptors: @[ [[NSSortDescriptor alloc] initWithKey:key ascending:YES] ]];
    return [NSOrderedSet orderedSetWithArray: array];
}

@end




