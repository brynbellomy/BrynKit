//
//  NSString+BrynKit_Dates.m
//  BrynKit
//
//  Created by bryn austin bellomy on 4.23.13.
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//

#import "NSString+BrynKit_Dates.h"

@implementation NSString (BrynKit_Dates)

+ (instancetype) bk_stringWithDate: (NSDate *)date
                       usingFormat: (NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat       = format;
    return [dateFormatter stringFromDate: date];
}

+ (instancetype) bk_stringWithDate: (NSDate *)date
                        usingStyle: (NSDateFormatterStyle)style
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = style;
    dateFormatter.timeStyle = style;
    return [dateFormatter stringFromDate: date];
}

+ (instancetype) bk_stringWithDate: (NSDate *)date
                    usingDateStyle: (NSDateFormatterStyle)dateStyle
                         timeStyle: (NSDateFormatterStyle)timeStyle
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = dateStyle;
    dateFormatter.timeStyle = timeStyle;
    return [dateFormatter stringFromDate: date];
}

@end
