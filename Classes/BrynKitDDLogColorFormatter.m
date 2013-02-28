
#import <CocoaLumberjack/DDLog.h>
#import "BrynKitLogging.h"
#import "BrynKitDDLogColorFormatter.h"

@implementation BrynKitDDLogColorFormatter

- (NSString *)formatLogMessage:(DDLogMessage *)logMessage
{
    NSString *colorized;
    switch (logMessage->logFlag)
    {
        case LOG_FLAG_ERROR   : colorized = [NSString stringWithFormat:COLOR_ERROR(@"[ERROR] %@"),   logMessage->logMsg]; break;
        case LOG_FLAG_WARN    : colorized = [NSString stringWithFormat:COLOR_WARN(@"[WARN] %@"),    logMessage->logMsg]; break;
        case LOG_FLAG_INFO    : colorized = [NSString stringWithFormat:COLOR_INFO(@"[INFO] %@"),    logMessage->logMsg]; break;
        case LOG_FLAG_VERBOSE : colorized = [NSString stringWithFormat:COLOR_VERBOSE(@"[VERBOSE] %@"), logMessage->logMsg]; break;
        default               : colorized = logMessage->logMsg; break;
    }

    NSString *colorFunc = [NSString stringWithFormat: COLOR_SEL(@"%@"), logMessage.methodName];
    return [NSString stringWithFormat:@"%@ %@", colorFunc, colorized];
}


@end




