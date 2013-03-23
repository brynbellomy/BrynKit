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


/**
 * Custom log level setup.  Right now, this just adds 'success' to the available log levels.
 *
 * LOG_LEVEL_SUCCESS does not include LOG_LEVEL_VERBOSE, but includes everything else.
 */

#define LOG_FLAG_SUCCESS         (1 << 4)  // 0...10000
#define LOG_LEVEL_SUCCESS        (LOG_FLAG_ERROR | LOG_FLAG_WARN | LOG_FLAG_INFO | LOG_FLAG_SUCCESS) // 0...10111
#define LOG_SUCCESS              (ddLogLevel & LOG_FLAG_SUCCESS)
#define DDLogSuccess(frmt, ...)  LOG_OBJC_MAYBE(LOG_ASYNC_SUCCESS, ddLogLevel, LOG_FLAG_SUCCESS, 0, frmt, ##__VA_ARGS__)
#define DDLogCSuccess(frmt, ...) LOG_C_MAYBE(LOG_ASYNC_SUCCESS, ddLogLevel, LOG_FLAG_SUCCESS, 0, frmt, ##__VA_ARGS__)








