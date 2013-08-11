//
//  BKFloatRange.h
//  BrynKit
//
//  Created by bryn austin bellomy on 7.27.13.
//  Copyright (c) 2013 signalenvelope llc. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef struct _BKFloatRange {
    Float32 location;
    Float32 length;
} BKFloatRange;

#define BKFloatRangeZero BKMakeFloatRange(0.0f, 0.0f)
#define BKFloatRangeOne  BKMakeFloatRange(1.0f, 0.0f)

/**
 * Creates a `BKFloatRange` initialized with the provided `loc` (location) and `len` (length) values.
 *
 *  @param loc Where the range should begin.
 *  @param len The length of the range.
 *  @return A `BKFloatRange` representing a continuous range from `loc` to `loc + len`.
*/
extern BKFloatRange BKMakeFloatRange( const Float32 loc, const Float32 len ) __attribute__(( const ));

/**
 * Creates a `BKFloatRange` initialized with `loc = start` and `len = end - start`.
 *
 * @param start Where the range should begin.
 * @param end Where the range should end.
 * @return A `BKFloatRange representing a continuous range from `start` to `end`.
 **/
extern BKFloatRange BKMakeFloatRangeWithBounds( const Float32 start, const Float32 end ) __attribute__(( const ));
extern BKFloatRange BKMakeZeroLengthFloatRange( const Float32 location ) __attribute__(( const ));

extern Float32 BKFloatRangeStartValue( const BKFloatRange range ) __attribute__(( const ));
extern Float32 BKFloatRangeEndValue( const BKFloatRange range )   __attribute__(( const ));
extern Float32 BKMinValueInFloatRange( const BKFloatRange range ) __attribute__(( const ));
extern Float32 BKMaxValueInFloatRange( const BKFloatRange range ) __attribute__(( const ));

extern BOOL BKIsLocationInFloatRange( const Float32 loc, const BKFloatRange range ) __attribute__(( const ));
extern BOOL BKFloatRangesAreEqual( const BKFloatRange range1,  const BKFloatRange range2 ) __attribute__(( const ));

