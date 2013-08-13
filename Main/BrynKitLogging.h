//
//  BrynKitLogging.h
//  BrynKit
//
//  Created by bryn austin bellomy on 2/27/2013.
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef __BRYNKIT_COCOALUMBERJACK__
#   ifndef lllog
#       define lllog(level, ...)  NSLog(__VA_ARGS__)
#   endif
#   ifndef lllogc
#       define lllogc(level, ...) NSLog(__VA_ARGS__)
#   endif
#endif


/**
 * @name Color logging
 *
 * These macros and `#define`s help to integrate with the [XcodeColors](http://github.com/robbiehanson/XcodeColors) plugin.
 *
 * **IMPORTANT:** `XcodeColors` currently only works with `lldb`.  If you're
 * using `gdb`, you'll just see a bunch of garbage surrounding your NSLog output.
 *
 * If you're using `lldb` and you still see garbage output, try changing the
 * XCODE_COLORS_ESCAPE macro below.
 */

#define XCODE_COLORS_ESCAPE_OSX @"\033["
#define XCODE_COLORS_ESCAPE_IOS @"\xC2\xA0["

#define XCODE_COLORS_ESCAPE  XCODE_COLORS_ESCAPE_OSX

#define XCODE_COLORS_RESET_FG  XCODE_COLORS_ESCAPE @"fg;" // Clear any foreground color
#define XCODE_COLORS_RESET_BG  XCODE_COLORS_ESCAPE @"bg;" // Clear any background color
#define XCODE_COLORS_RESET     XCODE_COLORS_ESCAPE @";"   // Clear any foreground or background color
#define XCODE_COLORS_FG(r,g,b) XCODE_COLORS_ESCAPE @"fg" @#r @"," @#g @"," @#b @";"



/**
 * @name rgb color macros
 *
 * @discussion
 * These macros evaluate to a regular NSString literal, so you can simply
 * concatenate them into an NSString expression like so:
 *
 * @code
    NSLog( @"Blah blah" COLOR_RED( @"This will be red" ) @"And this will not" );
 * @endcode
 */
#define COLOR_WHITE(x)     XCODE_COLORS_FG(255,255,255) x XCODE_COLORS_RESET
#define COLOR_RED(x)       XCODE_COLORS_FG(178,34,34) x XCODE_COLORS_RESET
#define COLOR_YELLOW(x)    XCODE_COLORS_FG(255,185,0) x XCODE_COLORS_RESET
#define COLOR_ORANGE(x)    XCODE_COLORS_FG(225,135,0) x XCODE_COLORS_RESET
#define COLOR_OLIVE(x)     XCODE_COLORS_FG(85,107,47) x XCODE_COLORS_RESET
#define COLOR_GREEN(x)     XCODE_COLORS_FG(34,139,34) x XCODE_COLORS_RESET
#define COLOR_PURPLE(x)    XCODE_COLORS_FG(132,112,255) x XCODE_COLORS_RESET
#define COLOR_BLUE(x)      XCODE_COLORS_FG(30,144,255) x XCODE_COLORS_RESET
#define COLOR_LIGHTBLUE(x) XCODE_COLORS_FG(130,244,255) x XCODE_COLORS_RESET
#define COLOR_GREY(x)      XCODE_COLORS_FG(160,160,160) x XCODE_COLORS_RESET

/**
 * ### a simple predefined color logging 'theme'
 *
 * Just as with the predefined RGB colors above, you can concatenate
 * these into a plain ol' NSString expression:
 *
 * @code
    NSLog( COLOR_ERROR( @"You screwed up" ) @"... but it'll be okay." );
 * @endcode
 */

#ifndef COLOR_ERROR
#   define COLOR_ERROR    COLOR_RED
#endif

#ifndef COLOR_SUCCESS
#   define COLOR_SUCCESS  COLOR_GREEN
#endif

#ifndef COLOR_WARN
#   define COLOR_WARN     COLOR_ORANGE
#endif

#ifndef COLOR_INFO
#   define COLOR_INFO     COLOR_LIGHTBLUE
#endif

#ifndef COLOR_VERBOSE
#   define COLOR_VERBOSE  COLOR_GREY
#endif

#ifndef COLOR_FILENAME
#   define COLOR_FILENAME COLOR_PURPLE
#endif

#ifndef COLOR_LINE
#   define COLOR_LINE     COLOR_YELLOW
#endif

#ifndef COLOR_FUNC
#   define COLOR_FUNC     COLOR_BLUE
#endif

#ifndef COLOR_SEL
#   define COLOR_SEL(x)   @"[" COLOR_BLUE(x) @"]"
#endif

#ifndef COLOR_GCD_QUEUE
#   define COLOR_GCD_QUEUE(x)   @"[" COLOR_YELLOW(x) @"]"
#endif


/**
 * @define BKEnableColorLogging
 *
 * Enables XcodeColors (you obviously have to install it too).  Call this from
 * your app delegate's `applicationDidFinishLoading:` function, or something
 * else sufficiently early.
 */
#define BKEnableColorLogging() do{ setenv("XcodeColors", "YES", 0); }while(0)

/**
 * @define BKDisableColorLogging
 *
 * Disables XcodeColors.
 */
#define BKDisableColorLogging() do{ setenv("XcodeColors", "NO", 0) }while(0)

/**
 * @define __JUST_FILENAME__
 *
 * `__FILE__` contains the entire path to a file.  this `#define` only gives you the file's actual name.
 */
#define __JUST_FILENAME__   $utf8(__FILE__).lastPathComponent










