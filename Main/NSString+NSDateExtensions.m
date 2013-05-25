//
//  NSString+NSDateExtensions.m
//  Stan
//
//  Created by bryn austin bellomy on 4.23.13.
//  Copyright (c) 2013 robot bubble bath LLC. All rights reserved.
//

#import "NSString+NSDateExtensions.h"

@implementation NSString (NSDateExtensions)

+ (instancetype) bryn_stringWithDate: (NSDate *)date
                         usingFormat: (NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat       = format;
    return [dateFormatter stringFromDate: date];
}

@end
