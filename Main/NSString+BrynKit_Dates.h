//
//  NSString+BrynKit_Dates.m
//  BrynKit
//
//  Created by bryn austin bellomy on 4.23.13.
//  Copyright (c) 2013 robot bubble bath LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (BrynKit_Dates)

+ (instancetype) bk_stringWithDate:(NSDate *)date usingFormat:(NSString *)format;
+ (instancetype) bk_stringWithDate:(NSDate *)date usingStyle:(NSDateFormatterStyle)style;
+ (instancetype) bk_stringWithDate:(NSDate *)date usingDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle;

@end
