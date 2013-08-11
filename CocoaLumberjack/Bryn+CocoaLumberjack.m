//
//  Bryn+CocoaLumberjack.m
//  BrynKit
//
//  Created by bryn austin bellomy on 8.10.2013.
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//


#import <CocoaLumberjack/DDLog.h>
#import "Bryn+CocoaLumberjack.h"
#import "BrynKit-Main.h"


@implementation Bryn (CocoaLumberjack)

static int logLevel = LOG_LEVEL_VERBOSE;

+ (int)  ddLogLevel               { return logLevel; }
+ (void) ddSetLogLevel:(int)level { logLevel = level; }

@end
