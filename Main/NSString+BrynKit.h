//
//  NSString+BrynKit.h
//  BrynKit
//
//  Created by bryn austin bellomy on 7.23.13.
//  Copyright (c) 2013 signalenvelope llc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (BrynKit)

- (NSRange)    bk_rangeFromStringLength;
- (NSString *) bk_trim;
- (NSString *) bk_replace:(NSString *)strToReplace        with:(NSString *)replacementStr;
- (NSString *) bk_replaceRegex:(NSString *)regexToReplace with:(NSString *)replacementStr;
- (NSString *) bk_concat:(NSString *)string;
- (NSString *) bk_concatPath:(NSString *)string;

@end
