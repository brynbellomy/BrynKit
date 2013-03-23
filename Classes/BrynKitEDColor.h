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



#ifndef COLOR_ERROR
#   define COLOR_ERROR(x) CCCrayola(@"Scarlet", x)
#endif
#ifndef COLOR_SUCCESS
#   define COLOR_SUCCESS(x) CCCrayola(@"Screamin'Green", x)
#endif
#ifndef COLOR_FILENAME
#   define COLOR_FILENAME(x) CCCrayola(@"PurpleHeart", x)
#endif
#ifndef COLOR_LINE
#   define COLOR_LINE(x) CCCrayola(@"Sunglow", x)
#endif
#ifndef COLOR_FUNC
#   define COLOR_FUNC(x) CCCrayola(@"Aquamarine", x)
#endif
#ifndef COLOR_SEL
#   define COLOR_SEL(x)   [NSString stringWithFormat:@"[%@]", CCCrayola(@"PacificBlue", (x))]
#endif
#ifndef COLOR_QUEUE
#   define COLOR_QUEUE(x)   [NSString stringWithFormat:@"[%@]", CCCrayola(@"Dandelion", (x))]
#endif



