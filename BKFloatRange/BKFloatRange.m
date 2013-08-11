//
//  BKFloatRange.m
//  BrynKit
//
//  Created by bryn austin bellomy on 7.27.13.
//  Copyright (c) 2013 signalenvelope llc. All rights reserved.
//

#import "BKFloatRange.h"


BKFloatRange BKMakeFloatRange( const Float32 loc, const Float32 len )
{
    BKFloatRange r;
    r.location = loc;
    r.length = len;
    return r;
}

BKFloatRange BKMakeFloatRangeWithBounds( const Float32 start, const Float32 end )
{
    BKFloatRange r;
    r.location = start;
    r.length = end - start;
    return r;
}

BKFloatRange BKMakeZeroLengthFloatRange( const Float32 location )
{
    BKFloatRange r;
    r.location = location;
    r.length = 0;
    return r;
}

Float32 BKFloatRangeStartValue( const BKFloatRange range ) { return BKMinValueInFloatRange(range); }
Float32 BKFloatRangeEndValue( const BKFloatRange range )   { return BKMaxValueInFloatRange(range); }
Float32 BKMinValueInFloatRange( const BKFloatRange range ) { return range.location; }
Float32 BKMaxValueInFloatRange( const BKFloatRange range ) { return range.location + range.length; }

BOOL BKIsLocationInFloatRange( const Float32 loc, const BKFloatRange range)       { return loc - range.location < range.length; }
BOOL BKFloatRangesAreEqual( const BKFloatRange range1, const BKFloatRange range2) { return range1.location == range2.location && range1.length == range2.length; }


