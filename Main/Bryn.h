//
//  Bryn.h
//  BrynKit
//
//  Created by bryn austin bellomy on 7/18/12.
//  Copyright (c) 2012 bryn austin bellomy. All rights reserved.
//

#ifndef __Bryn__
#define __Bryn__  // is this even possible????

#import <libextobjc/metamacros.h>

/** @name Define macros */

/**
 * # Define macros
 */
#pragma mark- Define macros
#pragma mark-

#define CGRectWithSize(size) \
            ({ \
                CGRectMake(0.0f, 0.0f, size.width, size.height); \
            })
#define CGRectWithDimensions(width, height) \
            ({ \
                CGRectMake(0.0f, 0.0f, width, height); \
            })



/**
 * #### Key(...)
 *
 * Defines a pointer to a static `NSString` literal to be used for key-value stuff,
 * `NSDictionary` keys, etc.  Ex:

 * ```
 * Key(MyNotificationUserInfoKey_Clowns);
 * // ... expands to `static NSString *const MyNotificationUserInfoKey_Clowns = @"MyNotificationUserInfoKey_Clowns"`
 *
 * Key(MyNotificationUserInfoKey_Clowns, @"clowns");
 * // ... expands to `static NSString *const MyNotificationUserInfoKey_Clowns = @"clowns"`
 *
 * NSLog(@"the clowns in the userinfo dictionary: %@", userInfo[MyNotificationUserInfoKey_Clowns]);
 * ```

 * @param {identifier} identifier The name of the NSString variable.
 * @param {NSString*} value The contents of the NSString (optional).
 */

#define Key(...) \
    metamacro_if_eq(1, metamacro_argcount(__VA_ARGS__)) \
        ( static NSString *const metamacro_head(__VA_ARGS__) = @ metamacro_stringify(metamacro_head(__VA_ARGS__)) ) \
        ( static NSString *const metamacro_head(__VA_ARGS__) = metamacro_tail(__VA_ARGS__) )


/**
 * Misc. macros
 */

#define instanceOf(klass) isKindOfClass:[klass class]

#define $url(str) ({ [NSURL URLWithString:(str)]; })

#define $bundleResourceURL(res, ext) [[NSBundle mainBundle] URLForResource:res withExtension:ext]

#define $fileManager [NSFileManager defaultManager]

#define $notificationCenter [NSNotificationCenter defaultCenter]

#define $app [UIApplication sharedApplication]

#define $documentDirectories \
    ({ \
        NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); \
    })


#define $sortByKeyAscending(array, key) \
    ({ [array sortedArrayUsingDescriptors: @[ [[NSSortDescriptor alloc] initWithKey:key ascending:YES] ]]; })

#define $sortByKeyDescending(array, key) \
    ({ [array sortedArrayUsingDescriptors: @[ [[NSSortDescriptor alloc] initWithKey:key ascending:NO] ]]; })



/**
 * # Macros from ConciseKit
 *
 * I can't always justify including the whole of [ConciseKit](http://github.com/petejkim/ConciseKit)
 * just because I want to use `$new(...)` a few times in a helper library.  So these are here mainly
 * for me to be able to have my cake and eat it too.
 */

#ifndef __has_feature
#   define __has_feature(x) 0
#endif

#if __has_feature(objc_arc)
#   define IF_ARC(with, without) with
#else
#   define IF_ARC(with, without) without
#endif

#ifndef $new
#define $new(Klass) IF_ARC([[Klass alloc] init], [[[Klass alloc] init] autorelease])
#endif

#ifndef $str
#define $str(__FORMAT__, ...)   [NSString stringWithFormat:__FORMAT__, ## __VA_ARGS__]
#endif

#ifndef $utf8
#define $utf8(utf8str)   [NSString stringWithCString:utf8str encoding:NSUTF8StringEncoding]
#endif

#ifndef $point
#define $point(val)       [NSValue valueWithCGPoint:(val)]
#endif

#ifndef $pointer
#define $pointer(val)       [NSValue valueWithPointer:(val)]
#endif

#ifndef $selector
#define $selector(val)    [NSValue valueWithPointer:@selector(val)]
#endif


/**---------------------------------------------------------------------------------------
 * @name Typedefs
 *  ---------------------------------------------------------------------------------------
 */

#pragma mark- Typedefs
#pragma mark-


/**
 * ### Blocks
 *
 * Saves a little bit of tedious typing.
 */
typedef void(^BoolBlock)(BOOL);
typedef void(^UIntBlock)(NSUInteger);
typedef void(^ErrorBlock)(NSError *);
typedef void(^NotificationBlock)(NSNotification *);
typedef void(^DictionaryBlock)(NSDictionary *);
typedef void(^IdBlock)(id);
typedef void(^UpdateCollectionCallbackBlock)(NSDictionary *updatedCollection);
typedef void(^UpdateCollectionBlock)(NSMutableDictionary *collection, UpdateCollectionCallbackBlock callback);



typedef struct _BKFloatRange {
    Float32 location;
    Float32 length;
} BKFloatRange;

#define BKFloatRangeZero BKMakeFloatRange(0.0f, 0.0f)
#define BKFloatRangeOne  BKMakeFloatRange(1.0f, 0.0f)

/**
 * Creates a `BKFloatRange` initialized with the provided `loc` (location) and `len` (length) values.
 *
 *  @param loc Where the range should begin.
 *  @param len The length of the range.
 *  @return A `BKFloatRange` representing a continuous range from `loc` to `loc + len`.
*/
extern BKFloatRange BKMakeFloatRange(Float32 loc, Float32 len);

/**
 * Creates a `BKFloatRange` initialized with `loc = start` and `len = end - start`.
 *
 * @param `start` Where the range should begin.
 * @param `end` Where the range should end.
 * @return A `BKFloatRange representing a continuous range from `start` to `end`.
 **/
extern BKFloatRange BKMakeFloatRangeWithBounds(Float32 start, Float32 end);
extern BKFloatRange BKMakeZeroLengthFloatRange(Float32 location);

extern Float32 BKFloatRangeStartValue(BKFloatRange range);
extern Float32 BKFloatRangeEndValue(BKFloatRange range);
extern Float32 BKMinValueInFloatRange(BKFloatRange range);
extern Float32 BKMaxValueInFloatRange(BKFloatRange range);

extern BOOL BKIsLocationInFloatRange(Float32 loc, BKFloatRange range);
extern BOOL BKFloatRangesAreEqual(BKFloatRange range1, BKFloatRange range2);

//extern NSArray* SEMakeGradientSwatch(NSUInteger numSteps, BKFloatRange red, BKFloatRange green, BKFloatRange blue, BKFloatRange alpha)

/**!
 * # Image-related macros
 */
#pragma mark- image-related macros
#pragma mark-

/**!
 * ### UIImageWithBundlePNG()
 *
 * Load a PNG file from the main bundle.  People use `+[UIImage imageNamed:]`
 * because it's much easier than the (minimum) method calls you have to make to
 * load a UIImage the 'right' way.  With a macro like this, there's no excuse.
 * Note: the image filename you pass to this macro should not contain its file
 * extension (".png").
 *
 * @param {NSString*} filename The filename of the image without its ".png" extension.
 */
#if !defined(UIImageWithBundlePNG)
#   define UIImageWithBundlePNG(x) ([UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:(x) ofType: @"png"]])
#endif


extern CGImageRef BrynCGImageFromFile(NSString *path);
extern CGImageRef BrynCGImageFromBundlePNG(NSString *basename);
extern UIImage*   BrynUIImageFromBundlePNG(NSString *basename);



/**!
 * # ARC/non-ARC compatibility helpers
 *
 * everything in this section comes courtesy of the fantastic MBProgressHUD
 * class by matej bukovinski [http://github.com/jdg/MBProgressHUD]
 */
#pragma mark- ARC/non-ARC compatibility helpers
#pragma mark-

#ifndef bryn_strong
    #if __has_feature(objc_arc)
        #define bryn_strong strong
    #else
        #define bryn_strong retain
    #endif
#endif

#ifndef bryn_weak
    #if __has_feature(objc_arc_weak)
        #define   bryn_weak   weak
        #define __bryn_weak __weak
    #elif __has_feature(objc_arc)
        #define   bryn_weak   unsafe_unretained
        #define __bryn_weak __unsafe_unretained
    #else
        #define   bryn_weak   assign
        #define __bryn_weak __assign
    #endif
#endif

#if __has_feature(objc_arc)
    #define BrynAutorelease(exp) exp
    #define BrynRelease(exp) exp
    #define BrynRetain(exp) exp
#else
    #define BrynAutorelease(exp) [exp autorelease]
    #define BrynRelease(exp) [exp release]
    #define BrynRetain(exp) [exp retain]
#endif


/**!
 * # GCD/concurrency helpers
 */
#pragma mark- GCD/concurrency helpers
#pragma mark-

extern void dispatch_safe_sync(dispatch_queue_t queue, dispatch_block_t block); // __attribute__((deprecated));

//#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_6_0
#if !(OS_OBJECT_USE_OBJC)
#   define dispatch_strong assign
#else
#   define dispatch_strong strong
#endif



/**!
 * # Misc. (will be refactored into self-sufficient components)
 */
#pragma mark- Misc.
#pragma mark-

@interface NSObject (BrynKit_Description)

- (NSString *) bryn_descriptionWithProperties:(NSArray *)properties;
- (NSString *) bryn_descriptionWithProperties:(NSArray *)properties separator:(NSString *)separator;
- (NSString *) bryn_descriptionWithProperties:(NSArray *)properties separator:(NSString *)separator formatter:(NSString *(^)(NSString *property, id value))formatter;

- (NSString *) bryn_descriptionWithString:(NSString *)string;

@end



@interface UIDevice (BrynKit)

+ (BOOL) bryn_isMultitaskingSupported;
+ (BOOL) bryn_isIPhone5OrTaller;

@end



@interface UIScreen (BrynKit)

- (CGFloat) bryn_scaledHeight;
- (CGFloat) bryn_actualHeight;
- (CGFloat) bryn_scaledWidth;
- (CGFloat) bryn_actualWidth;

@end



@interface NSString (BrynKit)

- (NSString *) bryn_replace:(NSString *)strToReplace        with:(NSString *)replacementStr;
- (NSString *) bryn_replaceRegex:(NSString *)regexToReplace with:(NSString *)replacementStr;

@end



#pragma mark- Categories: UIKit
#pragma mark-

@interface UILabel (BrynKit)

- (void) bryn_setLabelTextAndSizeToFit:(NSString *)newText;

@end


@interface UIView (BrynKit)

- (void) bryn_animateKey:(NSString *)key fromValue:(id)fromValue toValue:(id)toValue duration:(CFTimeInterval)duration autoreverses:(BOOL)autoreverses;
- (void) bryn_animateKey:(NSString *)key toValue:(id)toValue duration:(CFTimeInterval)duration autoreverses:(BOOL)autoreverses;

@end



#pragma mark- Categories: collections
#pragma mark-

@protocol BKComparable <NSObject>

- (NSInteger) compare:(id<BKComparable>)other;

@end



@interface NSArray (BrynKitSorting)

- (instancetype) bryn_sort;
- (instancetype) bryn_sortByKey:(NSString *)key;
- (instancetype) bryn_sort:(NSComparator)comparator;

@end



@interface NSSet (BrynKitSorting)

- (NSOrderedSet *) bryn_sort;
- (NSOrderedSet *) bryn_sortByKey:(NSString *)key;

@end



@interface NSMutableSet (BrynKitSorting)

- (NSMutableOrderedSet *) bryn_sort;
- (NSMutableOrderedSet *) bryn_sortByKey:(NSString *)key;

@end




@interface NSOrderedSet (BrynKit)

+ (instancetype) bryn_orderedSetWithIntegersInRange:(NSRange)range;

@end



@interface NSOrderedSet (BrynKitSorting)

- (instancetype) bryn_sort;
- (instancetype) bryn_sortByKey:(NSString *)key;

@end



@interface NSMutableOrderedSet (BrynKitSorting)

- (instancetype) bryn_sort;
- (instancetype) bryn_sortByKey:(NSString *)key;

@end



@interface NSDictionary (BrynKitSorting)

- (NSArray *) bryn_sortedKeysByComparingSubkey:(NSString *)subkey;

@end



#pragma mark- Categories: Graphics/Quartz/etc.
#pragma mark-

@interface UIImage (BrynKit)

+ (UIImage *) bryn_imageWithBundlePNG:(NSString *)filename;

@end



@interface UIColor (BrynKit)

+ (instancetype) bryn_rgba:(CGFloat [4])rgba;

@end



#endif // __Bryn__





