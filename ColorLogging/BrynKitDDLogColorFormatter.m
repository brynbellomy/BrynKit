//
//  BrynKitDDLogColorFormatter.m
//  BrynKit
//
//  Created by bryn austin bellomy on 2/27/2013.
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//

#import <CocoaLumberjack/DDLog.h>

#import "BrynKitDDLogColorFormatter.h"
#import "BrynKit-Main.h"
#import "BrynKitCocoaLumberjack.h"
#import "UIColor+Expanded.h"
#import "UIColor+BrynKit_ColorLogging.h"

//
// @@TODO: refactor this
//
@interface UIColor (BrynKitDDLogColorFormatter)
    + (UIColor *) colorFromHexCode:(NSString *)hexString;
@end

@implementation UIColor (BrynKitDDLogColorFormatter)

+ (UIColor *) colorFromHexCode:(NSString *)hexString
{
    NSString *cleanString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if([cleanString length] == 3) {
        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                       [cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)],
                       [cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)],
                       [cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
    }
    if([cleanString length] == 6) {
        cleanString = [cleanString stringByAppendingString:@"ff"];
    }

    unsigned int baseValue;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];

    float red = ((baseValue >> 24) & 0xFF)/255.0f;
    float green = ((baseValue >> 16) & 0xFF)/255.0f;
    float blue = ((baseValue >> 8) & 0xFF)/255.0f;
    float alpha = ((baseValue >> 0) & 0xFF)/255.0f;

    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

@end



@interface BrynKitDDLogColorFormatter ()
    @property (nonatomic, strong, readwrite) NSMutableDictionary *colorForLogFlag;
    @property (nonatomic, strong, readwrite) NSMutableDictionary *nameForLogFlag;
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

        [self setColor:[UIColor colorFromHexCode:@"E74C3C"]  forLogFlag:LOG_FLAG_ERROR];
        [self setColor:[UIColor colorFromHexCode:@"27AE60"]  forLogFlag:LOG_FLAG_SUCCESS];
        [self setColor:[UIColor colorFromHexCode:@"F39C12"]  forLogFlag:LOG_FLAG_WARN];
        [self setColor:[UIColor colorFromHexCode:@"2980B9"]  forLogFlag:LOG_FLAG_INFO];
        [self setColor:[UIColor colorFromHexCode:@"34495E"]  forLogFlag:LOG_FLAG_VERBOSE];

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
    yssert_notNilAndIsClass( color, UIColor );
    yssert( color.canProvideRGBComponents, @"provided color for log flag \"%d\" is not in RGB colorspace (color = %@)", logFlag, color );

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
- (NSString *)formatLogMessage:(DDLogMessage *)logMessageObject
{
    if (self.shouldFilterByLogContext && (self.acceptableLogContexts != nil))
    {
        BOOL found = [self.acceptableLogContexts containsObject:@( logMessageObject->logContext )];

        if (NO == found) {
            return nil;
        }
    }

    NSString *logMessage;
    NSString *logLevel = @"N/A";
    UIColor *color = self.colorForLogFlag[ @( logMessageObject->logFlag ) ];

    //
    // log message
    //

    if ( !self.shouldColorize || !color || !color.canProvideRGBComponents )
    {
        logMessage = [logMessageObject->logMsg copy];
    }
    else
    {
        logMessage = $str(@"%@%@" XCODE_COLORS_RESET, [color bk_xcodeColorsFGString], logMessageObject->logMsg);
    }

    //
    // log level
    //

    NSString *logLevelName = self.nameForLogFlag[ @(logMessageObject->logFlag) ];
    logLevelName = logLevelName ?: @"LOG";

    logLevel = (self.shouldColorize
                ? $str(@"%@%@" XCODE_COLORS_RESET, [color bk_xcodeColorsFGString], logLevelName)
                : [logLevelName copy]);

    NSMutableArray *parts = [NSMutableArray array];

    //
    // dispatch queue label
    //

    if (self.shouldPrintDispatchQueueLabel)
    {
        [parts addObject: (self.shouldColorize
                               ? $str(COLOR_GCD_QUEUE(@"%s"), logMessageObject->queueLabel)
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





