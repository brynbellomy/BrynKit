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
 * `NSLog(@"Blah blah" COLOR_RED @"This will be red" XCODE_COLORS_RESET @"This will not");`
 */
#define COLOR_RED(x)      XCODE_COLORS_FG(178,34,34) x XCODE_COLORS_RESET
#define COLOR_YELLOW(x)   XCODE_COLORS_FG(255,185,0) x XCODE_COLORS_RESET
#define COLOR_OLIVE(x)    XCODE_COLORS_FG(85,107,47) x XCODE_COLORS_RESET
#define COLOR_GREEN(x)    XCODE_COLORS_FG(34,139,34) x XCODE_COLORS_RESET
#define COLOR_PURPLE(x)   XCODE_COLORS_FG(132,112,255) x XCODE_COLORS_RESET
#define COLOR_BLUE(x)     XCODE_COLORS_FG(30,144,255) x XCODE_COLORS_RESET

/**!
 * ### a simple predefined color logging 'theme'
 *
 * Just as with the predefined RGB colors above, you can concatenate
 * these into a plain ol' NSString expression:
 *
 * `NSLog(COLOR_ERROR(@"You screwed up") @"... but it'll be okay.");`
 */
#define COLOR_ERROR    COLOR_RED
#define COLOR_SUCCESS  COLOR_GREEN
#define COLOR_FILENAME COLOR_PURPLE
#define COLOR_LINE     COLOR_YELLOW
#define COLOR_FUNC     COLOR_BLUE
#define COLOR_SEL(x)   @"[" COLOR_BLUE(x) @"]"

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



#define LLLog DDLogInfo

#define BrynLog(__FORMAT__, ...)   LLLog(@"[" COLOR_FILENAME(@"%@") @":" COLOR_LINE(@"%d") @"] %@", __JUST_FILENAME__, __LINE__, [NSString stringWithFormat:(__FORMAT__), ##__VA_ARGS__])
#define BrynFnLog(__FORMAT__, ...) LLLog( COLOR_FUNC(@"%s ") @"%@", __func__, [NSString stringWithFormat:(__FORMAT__), ##__VA_ARGS__] )

