//
//  BrynKitEDColor.h
//  BrynKit
//
//  Created by bryn austin bellomy on 2/27/2013.
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//

#import <EDColor/EDColor.h>

/**
 * # EDColor extensions
 */

/**
 * #### CCCrayola()
 *
 * Another color-logging macro.
 *
 * @param {NSString*} whichColor The name of the Crayola color (from `EDColor/Crayola.h`) in which to print the string.
 * @param {NSString*} msg The string to colorize.
 * @return {NSString*} The colorized string.
 */
#define CCCrayola(whichColor, msg, ...) \
    ({ \
        UIColor *c = [UIColor colorWithCrayola: (whichColor)]; \
        CGFloat r, g, b, a; \
        [c getRed:&r green:&g blue:&b alpha:&a]; \
        r *= 255.0f; \
        g *= 255.0f; \
        b *= 255.0f; \
        [NSString stringWithFormat: XCODE_COLORS_ESCAPE @"fg%d,%d,%d;%@" XCODE_COLORS_RESET, (int)r, (int)g, (int)b, [NSString stringWithFormat:msg, ## __VA_ARGS__]]; \
    })



#undef COLOR_ERROR
#define COLOR_ERROR(fmt, ...) CCCrayola(@"Scarlet", fmt, ## __VA_ARGS__)

#undef COLOR_SUCCESS
#define COLOR_SUCCESS(fmt) CCCrayola(@"Screamin'Green", fmt, ## __VA_ARGS__)

#undef COLOR_FILENAME
#define COLOR_FILENAME(fmt) CCCrayola(@"PurpleHeart", fmt, ## __VA_ARGS__)

#undef COLOR_LINE
#define COLOR_LINE(fmt) CCCrayola(@"Sunglow", fmt, ## __VA_ARGS__)

#undef COLOR_FUNC
#define COLOR_FUNC(fmt) CCCrayola(@"Aquamarine", fmt, ## __VA_ARGS__)

#undef COLOR_SEL
#define COLOR_SEL(fmt)   [NSString stringWithFormat:@"[%@]", CCCrayola(@"PacificBlue", fmt, ## __VA_ARGS__)]

#undef COLOR_QUEUE
#define COLOR_QUEUE(fmt)   [NSString stringWithFormat:@"[%@]", CCCrayola(@"Dandelion", fmt, ## __VA_ARGS__)]



static NSArray* SEMakeSwatch(NSUInteger numSteps, CGFloat redStart, CGFloat redEnd, CGFloat greenStart, CGFloat greenEnd, CGFloat blueStart, CGFloat blueEnd)
{
    NSMutableArray *swatch = @[].mutableCopy;

    for (NSUInteger i = 0; i < numSteps; i++)
    {
        CGFloat redStepSize   = (redEnd   - redStart)   / (CGFloat)numSteps;
        CGFloat blueStepSize  = (blueEnd  - blueStart)  / (CGFloat)numSteps;
        CGFloat greenStepSize = (greenEnd - greenStart) / (CGFloat)numSteps;

        CGFloat redValue   = redStart   + (redStepSize   * i);
        CGFloat greenValue = greenStart + (greenStepSize * i);
        CGFloat blueValue  = blueStart  + (blueStepSize  * i);

        UIColor *color = [UIColor colorWithRed: redValue green: greenValue blue: blueValue alpha: 1.0f];
        yssert_notNilAndIsClass(color, UIColor);
        [swatch addObject: color];
    }

    return [NSArray arrayWithArray: swatch];
}








