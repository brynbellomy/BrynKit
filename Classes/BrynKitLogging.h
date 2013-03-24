//
//  BrynKitLogging.h
//  BrynKit
//
//  Created by bryn austin bellomy on 2/27/2013.
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//

/**!
 * # Logging and debug macros
 */
#pragma mark- logging and debug macros
#pragma mark-

/**!
 * ### color logging
 *
 * These macros and `#define`s help to integrate with the XcodeColors plugin.
 *
 * **IMPORTANT:** XcodeColors currently only works with `lldb`.  If you're
 * using `gdb`, you'll just see a bunch of garbage surrounding your NSLog output.
 */

#define XCODE_COLORS_ESCAPE_OSX @"\033["
#define XCODE_COLORS_ESCAPE_IOS @"\xC2\xA0["

#define XCODE_COLORS_ESCAPE  XCODE_COLORS_ESCAPE_OSX

#define XCODE_COLORS_RESET_FG  XCODE_COLORS_ESCAPE @"fg;" // Clear any foreground color
#define XCODE_COLORS_RESET_BG  XCODE_COLORS_ESCAPE @"bg;" // Clear any background color
#define XCODE_COLORS_RESET     XCODE_COLORS_ESCAPE @";"   // Clear any foreground or background color
#define XCODE_COLORS_FG(r,g,b) XCODE_COLORS_ESCAPE @"fg" @#r @"," @#g @"," @#b @";"

/**!
 * ### predefined rgb colors
 *
 * These macros evaluate to a regular NSString literal, so you can simply
 * concatenate them into an NSString expression like so:
 *
 * `NSLog(@"Blah blah" COLOR_RED(@"This will be red") @"This will not");`
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

/**!
 * ### a simple predefined color logging 'theme'
 *
 * Just as with the predefined RGB colors above, you can concatenate
 * these into a plain ol' NSString expression:
 *
 * `NSLog(COLOR_ERROR(@"You screwed up") @"... but it'll be okay.");`
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
#ifndef COLOR_QUEUE
#   define COLOR_QUEUE(x)   @"[" COLOR_YELLOW(x) @"]"
#endif


/**!
 * ### BrynEnableColorLogging()
 *
 * Enables XcodeColors (you obviously have to install it too).  Call this from
 * your app delegate's `-applicationDidFinishLoading:` function, or something
 * else sufficiently early.
 */
#define BrynEnableColorLogging() do{ setenv("XcodeColors", "YES", 0); }while(0)

/**!
 * ### BrynDisableColorLogging()
 *
 * Disables XcodeColors.
 */
#define BrynDisableColorLogging() do{ setenv("XcodeColors", "NO", 0) }while(0)

/**!
 * ### \_\_JUST_FILENAME\_\_
 *
 * `__FILE__` contains the entire path to a file.  this `#define` only gives you the file's actual name.
 */
#define __JUST_FILENAME__ [[NSString stringWithUTF8String:__FILE__] lastPathComponent]



#define BrynLog(__FORMAT__, ...)   NSLog(@"[" COLOR_FILENAME(@"%@") @":" COLOR_LINE(@"%d") @"] %@", __JUST_FILENAME__, __LINE__, [NSString stringWithFormat:(__FORMAT__), ##__VA_ARGS__])

#define BrynFnLog(fmt, ...) NSLog(COLOR_FUNC(@"%s ") @"%@", __func__, [NSString stringWithFormat:(fmt), ##__VA_ARGS__])

#define BrynFnLogString(severity, __FORMAT__, ...) metamacro_concat(BrynFnLogString_,severity)((__FORMAT__), ## __VA_ARGS__)
#define BrynFnLogString_Error(__FORMAT__, ...)   ([NSString stringWithFormat: COLOR_FUNC(@"%s ") COLOR_ERROR(__FORMAT__), __func__, ## __VA_ARGS__])
#define BrynFnLogString_Success(__FORMAT__, ...) ([NSString stringWithFormat: COLOR_FUNC(@"%s ") COLOR_SUCCESS(__FORMAT__), __func__, ## __VA_ARGS__])
#define BrynFnLogString_Warning(__FORMAT__, ...) ([NSString stringWithFormat: COLOR_FUNC(@"%s ") COLOR_WARN(__FORMAT__), __func__, ## __VA_ARGS__])
#define BrynFnLogString_Info(__FORMAT__, ...)    ([NSString stringWithFormat: COLOR_FUNC(@"%s ") COLOR_INFO(__FORMAT__), __func__, ## __VA_ARGS__])
#define BrynFnLogString_Verbose(__FORMAT__, ...) ([NSString stringWithFormat: COLOR_FUNC(@"%s ") COLOR_VERBOSE(__FORMAT__), __func__, ## __VA_ARGS__])





