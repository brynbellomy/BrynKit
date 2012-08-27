//
//  Bryn.h  
//  BrynKit
//  
//  Created by bryn austin bellomy on 7/18/12.  
//  Copyright (c) 2012 robot bubble bath LLC. All rights reserved.
//

#ifndef __Bryn__
#define __Bryn__  // is this even possible????

/**
 * # Settable settings
 *
 * - **VERBOSE_NSLOG**: if set to 1, this will add the filename and line num to NSLog calls
 * - **SILENCE_NSLOG**: if set to 1, all calls to NSLog become no-ops
 * - **LOG\_MACROS\_ARE\_ACTIVE**: easily turn off all changes to logging
 * - **NSLOG\_TO\_TESTFLIGHT**: redirect all `NSLog()` calls to `TFLog()`, which sends them to TestFlight
 * - **AUTOMATIC\_LOG\_COLORS**: automatically colorize `NSLog()` output in the xcode console
 */
#pragma mark- settable settings
#pragma mark-

#define VERBOSE_NSLOG 0
#define SILENCE_NSLOG 0
#define LOG_MACROS_ARE_ACTIVE 1
#define NSLOG_TO_TESTFLIGHT 0
#define AUTOMATIC_LOG_COLORS 1



/**
 * # Typedefs
 */
#pragma mark- typedefs
#pragma mark-

/**
 * ### Blocks
 * 
 * Saves a little bit of tedious typing.
 */
typedef void(^BoolBlock)(BOOL success);
typedef void(^UIntBlock)(NSUInteger i);
typedef void(^NotificationBlock)(NSNotification *);

/**
 * ### enum DispatchSourceState
 * 
 * Use this to keep track of the state of `dispatch_source` objects so that you don't
 * over-resume them, try to cancel them when they're suspended, etc.
 */
typedef enum {
  DispatchSourceState_Suspended = (1 << 0),
  DispatchSourceState_Resumed = (1 << 1),
  DispatchSourceState_Canceled = (1 << 2)
} DispatchSourceState;



/**
 * # Logging and debug macros
 */
#pragma mark- logging and debug macros
#pragma mark-

/**
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

/**
 * ### predefined rgb colors
 *
 * These macros evaluate to a regular NSString literal, so you can simply
 * concatenate them into an NSString expression like so:
 *
 * `NSLog(@"Blah blah" COLOR_RED @"This will be red" XCODE_COLORS_RESET @"This will not");`
 */
#define COLOR_RED      XCODE_COLORS_FG(178,34,34)
#define COLOR_YELLOW   XCODE_COLORS_FG(255,185,0)
#define COLOR_OLIVE    XCODE_COLORS_FG(85,107,47)
#define COLOR_GREEN    XCODE_COLORS_FG(34,139,34)
#define COLOR_PURPLE   XCODE_COLORS_FG(132,112,255)
#define COLOR_BLUE     XCODE_COLORS_FG(30,144,255)

/**
 * ### a simple predefined color logging 'theme'
 *
 * Just as with the predefined RGB colors above, you can concatenate
 * these into a plain ol' NSString expression:
 *
 * `NSLog(COLOR_ERROR(@"You screwed up") @"... but it'll be okay.");`
 */
#define COLOR_ERROR(x)    COLOR_RED    x XCODE_COLORS_RESET
#define COLOR_SUCCESS(x)  COLOR_GREEN  x XCODE_COLORS_RESET
#define COLOR_FILENAME(x) COLOR_PURPLE x XCODE_COLORS_RESET
#define COLOR_LINE(x)     COLOR_YELLOW x XCODE_COLORS_RESET
#define COLOR_FUNC(x)     COLOR_BLUE   x XCODE_COLORS_RESET

/**
 * ### BrynEnableColorLogging()
 * 
 * Enables XcodeColors (you obviously have to install it too).  Call this from
 * your `main()` function, or something else sufficiently early.
 */
#define BrynEnableColorLogging() setenv("XcodeColors", "YES", 0);

/**
 * ### BrynDisableColorLogging()
 * 
 * Disables XcodeColors.
 */
#define BrynDisableColorLogging() setenv("XcodeColors", "NO", 0);

/**
 * ### \_\_JUST_FILENAME\_\_
 * 
 * `__FILE__` contains the entire path to a file.  this `#define` only gives you the file's actual name.
 */
#define __JUST_FILENAME__ [[NSString stringWithUTF8String:__FILE__] lastPathComponent]



#if LOG_MACROS_ARE_ACTIVE == 1

  // redirect all NSLog() calls to TFLog(), the TestFlight logging function
  #if NSLOG_TO_TESTFLIGHT == 1
    #define NSLog TFLog
  #endif

  // this is the macro that replaces NSLog if you have VERBOSE_NSLOG set to 1.  if you want to use it
  // without replacing NSLog, leave VERBOSE_NSLOG set to 0 and just call BrynLog.
  #if AUTOMATIC_LOG_COLORS == 1
    #define BrynLog(__FORMAT__, ...) (NSLog(@"[" COLOR_FILENAME(@"%@") @":" COLOR_LINE(@"%d") @"] %@", \
                                              __JUST_FILENAME__, __LINE__, [NSString stringWithFormat:__FORMAT__, ##__VA_ARGS__]))
  #else
    #define BrynLog(__FORMAT__, ...) (NSLog(@"[%@:%d] %@", __JUST_FILENAME__, __LINE__, [NSString stringWithFormat:__FORMAT__, ##__VA_ARGS__]))
  #endif

  // replace NSLog with BrynLog
  #if VERBOSE_NSLOG == 1
    #define NSLog(__FORMAT__, ...) BrynLog(__FORMAT__, ##__VA_ARGS__)
  #endif

  // replace NSLog with a no-op
  #if SILENCE_NSLOG == 1
    #define NSLog(__FORMAT__, ...) do{}while(0)
  #endif

  // like BrynLog except it logs the function/selector name instead of the file and line num.
  #if AUTOMATIC_LOG_COLORS == 1
    #define BrynFnLog(__FORMAT__, ...) (NSLog( \
                                          COLOR_FUNC(@"%s ") @"%@", \
                                          __func__, [NSString stringWithFormat:(__FORMAT__), ##__VA_ARGS__]))
  #else
    #define BrynFnLog(__FORMAT__, ...) (NSLog(@"%s %@", __func__, [NSString stringWithFormat:(__FORMAT__), ##__VA_ARGS__]))
  #endif
#else

  #define BrynLog(__FORMAT__, ...) do{}while(0)
  #define BrynFnLog(__FORMAT__, ...) do{}while(0)

#endif



/**
 * # Image-related macros
 */
#pragma mark- image-related macros
#pragma mark-

/**
 * ### UIImageWithBundlePNG()
 *
 * Load a PNG file from the main bundle.  People use +[UIImage imageNamed:]
 * because it's much easier than the (minimum) method calls you have to make to
 * load a UIImage the 'right' way.  With a macro like this, there's no excuse.
 * Note: the image filename you pass to this macro should not contain its file
 * extension (".png").
 * 
 * @param {NSString*} filename The filename of the image without its ".png" extension.
 */
#if !defined(UIImageWithBundlePNG)
  #define UIImageWithBundlePNG(x) ([UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:(x) ofType: @"png"]])
#endif



/**
 * # Container-related macros
 */
#pragma mark- container-related macros
#pragma mark-

/**
 * ### SEObjectAtIndex()
 *
 * Calls `[array objectAtIndex:index]`, but first checks to make sure that the
 * array contains enough elements to even HAVE an object at the given index.
 * Warning: you may fail to notice bugs in your code when using this macro.
 * Exceptions get thrown for a reason, y'heard?
 *
 * @param {NSArray*} array The array to be queried.
 * @param {NSUInteger} index The index of the item.
 * @return {NSObject*} Either `nil` or the object at the specified index in the array.
 */
#if !defined (SEObjectAtIndex)
  #define SEObjectAtIndex(array, index) (array.count >= (index + 1) ? array[ index ] : nil)
#endif



/**
 * # Objective-c literals on iOS < 6
 *
 * This is just a band-aid until Xcode 4.5 is released.
 */
#pragma mark- objective-c literal support on iOS < 6
#pragma mark-

#ifndef __IPHONE_6_0

  // redefining `YES` and `NO` allows us to use `@YES` and
  // `@NO` for `NSNumber`-ified `BOOL`s.  (Provided by James Webster on StackOverflow)
  #if __has_feature(objc_bool) 
    #undef YES
    #undef NO 
    #define YES __objc_yes 
    #define NO __objc_no 
  #endif 

  // Shorthand for boxed values until we can use `@(...)`
  #define b(x)  [NSNumber numberWithInteger:(x)]
  #define bu(x) [NSNumber numberWithUnsignedInteger:(x)]
  #define bf(x) [NSNumber numberWithFloat:(x)]
  #define bd(x) [NSNumber numberWithDouble:(x)]
  #define bb(x) [NSNumber numberWithBool:(x)]


  // These methods are implemented in `Bryn.m`.

  @interface NSArray (Indexing)
  - (id)objectAtIndexedSubscript:(NSUInteger)idx;
  @end

  @interface NSMutableArray (Indexing)
  - (void)setObject:(id)obj atIndexedSubscript:(NSUInteger)idx;
  @end

  @interface  NSDictionary (Indexing)
  - (id)objectForKeyedSubscript:(id)key;
  @end

  @interface  NSMutableDictionary (Indexing)
  - (void)setObject:(id)obj forKeyedSubscript:(id)key;
  @end

#endif



/**
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


/**
 * # GCD/concurrency helpers
 */
#pragma mark- GCD/concurrency helpers
#pragma mark-

/**
 * ### dispatch_safe_sync()
 *
 * Exactly like `dispatch_sync()`, except that it prevents you from deadlocking
 * the current queue by calling `dispatch_sync()` on it.  If the `queue`
 * parameter turns out to be the current queue, it will just call `block()`.
 *
 * @param {dispatch_queue_t} queue The queue on which to execute the block.
 * @param {dispatch_block_t} block The block to execute.
 */
static inline void dispatch_safe_sync(dispatch_queue_t queue, dispatch_block_t block) {
  if (dispatch_get_current_queue() == queue)
    block();
  else
    dispatch_sync(queue, block);
}



/**
 * # Memory tools
 */
#pragma mark- memory stuff (possibly not app store safe)
#pragma mark-

#if DEBUG
  #import <mach/mach.h>
  #import <mach/mach_host.h>

/**
 * ### get_free_memory()
 *
 * Returns the amount of free memory on the device.
 *
 * @return {natural_t} The amount of free memory in bytes.
 */
  static inline natural_t get_free_memory() {
    mach_port_t host_port;
    mach_msg_type_number_t host_size;
    vm_size_t pagesize;
    host_port = mach_host_self();
    host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    host_page_size(host_port, &pagesize);
    vm_statistics_data_t vm_stat;
    if (host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size) != KERN_SUCCESS) {
      NSLog(@"Failed to fetch vm statistics");
      return 0;
    }
    /* Stats in bytes */
    natural_t mem_free = vm_stat.free_count * pagesize;
    return mem_free;
  }

/**
 * ### startOccasionalMemoryLog()
 *
 * Starts a GCD timer that spits out the memory currently available on the
 * device every few seconds.
 */
  static inline void startOccasionalMemoryLog() {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    // create our timer source
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    NSUInteger step = 3; // 3 seconds
    dispatch_source_set_timer(timer,
                              dispatch_time(DISPATCH_TIME_NOW, step * NSEC_PER_SEC),
                              step * NSEC_PER_SEC,
                              step * NSEC_PER_SEC);
    
    dispatch_source_set_event_handler(timer, ^{
      natural_t freeMemBytes = get_free_memory();
#if AUTOMATIC_LOG_COLORS == 1
      NSLog(COLOR_OLIVE @"====================== free memory: %f\n" XCODE_COLORS_RESET, (double)(freeMemBytes / (1024 * 1024)));
#else
      NSLog(@"======================\nfree memory: %f\n", (double)(freeMemBytes / (1024 * 1024)));
#endif
    });
    
    // now that our timer is all set to go, start it
    dispatch_resume(timer);
  }
#endif



#endif // __Bryn__

