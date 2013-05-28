//
//  BrynKitDebugging.h
//  BrynKit
//
//  Created by bryn austin bellomy on 2/27/2013
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//

#import <libextobjc/metamacros.h>

/**
 * # Debugging macros
 */
#if (DEBUG == 1 || AD_HOC == 1)

/**
 * #### ALog(...)
 *
 * For internal use, mainly.
 */
#   define ALog(...) \
    do { \
        metamacro_if_eq(1, metamacro_argcount(__VA_ARGS__)) \
            ( [[NSAssertionHandler currentHandler] \
                        handleFailureInFunction:$utf8(__PRETTY_FUNCTION__) file:$utf8(__FILE__) lineNumber:__LINE__ description:@"[assertion: %@]\n%@", @ metamacro_stringify(__VA_ARGS__), [NSThread callStackSymbols]]; \
              fflush(stdout); ) \
\
            ( [[NSAssertionHandler currentHandler] \
                        handleFailureInFunction:$utf8(__PRETTY_FUNCTION__) file:$utf8(__FILE__) lineNumber:__LINE__ description:@"%@ [assertion: %@]\n%@", $str(metamacro_tail(__VA_ARGS__)), @ metamacro_stringify(metamacro_head(__VA_ARGS__)), [NSThread callStackSymbols]]; \
              fflush(stdout); ) \
    } while(0)
#   define ALogC(...) \
    do { \
        metamacro_if_eq(1, metamacro_argcount(__VA_ARGS__)) \
            ( [[NSAssertionHandler currentHandler] \
                        handleFailureInFunction:$utf8(__PRETTY_FUNCTION__) file:$utf8(__FILE__) lineNumber:__LINE__ description:@"[assertion: %@]\n%@", @ metamacro_stringify(__VA_ARGS__), [NSThread callStackSymbols]]; \
              fflush(stdout); ) \
\
            ( [[NSAssertionHandler currentHandler] \
                        handleFailureInFunction:$utf8(__PRETTY_FUNCTION__) file:$utf8(__FILE__) lineNumber:__LINE__ description:@"%@ [assertion: %@]\n%@", $str(metamacro_tail(__VA_ARGS__)), @ metamacro_stringify(metamacro_head(__VA_ARGS__)), [NSThread callStackSymbols]]; \
              fflush(stdout); ) \
    } while(0)
#else
//#   ifndef NS_BLOCK_ASSERTIONS
//#       define NS_BLOCK_ASSERTIONS
//#   endif
#   if defined (DDLogError)
#       define ALog(...) \
            do { \
                int ddLogLevel = LOG_LEVEL_VERBOSE; \
                metamacro_if_eq(1, metamacro_argcount(__VA_ARGS__)) \
                    ( DDLogError(@"[ASSERTION FAILED] [assertion: %@]",    @ metamacro_stringify(__VA_ARGS__)); fflush(stdout); ) \
                    ( DDLogError(@"[ASSERTION FAILED] %@ [assertion: %@]", $str(metamacro_tail(__VA_ARGS__)), @ metamacro_stringify(metamacro_head(__VA_ARGS__))); fflush(stdout); ) \
            } while(0)

#       define ALogC(...) \
            do { \
                int ddLogLevel = LOG_LEVEL_VERBOSE; \
                metamacro_if_eq(1, metamacro_argcount(__VA_ARGS__)) \
                    ( DDLogCError(@"[ASSERTION FAILED] [assertion: %@]",    @ metamacro_stringify(__VA_ARGS__)); fflush(stdout); ) \
                    ( DDLogCError(@"[ASSERTION FAILED] %@ [assertion: %@]", $str(metamacro_tail(__VA_ARGS__)), @ metamacro_stringify(metamacro_head(__VA_ARGS__))); fflush(stdout); ) \
            } while(0)
#   else
#       define ALog(...) \
            do { \
                metamacro_if_eq(1, metamacro_argcount(__VA_ARGS__)) \
                    ( NSLog(@"[ASSERTION FAILED] [assertion: %@]",    @ metamacro_stringify(__VA_ARGS__)); fflush(stdout); ) \
                    ( NSLog(@"[ASSERTION FAILED] %@ [assertion: %@]", $str(metamacro_tail(__VA_ARGS__)), @ metamacro_stringify(metamacro_head(__VA_ARGS__))); fflush(stdout); ) \
            } while(0)

#       define ALogC(...) \
            do { \
                metamacro_if_eq(1, metamacro_argcount(__VA_ARGS__)) \
                    ( NSLog(@"[ASSERTION FAILED] [assertion: %@]",    @ metamacro_stringify(__VA_ARGS__)); fflush(stdout); ) \
                    ( NSLog(@"[ASSERTION FAILED] %@ [assertion: %@]", $str(metamacro_tail(__VA_ARGS__)), @ metamacro_stringify(metamacro_head(__VA_ARGS__))); fflush(stdout); ) \
            } while(0)
#   endif
//                metamacro_if_eq(1, metamacro_argcount(__VA_ARGS__)) \
//                    ( BrynFnLog(@"[ASSERTION FAILED] %@ [assertion: %@]", $str(metamacro_tail(__VA_ARGS__)), @ metamacro_stringify(condition)) )
//BrynFnLog(@"[ASSERTION FAILED] %@ [assertion: %@]", $str(metamacro_tail(__VA_ARGS__)), @ metamacro_stringify(condition)) ) \
//( BrynFnLog(COLOR_ERROR(@"ASSERTION FAILED ") @"(%@) %@", @ metamacro_stringify((__VA_ARGS__)), $str(__VA_ARGS__)) )
#endif



/**
 * #### yssert()
 *
 * In DEBUG builds, `yssert` acts just like `assert()` -- it throws an
 * exception when the given condition fails.  In non-DEBUG builds, `yssert()`
 * logs the failure to `stdout` (using the message specified by the format
 * string) and proceeds with execution.
 *
 * @param expr A condition to test.
 * @param format A format string to print when `condition` is FALSE.
 */
#define yssert(condition, ...) \
    do { \
        if (!(condition)) { \
            ALog(condition, ## __VA_ARGS__); \
        } \
    } while(0)

#define yssertc(condition, ...) \
    do { \
        if (!(condition)) { \
            ALogC(condition, ## __VA_ARGS__); \
        } \
    } while(0)

#define yssert_onMainThread() \
    do { \
        yssert([NSThread isMainThread], @"-[%@ %s] must be called from the main thread.", NSStringFromClass(self.class), __PRETTY_FUNCTION__); \
    } while(0) \

#define yssert_notOnMainThread() \
    do { \
        yssert(NO == [NSThread isMainThread], @"-[%@ %s] must not be called from the main thread.", NSStringFromClass(self.class), __PRETTY_FUNCTION__); \
    } while(0) \

#define yssert_notNil(obj) \
    do { \
        yssert(obj != nil, @ metamacro_stringify(obj) @" is nil."); \
    } while(0) \

#define yssert_notNull(obj) \
    do { \
        yssert(obj != NULL, @ metamacro_stringify(obj) @" is nil."); \
    } while(0) \

#define yssert_notNilAndIsClass(obj, klass) \
    do { \
        yssert(obj != nil, @ metamacro_stringify(obj) @" is nil."); \
        yssert([obj isKindOfClass: [klass class]], @ metamacro_stringify(obj) @" is not an instance of " @ metamacro_stringify(klass)); \
    } while(0) \

#define yssert_notNilAndConformsToProtocol(obj, proto) \
    do { \
        yssert(obj != nil, @ metamacro_stringify(obj) @" is nil."); \
        yssert([obj conformsToProtocol: @protocol(proto)], @ metamacro_stringify(obj) @" does not conform to protocol " @ metamacro_stringify(proto)); \
    } while(0) \

#define yssert_notNilAndRespondsToSelector(obj, sel) \
    do { \
        yssert(obj != nil, @ metamacro_stringify(obj) @" is nil."); \
        yssert([obj respondsToSelector: @selector(sel)], @ metamacro_stringify(obj) @" does not respond to selector " @ metamacro_stringify(sel)); \
    } while(0) \

//static int _BrynKitDebugging_ddLogLevel = LOG_LEVEL_VERBOSE;
//
//void BrynKitSetDebugging_ddLogLevel(int level) { _BrynKitDebugging_ddLogLevel = level; }
//int BrynKitDebugging_ddLogLevel()              { return _BrynKitDebugging_ddLogLevel; }









