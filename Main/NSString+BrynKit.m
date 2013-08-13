//
//  NSString+BrynKit.m
//  BrynKit
//
//  Created by bryn austin bellomy on 7.23.13.
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//

#import "NSString+BrynKit.h"

@implementation NSString (BrynKit)

- (NSRange) bk_rangeFromStringLength
{
    return NSMakeRange(0, self.length);
}

- (NSString *) bk_trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" \t\n\r"]];
}


- (NSString *) bk_replace:(NSString *)strToReplace
                     with:(NSString *)replacementStr
{
    return [self stringByReplacingOccurrencesOfString: strToReplace
                                           withString: replacementStr];
}



- (NSString *) bk_replaceRegex:(NSString *)regexToReplace
                          with:(NSString *)replacementStr
{
    return [self stringByReplacingOccurrencesOfString: regexToReplace
                                           withString: replacementStr
                                              options: NSRegularExpressionSearch
                                                range: [self bk_rangeFromStringLength]];
}



- (NSString *) bk_concat:(NSString *)string
{
    return [self stringByAppendingString:string];
}



- (NSString *) bk_concatPath:(NSString *)string
{
    return [self stringByAppendingPathComponent:string];
}

@end
