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

/**
 * # Define macros
 */
#pragma mark- Define macros
#pragma mark-

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

#define $url(str) ({ [NSURL URLWithString:(str)]; })



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
#   define $new(Klass) IF_ARC([[Klass alloc] init], [[[Klass alloc] init] autorelease])
#endif

#ifndef $str
#   define $str(...)   [NSString stringWithFormat:__VA_ARGS__]
#endif

#ifndef $point
#   define $point(val)       [NSValue valueWithCGPoint:(val)]
#endif

#ifndef $selector
#   define $selector(val)    [NSValue valueWithPointer:@selector(val)]
#endif


/**
 * # Typedefs
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



/**!
 * ### enum BrynKitDispatchSourceState
 *
 * Use this to keep track of the state of `dispatch_source` objects so that you don't
 * over-resume them, try to cancel them when they're suspended, etc.
 */
typedef enum : NSUInteger {
    BrynKitDispatchSourceState_Suspended = 1,
    BrynKitDispatchSourceState_Resumed = 2,
    BrynKitDispatchSourceState_Canceled = 3
} BrynKitDispatchSourceState;





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

extern void dispatch_safe_sync(dispatch_queue_t queue, dispatch_block_t block);



#endif // __Bryn__





