//
//  BrynKitDDLogColorFormatter.m
//  BrynKit
//
//  Created by bryn austin bellomy on 2/27/2013.
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//

#import <CocoaLumberjack/DDLog.h>

#import "BrynKitCocoaLumberjack.h"
#import "BrynKitLogging.h"
#import "BrynKitDDLogColorFormatter.h"

@implementation BrynKitDDLogColorFormatter

/**
 * init
 *
 * @return {instancetype}
 */
- (instancetype) init
{
    self = [super init];

    if (self) {
        _shouldPrintDispatchQueueLabel  = YES;
        _shouldPrintLogLevel            = YES;
        _shouldPrintMostLikelyClassname = YES;
        _shouldPrintMethodName          = YES;
        _shouldFilterByLogContext       = NO;
    }

    return self;
}



/**
 * formatLogMessage:
 *
 * @param {DDLogMessage*} logMessage
 * @return {NSString*}
 */
- (NSString *) formatLogMessage: (DDLogMessage *)logMessage
{
    if (self.shouldFilterByLogContext && (self.acceptableLogContexts != nil)) {
        BOOL found = NO;

        for (NSNumber *num in self.acceptableLogContexts) {
            if (num.intValue == logMessage->logContext) {
                found = YES;
                break;
            }
        }

        if (NO == found) {
            return nil;
        }
    }

    NSString *logMessageColorized;
    NSString *logLevel = @"N/A";
    switch (logMessage->logFlag) {
        case LOG_FLAG_ERROR:
            logMessageColorized = [NSString stringWithFormat: COLOR_ERROR(@"%@"), logMessage->logMsg]; logLevel = COLOR_ERROR(@"ERROR"); break;

        case LOG_FLAG_SUCCESS:
            logMessageColorized = [NSString stringWithFormat: COLOR_SUCCESS(@"%@"), logMessage->logMsg]; logLevel = COLOR_SUCCESS(@"SUCCESS"); break;

        case LOG_FLAG_WARN:
            logMessageColorized = [NSString stringWithFormat: COLOR_WARN(@"%@"), logMessage->logMsg]; logLevel = COLOR_WARN(@"WARN"); break;

        case LOG_FLAG_INFO:
            logMessageColorized = [NSString stringWithFormat: COLOR_INFO(@"%@"), logMessage->logMsg]; logLevel = COLOR_INFO(@"INFO"); break;

        case LOG_FLAG_VERBOSE:
            logMessageColorized = [NSString stringWithFormat: COLOR_VERBOSE(@"%@"), logMessage->logMsg]; logLevel = COLOR_VERBOSE(@"VERBOSE"); break;

        default:
            logMessageColorized = logMessage->logMsg; break;
    }

    NSMutableArray *parts = NSMutableArray.array;

    if (self.shouldPrintDispatchQueueLabel)
        [parts addObject: [NSString stringWithFormat: COLOR_QUEUE(@"%s"), logMessage->queueLabel]];

    if (self.shouldPrintMethodName)
    {
        NSMutableArray *methodNameParts = @[].mutableCopy;

        if (self.shouldPrintMostLikelyClassname)
            [methodNameParts addObject: logMessage.fileName];

        [methodNameParts addObject: logMessage.methodName];
        NSString *methodName = [methodNameParts componentsJoinedByString: @" "];

        [parts addObject: [NSString stringWithFormat: COLOR_SEL(@"%@"), methodName]];
    }

    if (self.shouldPrintLogLevel)
        [parts addObject: [NSString stringWithFormat: @"[%@]", logLevel]];


    
    [parts addObject: logMessageColorized];

    return [parts componentsJoinedByString: @" "];
}



@end
