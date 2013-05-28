//
//  BrynKitDDLogColorFormatter.m
//  BrynKit
//
//  Created by bryn austin bellomy on 2/27/2013.
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//

#import <CocoaLumberjack/DDLog.h>
#import <EDColor/EDColor.h>
#import <FlatUIKit/UIColor+FlatUI.h>

#import "Bryn.h"
#import "BrynKitDebugging.h"
#import "BrynKitEDColor.h"
#import "BrynKitCocoaLumberjack.h"
#import "BrynKitLogging.h"
#import "BrynKitDDLogColorFormatter.h"
#import "UIColor+Expanded.h"

@interface BrynKitDDLogColorFormatter ()
    @property (nonatomic, strong, readwrite) NSMutableDictionary *colorForLogFlag, *nameForLogFlag;
@end

@implementation BrynKitDDLogColorFormatter

/**
 * init
 *
 * @return {instancetype}
 */
- (instancetype) init
{
    self = [super init];
    if (self)
    {
        _shouldColorize                 = YES;
        _shouldPrintDispatchQueueLabel  = YES;
        _shouldPrintLogLevel            = YES;
        _shouldPrintMostLikelyClassname = YES;
        _shouldPrintMethodName          = YES;
        _shouldFilterByLogContext       = NO;

        _colorForLogFlag = @{}.mutableCopy;
        _nameForLogFlag  = @{}.mutableCopy;

        [self setColor:[UIColor alizarinColor]    forLogFlag:LOG_FLAG_ERROR];
        [self setColor:[UIColor nephritisColor]   forLogFlag:LOG_FLAG_SUCCESS];
        [self setColor:[UIColor tangerineColor]   forLogFlag:LOG_FLAG_WARN];
        [self setColor:[UIColor belizeHoleColor]  forLogFlag:LOG_FLAG_INFO];
        [self setColor:[UIColor wetAsphaltColor]  forLogFlag:LOG_FLAG_VERBOSE];

        [self setName:@"ERROR"   forLogFlag:LOG_FLAG_ERROR];
        [self setName:@"SUCCESS" forLogFlag:LOG_FLAG_SUCCESS];
        [self setName:@"WARN"    forLogFlag:LOG_FLAG_WARN];
        [self setName:@"INFO"    forLogFlag:LOG_FLAG_INFO];
        [self setName:@"VERBOSE" forLogFlag:LOG_FLAG_VERBOSE];
    }

    return self;
}

- (void) setColor: (UIColor *)color
       forLogFlag: (NSInteger)logFlag
{
    yssert_notNilAndIsClass(color, UIColor);
    yssert(color.canProvideRGBComponents == YES, @"provided color for log flag \"%d\" is not in RGB colorspace (color = %@)", logFlag, color);

    self.colorForLogFlag[ @(logFlag) ] = color;
}

- (void) setName: (NSString *)name
      forLogFlag: (NSInteger)logFlag
{
    self.nameForLogFlag[ @(logFlag) ] = name;
}



/**
 * formatLogMessage:
 *
 * @param {DDLogMessage*} logMessage
 * @return {NSString*}
 */
- (NSString *) formatLogMessage: (DDLogMessage *)logMessageObject
{
    if (self.shouldFilterByLogContext && (self.acceptableLogContexts != nil))
    {
        BOOL found = NO;

        for (NSNumber *num in self.acceptableLogContexts)
        {
            if (num.intValue == logMessageObject->logContext)
            {
                found = YES;
                break;
            }
        }

        if (NO == found) {
            return nil;
        }
    }

    NSString *logMessage;
    NSString *logLevel = @"N/A";
    UIColor *color = self.colorForLogFlag[ @(logMessageObject->logFlag) ];

    //
    // log message
    //

    if (self.shouldColorize == NO || color == nil || [color canProvideRGBComponents] == NO)
    {
        logMessage = [logMessageObject->logMsg copy];
    }
    else
    {
        logMessage = $str(@"%@%@" XCODE_COLORS_RESET, [color bryn_xcodeColorsFGString], logMessageObject->logMsg);
    }

    //
    // log level
    //

    NSString *logLevelName = self.nameForLogFlag[ @(logMessageObject->logFlag) ];
    logLevelName = logLevelName ?: @"LOG";

    logLevel = (self.shouldColorize
                ? $str(@"%@%@" XCODE_COLORS_RESET, [color bryn_xcodeColorsFGString], logLevelName)
                : [logLevelName copy]);

    NSMutableArray *parts = [NSMutableArray array];

    //
    // dispatch queue label
    //

    if (self.shouldPrintDispatchQueueLabel)
    {
        [parts addObject: (self.shouldColorize
                               ? $str(COLOR_QUEUE(@"%s"), logMessageObject->queueLabel)
                               : $str(@"[%s]", logMessageObject->queueLabel))];
    }

    //
    // method name
    //

    if (self.shouldPrintMethodName)
    {
        NSMutableArray *methodNameParts = [NSMutableArray arrayWithCapacity:2];

        if (self.shouldPrintMostLikelyClassname) {
            [methodNameParts addObject: logMessageObject.fileName];
        }

        [methodNameParts addObject: logMessageObject.methodName];
        NSString *methodName = [methodNameParts componentsJoinedByString: @" "];

        [parts addObject: (self.shouldColorize
                               ? $str(COLOR_SEL(@"%@"), methodName)
                               : $str(@"[%@]", methodName))];
    }

    //
    // log level
    //

    if (self.shouldPrintLogLevel)
    {
        [parts addObject: $str(@"[%@]", logLevel)];
    }



    [parts addObject: logMessage];

    return [parts componentsJoinedByString: @" "];
}



@end





