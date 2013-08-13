//
//  BKNSStringSpec.m
//  BrynKit
//
//  Created by bryn austin bellomy on 7.23.13.
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import <libextobjc/EXTScope.h>

#import "BrynKit.h"

SPEC_BEGIN(BKNSStringSpec)


//
// Category methods that need to be tested:
//
//- (NSRange)    bk_rangeFromStringLength;
//- (NSString *) bk_trim;
//- (NSString *) bk_replace:(NSString *)strToReplace        with:(NSString *)replacementStr;
//- (NSString *) bk_replaceRegex:(NSString *)regexToReplace with:(NSString *)replacementStr;
//- (NSString *) bk_concat:(NSString *)string;
//- (NSString *) bk_concatPath:(NSString *)string;
//

context(@"an initialized NSString", ^{

    describe(@"when told to bk_trim", ^{

        it(@"should trim all forms of whitespace at its edges", ^{
            NSString *theString = [@" as df\r \n" bk_trim];
            NSString *expected  = @"as df";

            [[theString should] equal:expected];
        });
    });

    describe(@"when told to bk_rangeFromStringLength", ^{

        it(@"should yield an NSRange with location 0 and length equal to the string's length", ^{
            NSString *theString = @"asdf";
            NSRange   theRange  = [theString bk_rangeFromStringLength];

            [[theValue(theRange.location) should] equal:0                withDelta:0];
            [[theValue(theRange.length)   should] equal:theString.length withDelta:0];
        });

    });

    describe(@"when told to bk_replace:with:", ^{

        it(@"should return a new string where all instances of the needle substring have been replaced by the replacement string", ^{
            NSString *theString = [@"xyzzy" bk_replace:@"y" with:@"zork"];
            NSString *expected  = @"xzorkzzzork";

            [[theString should] equal:expected];
        });

        it(@"should return a copy of an identical string if no instances of the needle substring were found", ^{
            NSString *theString = [@"xyzzy" bk_replace:@"blahblahblah" with:@"zork"];
            NSString *expected  = @"xyzzy";

            [[theString should] equal:expected];
        });
        
    });
    
    describe(@"", ^{
        
    });
    
});

SPEC_END







