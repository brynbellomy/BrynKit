
#import <Foundation/Foundation.h>
#import <CocoaLumberjack/DDLog.h>

@interface BrynKitDDLogColorFormatter : NSObject <DDLogFormatter>
{
    int atomicLoggerCount;
    NSDateFormatter *threadUnsafeDateFormatter;
}
@end