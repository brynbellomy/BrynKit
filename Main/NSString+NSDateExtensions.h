//
//  NSString+NSDateExtensions.h
//  Stan
//
//  Created by bryn austin bellomy on 4.23.13.
//  Copyright (c) 2013 robot bubble bath LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NSDateExtensions)

+ (instancetype) bryn_stringWithDate:(NSDate *)date usingFormat:(NSString *)format;
+ (instancetype) bryn_stringWithDate:(NSDate *)date usingStyle:(NSDateFormatterStyle)style;
+ (instancetype) bryn_stringWithDate:(NSDate *)date usingDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle;

@end