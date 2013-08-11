

@interface NSOrderedSet (BrynKit)

+ (instancetype) bk_orderedSetWithIntegersInRange:(NSRange)range;
- (instancetype) bk_sort;
- (instancetype) bk_sortByKey:(NSString *)key;

@end






