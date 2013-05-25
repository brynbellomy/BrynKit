//
//  BrynKitDDLogColorFormatter.h
//  BrynKit
//
//  Created by bryn austin bellomy on 2/27/2013.
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CocoaLumberjack/DDLog.h>


@interface BrynKitDDLogColorFormatter : NSObject <DDLogFormatter>

@property (atomic, assign, readwrite) BOOL shouldPrintDispatchQueueLabel;
@property (atomic, assign, readwrite) BOOL shouldPrintLogLevel;
@property (atomic, assign, readwrite) BOOL shouldPrintMostLikelyClassname;
@property (atomic, assign, readwrite) BOOL shouldPrintMethodName;
@property (atomic, assign, readwrite) BOOL shouldFilterByLogContext;
@property (atomic, strong, readwrite) NSArray *acceptableLogContexts;

@end