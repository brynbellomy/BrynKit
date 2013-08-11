//
//  Bryn.m
//  BrynKit
//
//  Created by bryn austin bellomy on 7/29/12.
//  Copyright (c) 2012 bryn austin bellomy. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

#import "Bryn.h"
#import "BrynKit-Main.h"

@implementation Bryn
@end

/**---------------------------------------------------------------------------------------
 * @name Categories: Foundation
 *  ---------------------------------------------------------------------------------------
 */

#pragma mark- Categories: Foundation
#pragma mark-

@implementation NSNumber (BrynKit)

- (BOOL) bk_isYes
{
    return self.bk_bool;
}



- (BOOL) bk_isNo
{
    return !self.bk_bool;
}


@end

@implementation NSRegularExpression (BrynKit)

#define BKHandleErrors(EXPR, ...) \
     ({ \
        @nserror( error ); \
\
        id var = ( EXPR ); \
\
        metamacro_foreach(_bk_handleErrors_iter,, __VA_ARGS__) \
\
        var; \
    });

#define _bk_handleErrors_iter(INDEX, ARG) \
    ARG ( error );


+ (NSArray *) bk_resultsOfRegex:(NSString *)strPattern inString:(NSString *)haystack
{
    NSRegularExpression *regex =
        BKHandleErrors({ [NSRegularExpression regularExpressionWithPattern:strPattern options:0 error:&error]; }, BKErrorLog, BKErrorReturnNil);

    NSArray *arTextCheckingResults = [regex matchesInString:haystack options:0 range:NSMakeRange(0, [haystack length])];

    NSMutableArray *results = @[].mutableCopy;
    for ( NSTextCheckingResult *ntcr in arTextCheckingResults )
    {
        for ( NSUInteger captureIndex = 1; captureIndex < ntcr.numberOfRanges; captureIndex++ )
        {
            NSString * capture = [haystack substringWithRange:[ntcr rangeAtIndex:captureIndex]];
            [results addObject:capture];
        }
    }

    return [NSArray arrayWithArray:results];
}


@end












