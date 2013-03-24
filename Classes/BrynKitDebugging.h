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

#ifdef DEBUG

/**
 * #### ALog(...)
 *
 * For internal use, mainly.
 */
#   define ALog(...) \
        metamacro_if_eq(1, metamacro_argcount(__VA_ARGS__)) \
        ( [[NSAssertionHandler currentHandler] handleFailureInFunction:[NSString stringWithCString:__PRETTY_FUNCTION__ encoding:NSUTF8StringEncoding] file:[NSString stringWithCString:__FILE__ encoding:NSUTF8StringEncoding] lineNumber:__LINE__ description:@""] )\
        ( [[NSAssertionHandler currentHandler] handleFailureInFunction:[NSString stringWithCString:__PRETTY_FUNCTION__ encoding:NSUTF8StringEncoding] file:[NSString stringWithCString:__FILE__ encoding:NSUTF8StringEncoding] lineNumber:__LINE__ description:__VA_ARGS__] )
#else
#   ifndef NS_BLOCK_ASSERTIONS
#       define NS_BLOCK_ASSERTIONS
#   endif
#   define ALog(...) \
        metamacro_if_eq(1, metamacro_argcount(__VA_ARGS__)) \
        ( BrynFnLog(COLOR_ERROR(@"ASSERTION FAILED ") @"(%@)",    @ metamacro_stringify((__VA_ARGS__))) ) \
        ( BrynFnLog(COLOR_ERROR(@"ASSERTION FAILED ") @"(%@) %@", @ metamacro_stringify((__VA_ARGS__)), [NSString stringWithFormat:__VA_ARGS__]) )
#endif


/**
 * #### yssert()
 *
 * In DEBUG builds, `yssert` acts just like `assert()` -- it throws an
 * exception when the given condition fails.  In non-DEBUG builds, `yssert()`
 * logs the failure to `stdout` (using the message specified by the format
 * string) and proceeds with execution.
 *
 * @param {expression} expr A condition to test.
 * @param {format-str} format A format string to print when `condition` is FALSE.
 */
#define yssert(condition, ...) do { if (!(condition)) { ALog(__VA_ARGS__); }} while(0)


#define yssert_notNil(obj) \
    yssert(obj != nil, @ metamacro_stringify(obj) @" is nil.");

#define yssert_notNilAndIsClass(obj, klass) \
    yssert(obj != nil, @ metamacro_stringify(obj) @" is nil."); \
    yssert([obj isKindOfClass: [klass class]], @ metamacro_stringify(obj) @" is not an instance of " @ metamacro_stringify(klass));

#define yssert_notNilAndConformsToProtocol(obj, proto) \
    yssert(obj != nil, @ metamacro_stringify(obj) @" is nil."); \
    yssert([obj conformsToProtocol: @protocol(proto)], @ metamacro_stringify(obj) @" does not conform to protocol " @ metamacro_stringify(proto));











