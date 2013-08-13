//
//  Bryn.h
//  BrynKit
//
//  Created by bryn austin bellomy on 7/18/12.
//  Copyright (c) 2012 bryn austin bellomy. All rights reserved.
//

#import <libextobjc/metamacros.h>


/**---------------------------------------------------------------------------------------
 * @name Define macros
 *  ---------------------------------------------------------------------------------------
 */

#pragma mark- Obj-C init method macros
#pragma mark-

#define _bk_macroArgIsMethodParameterType(N) \
        metamacro_at(N, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0)

#define _bk_initializerParams_iter(INDEX, ARG)          \
        metamacro_if_eq(0, _bk_macroArgIsMethodParameterType(INDEX)) \
            ( ARG ) \
            ( (ARG) )

#define _bk_callExistingInitializer_iter(INDEX, ARG)    \
        metamacro_if_eq(0, _bk_macroArgIsMethodParameterType(INDEX)) \
            (ARG) \
            ()

#define BKImplementConvenienceInitializer( OBJ_NAME, ... ) \
        + (instancetype) metamacro_concat(OBJ_NAME,metamacro_foreach(_bk_initializerParams_iter,, ## __VA_ARGS__)) \
        { \
            id instance = [[self alloc] metamacro_concat(init,metamacro_foreach(_bk_callExistingInitializer_iter,, ## __VA_ARGS__)) ]; \
            yssert_notNilAndIsClass( instance, self ); \
            return instance; \
        }

/**
 * 
 *
 * Example: you're subclassing UIView but you don't want to allow the standard `initWithFrame:` initializer.
 * These macros will generate implementations for any initializers that are not supported by your subclass
 * which do nothing more than throw `NSInternalInconsistencyException`s when they are called.
 *
 * In your `.h` file:
 
      BKInitializersAreUnsupported( initWithCoder:(NSCoder *)aDecoder );

 * ... and in your `.m` file:

     BKImplementUnsupportedInitializers( YFilterThumbnailBox, initWithFilter:image:, initWithCoder:(NSCoder *)aDecoder );

 */
#define BKInitializerIsUnsupported(...) \
        _bk_generateUnsupportedInitializerDecl_iter(,, __VA_ARGS__);

#define BKInitializersAreUnsupported(...) \
        metamacro_foreach_cxt( _bk_generateUnsupportedInitializerDecl_iter,,, __VA_ARGS__ ) \

#define _bk_generateUnsupportedInitializerDecl_iter(INDEX, CONTEXT, UNSUPPORTED_SELECTOR) \
        - (instancetype) UNSUPPORTED_SELECTOR __attribute__(( deprecated )); \



#define BKImplementUnsupportedInitializer(CLASS_NAME, DESIGNATED_INIT, ...) \
        _bk_implementUnsupportedInitializers_iter(, (CLASS_NAME DESIGNATED_INIT), __VA_ARGS__)

#define BKImplementUnsupportedInitializers(CLASS_NAME, DESIGNATED_INIT, ...) \
        metamacro_foreach_cxt( _bk_implementUnsupportedInitializers_iter,,(CLASS_NAME DESIGNATED_INIT), __VA_ARGS__ )

#define _bk_implementUnsupportedInitializers_iter(INDEX, CONTEXT, UNSUPPORTED_SELECTOR) \
        \
        - (instancetype) UNSUPPORTED_SELECTOR \
        { \
            @throw [NSException exceptionWithName:@"NSInternalInconsistencyException" reason:@"You must call -[" @ # CONTEXT @"], the designated initializer." userInfo:nil]; \
            return nil; \
        }



/**---------------------------------------------------------------------------------------
 * @name Misc. #define macros
 * ---------------------------------------------------------------------------------------
 */

#pragma mark- Misc. #define macros
#pragma mark-


#define BKRectWithSize(size) \
            ({ CGRectMake(0.0f, 0.0f, size.width, size.height); })

#define BKRectWithDimensions(width, height) \
            ({ CGRectMake(0.0f, 0.0f, width, height); })

#define BKRectWithOriginAndSize(point, size) \
            ({ CGRectMake(point.x, point.y, size.width, size.height); })

#define BKSizeWithRect(rect) \
            ({ CGSizeMake( rect.size.width, rect.size.height ); })

#define BKSizeWithVideoDimensions(dim) \
            ({ CGSizeMake( (CGFloat)dim.width, (CGFloat)dim.height ); })

#define BKFlagIsSet(needle, haystack) \
            ({ (needle & haystack) != 0; })

#define fffontAwesomeIcon(iconName) [[[FIFontAwesomeIcon alloc] init] iconName]
#define eeentypoIcon(iconName)      [FIEntypoIcon metamacro_concat(iconName,Icon) ]
#define iiiconicIcon(iconName)      [[[FIIconicIcon alloc] init] iconName]


/**
 * Use this macro to check if a globally-scoped framework constant (like, say,
 * `kCVPixelBufferOpenGLESCompatibilityKey`) is available in the current SDK.
 */
#define BKCheckIfGlobalConstantIsAvailable(constant) (&constant != NULL)


/**
 @define BKDefineStringKey(...)
 @discussion Defines a pointer to a static `NSString` literal to be used for key-value stuff,
 `NSDictionary` keys, etc.  Ex:

     BKDefineStringKey(MyNotificationUserInfoKey_Clowns);
     // ... expands to `static NSString *const MyNotificationUserInfoKey_Clowns = @"MyNotificationUserInfoKey_Clowns"`

     BKDefineStringKey(MyNotificationUserInfoKey_Clowns, @"clowns");
     // ... expands to `static NSString *const MyNotificationUserInfoKey_Clowns = @"clowns"`

     NSLog(@"the clowns in the userinfo dictionary: %@", userInfo[MyNotificationUserInfoKey_Clowns]);

 @param identifier The name of the NSString variable.
 @param value The contents of the NSString (optional).
 */

#define BKDefineStringKey(...) \
    metamacro_if_eq(1, metamacro_argcount(__VA_ARGS__)) \
        ( static NSString *const metamacro_head(__VA_ARGS__) = @ metamacro_stringify(metamacro_head(__VA_ARGS__)) ) \
        ( static NSString *const metamacro_head(__VA_ARGS__) = metamacro_tail(__VA_ARGS__) )



/**
 * Defines a `static void *const` variable in the current scope that can be used as a key when manipulating Objective-C associated objects or GCD `dispatch_queue_t` contexts.
 *
 * @see dispatch_set_specific
 * @see dispatch_get_specific
 * @see dispatch_queue_set_specific
 * @see dispatch_queue_get_specific
 * @see objc_setAssociatedObject
 * @see objc_getAssociatedObject
 */
#define BKDefineVoidKey(key) \
    static void *const key = (void *)&key


/**
 * This is useful if you find it difficult to remember the awkward, new way
 * of instantiating out-params under ARC rules.  To use, do something like the
 * following:

     @nserror(error);
     [someObject doSomethingHard:123 error:&error];
     if (error != nil) {
         // ...
     }

 */
#define nserror(x)    try{}@finally{} NSError __autoreleasing * x = x

#define throw_if_error(err, ...)  \
    try{}@finally{} \
    do { \
        yssert( !err, ## __VA_ARGS__ ) \
    } while( 0 )

#define return_if_error(err) \
    try{}@finally{} \
    do { \
        if ( err ) { return; } \
    } while( 0 )

#define return_nil_if_error(err) \
    try{}@finally{} \
    do { \
        if ( err ) { return nil; } \
    } while( 0 )

#define lllog_if_error(err) \
    try{}@finally{} \
    do { \
        if ( err ) { lllog(Error, @"Error (line " @ metamacro_stringify(__LINE__) @" in " @ metamacro_stringify(__FILE__) @"): %@", [error localizedDescription]); } \
    } while( 0 )



#define BKErrorThrow        @throw_if_error
#define BKErrorReturn(err)  @return_if_error
#define BKErrorReturnNil    @return_nil_if_error
#define BKErrorLog          @lllog_if_error


#define instanceOf(klass) isKindOfClass:[klass class]

#define $url(str) ({ [NSURL URLWithString:(str)]; })

#define $bundleResourceURL(res, ext) [[NSBundle mainBundle] URLForResource:res withExtension:ext]

#define $fileManager [NSFileManager defaultManager]

#define $notificationCenter [NSNotificationCenter defaultCenter]

#define $app [UIApplication sharedApplication]

#define $documentDirectories \
    ({ NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); })

#define $sortByKeyAscending(array, key) \
    ({ [array sortedArrayUsingDescriptors: @[ [[NSSortDescriptor alloc] initWithKey:key ascending:YES] ]]; })

#define $sortByKeyDescending(array, key) \
    ({ [array sortedArrayUsingDescriptors: @[ [[NSSortDescriptor alloc] initWithKey:key ascending:NO] ]]; })



#define bk_uint unsignedIntegerValue

#define bk_int integerValue

#define bk_float floatValue

#define bk_double doubleValue

#define bk_bool boolValue



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

#if !defined($new)
#   define $new(Klass) IF_ARC([[Klass alloc] init], [[[Klass alloc] init] autorelease])
#endif

#if !defined($str)
#   define $str(__FORMAT__, ...)   ({ [NSString stringWithFormat:__FORMAT__, ## __VA_ARGS__]; })
#endif

#if !defined($utf8)
#   define $utf8(utf8str)   ({ [NSString stringWithCString:utf8str encoding:NSUTF8StringEncoding]; })
#endif

#if !defined($point)
#   define $point(val)       ({ [NSValue valueWithCGPoint:(val)]; })
#endif

#if !defined($pointer)
#   define $pointer(val)       ({ [NSValue valueWithPointer:(val)]; })
#endif

#if !defined($selector)
#   define $selector(val)    ({ [NSValue valueWithPointer:@selector(val)]; })
#endif

#if !defined($range)
#   define $range(val)       ({ [NSValue valueWithRange:(val)]; })
#endif



/**
 * @name Objective-C Block typedefs
 */

#pragma mark- Objective-C Block typedefs
#pragma mark-

typedef void(^BoolBlock)(BOOL);
typedef void(^UIntBlock)(NSUInteger);
typedef void(^ErrorBlock)(NSError *);
typedef void(^NotificationBlock)(NSNotification *);
typedef void(^DictionaryBlock)(NSDictionary *);
typedef void(^IdBlock)(id);
typedef void(^UpdateCollectionCallbackBlock)(NSDictionary *updatedCollection);
typedef void(^UpdateCollectionBlock)(NSMutableDictionary *collection, UpdateCollectionCallbackBlock callback);
typedef   id(^BKRemapBlock)(id key, id val);




/**---------------------------------------------------------------------------------------
 * @name Image-related macros
 *  ---------------------------------------------------------------------------------------
 */

#pragma mark- Image-related macros
#pragma mark-




/**!
 * # ARC/non-ARC compatibility helpers
 *
 * everything in this section comes courtesy of the fantastic MBProgressHUD
 * class by matej bukovinski [http://github.com/jdg/MBProgressHUD]
 */
#pragma mark- ARC/non-ARC compatibility helpers
#pragma mark-

#ifndef bk_strong
    #if __has_feature(objc_arc)
        #define bk_strong strong
    #else
        #define bk_strong retain
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




/**---------------------------------------------------------------------------------------
 * @name Categories: Foundation
 *  ---------------------------------------------------------------------------------------
 */

#pragma mark- Categories: Foundation
#pragma mark-

//#if !defined($concat)
#if defined($concat)
#   undef($concat)
#endif
#define $concat(x, y) [x stringByAppendingString:y]

//#if !defined($concatPath)
#if defined($concatPath)
#   undef($concatPath)
#endif
#define $concatPath(x, y) [x stringByAppendingPathComponent:y]

//#if !defined($concatFileExt)
#if defined($concatFileExt)
#   undef($concatFileExt)
#endif
#define $concatFileExt(x, y) [x stringByAppendingPathExtension:y]


@interface NSNumber (BrynKit)

- (BOOL)bk_isYes;
- (BOOL)bk_isNo;

@end

@interface NSRegularExpression (BrynKit)

+ (NSArray *) bk_resultsOfRegex:(NSString *)strPattern inString:(NSString *)haystack;

@end




@protocol BKComparable <NSObject>

- (NSInteger) compare:(id<BKComparable>)other;

@end



/**
* Global `Bryn` object that we can piggyback on here and there (for instance,
* when using the CocoaLumberjack submodule).
*/
@interface Bryn : NSObject

@end





