//
//  BrynKitCocoaLumberjack.h
//  BrynKit
//
//  Created by bryn austin bellomy on 2/27/2013.
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//

#import <CocoaLumberjack/DDLog.h>
#import "BrynKitLogging.h"
#import "BrynKitDDLogColorFormatter.h"


#if !defined(lllog)
#   define lllog(severity, __FORMAT__, ...) metamacro_concat(BrynKitLog,severity)((__FORMAT__), ## __VA_ARGS__)
#endif

#define BrynKitLogError(__FORMAT__, ...)     SYNC_LOG_OBJC_MAYBE([SECrackRock ddLogLevel], LOG_FLAG_ERROR,   SECrackRock_LOG_CONTEXT, (__FORMAT__), ## __VA_ARGS__)
#define BrynKitLogWarn(__FORMAT__, ...)     ASYNC_LOG_OBJC_MAYBE([SECrackRock ddLogLevel], LOG_FLAG_WARN,    SECrackRock_LOG_CONTEXT, (__FORMAT__), ## __VA_ARGS__)
#define BrynKitLogInfo(__FORMAT__, ...)     ASYNC_LOG_OBJC_MAYBE([SECrackRock ddLogLevel], LOG_FLAG_INFO,    SECrackRock_LOG_CONTEXT, (__FORMAT__), ## __VA_ARGS__)
#define BrynKitLogVerbose(__FORMAT__, ...)  ASYNC_LOG_OBJC_MAYBE([SECrackRock ddLogLevel], LOG_FLAG_VERBOSE, SECrackRock_LOG_CONTEXT, (__FORMAT__), ## __VA_ARGS__)





