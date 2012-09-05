//
//  NSString+BrynKit.m
//  BrynKit
//  
//  Created by bryn austin bellomy on 7/18/12.
//  Copyright (c) 2012 robot bubble bath LLC. All rights reserved.
//

#import "NSString+BrynKit.h"

@implementation NSString (BrynKit)

+ (NSString *) stringWithUUID {
   CFUUIDRef uuidObj = CFUUIDCreate(nil); // create a new UUID
   // get the string representation of the UUID
   NSString	*uuidString = (NSString *)CFUUIDCreateString(nil, uuidObj);
   CFRelease(uuidObj);
   return uuidString;
}

@end