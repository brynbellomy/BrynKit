//
//  Bryn.h
//
//  Created by bryn austin bellomy on 7/18/12.
//  Copyright (c) 2012 robot bubble bath LLC. All rights reserved.
//

#ifndef __Bryn__
#define __Bryn__  // is this even possible????

#import <ConciseKit/ConciseKit.h>
#import <Underscore.m/Underscore.h>



/*************************************/
#pragma mark- settable settings
#pragma mark-
/*************************************/

#define VERBOSE_NSLOG 0 // if set to 1, this will add the filename and line num to NSLog calls
#define SILENCE_NSLOG 0 // if set to 1, all calls to NSLog become no-ops
#define LOG_MACROS_ARE_ACTIVE 1 // easily turn off all changes to logging
#define NSLOG_TO_TESTFLIGHT 1 // redirect all NSLog() calls to TFLog(), which sends them to TestFlight



/*************************************/
#pragma mark- typedefs
#pragma mark-
/*************************************/

typedef void(^BoolBlock)(BOOL success);
typedef void(^UIntBlock)(NSUInteger i);
typedef void(^NotificationBlock)(NSNotification *);

typedef enum {
  DispatchSourceState_Suspended = (1 << 0),
  DispatchSourceState_Resumed = (1 << 1),
  DispatchSourceState_Canceled = (1 << 2)
} DispatchSourceState;



/*************************************/
#pragma mark- logging and debug macros
#pragma mark-
/*************************************/

#define XCODE_COLORS_ESCAPE @"\033["

#define XCODE_COLORS_RESET_FG  XCODE_COLORS_ESCAPE @"fg;" // Clear any foreground color
#define XCODE_COLORS_RESET_BG  XCODE_COLORS_ESCAPE @"bg;" // Clear any background color
#define XCODE_COLORS_RESET     XCODE_COLORS_ESCAPE @";"   // Clear any foreground or background color

static inline void BrynColorLog(NSString *msg, NSUInteger red, NSUInteger green, NSUInteger blue) {
  NSLog([NSString stringWithFormat:@"%@fg%d,%d,%d;%@%@", XCODE_COLORS_ESCAPE, red, green, blue, msg, XCODE_COLORS_RESET_FG]);
}

// __FILE__ contains the entire path to a file.  this #define only gives you the file's actual name.
#define __JUST_FILENAME__ [[NSString stringWithUTF8String:__FILE__] lastPathComponent]

#if LOG_MACROS_ARE_ACTIVE == 1

  // redirect all NSLog() calls to TFLog(), the TestFlight logging function
  #if NSLOG_TO_TESTFLIGHT == 1
    #define NSLog TFLog
  #endif

  // this is the macro that replaces NSLog if you have VERBOSE_NSLOG set to 1.  if you want to use it
  // without replacing NSLog, leave VERBOSE_NSLOG set to 0 and just call BrynLog.
  #define BrynLog(__FORMAT__, ...) NSLog(@"[%@:%d] %@", __JUST_FILENAME__, __LINE__, [NSString stringWithFormat:__FORMAT__, ##__VA_ARGS__])

  // replace NSLog with BrynLog
  #if VERBOSE_NSLOG == 1
    #define NSLog(__FORMAT__, ...) BrynLog(__FORMAT__, ##__VA_ARGS__)
  #endif

  // replace NSLog with a no-op
  #if SILENCE_NSLOG == 1
    #define NSLog(__FORMAT__, ...) do{}while(0)
  #endif

  // like BrynLog except it logs the function/selector name instead of the file and line num.
  #define BrynFnLog(__FORMAT__, ...) (NSLog(@"%s > %@", __func__, [NSString stringWithFormat:(__FORMAT__), ##__VA_ARGS__]))

#else

  #define BrynLog(__FORMAT__, ...) do{}while(0)
  #define BrynFnLog(__FORMAT__, ...) do{}while(0)

#endif



/*************************************/
#pragma mark- image-related macros
#pragma mark-
/*************************************/

// UIImageWithBundlePNG(filenameWithoutExtension)
//
// load a PNG file from the main bundle.  people use +[UIImage imageNamed:]
// because it's much easier than the (minimum) method calls you have to make to
// load a UIImage the 'right' way.  with a macro like this, there's no excuse.
// note: the image filename you pass to this macro should not contain its file
// extension (".png").
#if !defined(UIImageWithBundlePNG)
  #define UIImageWithBundlePNG(x) ([UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:(x) ofType: @"png"]])
#endif



/*************************************/
#pragma mark- container-related macros
#pragma mark-
/*************************************/

// SEObjectAtIndex(array, index)
//
// calls [array objectAtIndex:index], but first checks to make sure that the
// array contains enough elements to even HAVE an object at the given index.  
// warning: you may fail to notice bugs in your code when using this macro.
// exceptions get thrown for a reason, y'heard?
#if !defined (SEObjectAtIndex)
  #define SEObjectAtIndex(array, index) (array.count >= (index + 1) ? array[ index ] : nil)
#endif



/*************************************/
#pragma mark- objective-c literal support on iOS < 6
#pragma mark-
/*************************************/

#ifndef __IPHONE_6_0

  // redefining YES and NO allows us to use @YES and @NO for NSNumber'd BOOLs
  // Provided by James Webster on StackOverFlow
  #if __has_feature(objc_bool) 
    #undef YES
    #undef NO 
    #define YES __objc_yes 
    #define NO __objc_no 
  #endif 

  // boxed values
  #define b(x)  [NSNumber numberWithInteger:(x)]
  #define bu(x) [NSNumber numberWithUnsignedInteger:(x)]
  #define bf(x) [NSNumber numberWithFloat:(x)]
  #define bd(x) [NSNumber numberWithDouble:(x)]
  #define bb(x) [NSNumber numberWithBool:(x)]


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



/*************************************/
#pragma mark- ARC/non-ARC compatibility helpers
#pragma mark-
/*************************************/

// everything in this section comes courtesy of the fantastic MBProgressHUD
// class by matej bukovinski [http://github.com/jdg/MBProgressHUD]

#ifndef bryn_strong
  #if __has_feature(objc_arc)
    #define bryn_strong strong
  #else
    #define bryn_strong retain
  #endif
#endif // bryn_strong

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


/*************************************/
#pragma mark- GCD/concurrency helpers
#pragma mark-
/*************************************/

static inline void dispatch_safe_sync(dispatch_queue_t queue, dispatch_block_t block) {
  if (dispatch_get_current_queue() == queue)
    block();
  else
    dispatch_sync(queue, block);
}



/*************************************/
#pragma mark- memory stuff (probably not app store safe)
#pragma mark-
/*************************************/

#if DEBUG
  #import <mach/mach.h>
  #import <mach/mach_host.h>

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
      printf("======================\nfree memory: %f\n=====================\n", (double)(freeMemBytes / (1024 * 1024)));
    });
    
    // now that our timer is all set to go, start it
    dispatch_resume(timer);
  }
#endif



#endif // __Bryn__

