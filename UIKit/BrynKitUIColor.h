//
//  BrynKitUIColor.h
//  BrynKit
//
//  Created by bryn austin bellomy on 8.10.13.
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//


#define BKRGBADictionaryFromColor(uiColor) \
    ({ \
        CGFloat r, g, b, a; \
        [uiColor getRed:&r green:&g blue:&b alpha:&a]; \
        r *= 255.0f; \
        g *= 255.0f; \
        b *= 255.0f; \
        a *= 255.0f; \
        @{ @"red": @(r), @"green": @(g), @"blue": @(b), @"alpha": @(a) }; \
    })



//
// Source: http: //en.wikipedia.org/wiki/List_of_Crayola_crayon_colors
// To generate: `cd Scripts; make`
//
#define CRAYOLA_SIMPLE_HASH @{ \
    @"almond"                  : @[ 0.937f , 0.871f , 0.804f , 1.0f ] , \
    @"antiquebrass"            : @[ 0.804f , 0.584f , 0.459f , 1.0f ] , \
    @"apricot"                 : @[ 0.992f , 0.851f , 0.710f , 1.0f ] , \
    @"aquamarine"              : @[ 0.471f , 0.859f , 0.886f , 1.0f ] , \
    @"asparagus"               : @[ 0.529f , 0.663f , 0.420f , 1.0f ] , \
    @"atomictangerine"         : @[ 1.000f , 0.643f , 0.455f , 1.0f ] , \
    @"bananamania"             : @[ 0.980f , 0.906f , 0.710f , 1.0f ] , \
    @"beaver"                  : @[ 0.624f , 0.506f , 0.439f , 1.0f ] , \
    @"bittersweet"             : @[ 0.992f , 0.486f , 0.431f , 1.0f ] , \
    @"black"                   : @[ 0.0f   , 0.0f   , 0.0f   , 1.0f ] , \
    @"blizzardblue"            : @[ 0.675f , 0.898f , 0.933f , 1.0f ] , \
    @"blue"                    : @[ 0.122f , 0.459f , 0.996f , 1.0f ] , \
    @"bluebell"                : @[ 0.635f , 0.635f , 0.816f , 1.0f ] , \
    @"bluegray"                : @[ 0.400f , 0.600f , 0.800f , 1.0f ] , \
    @"bluegreen"               : @[ 0.051f , 0.596f , 0.729f , 1.0f ] , \
    @"blueviolet"              : @[ 0.451f , 0.400f , 0.741f , 1.0f ] , \
    @"blush"                   : @[ 0.871f , 0.365f , 0.514f , 1.0f ] , \
    @"brickred"                : @[ 0.796f , 0.255f , 0.329f , 1.0f ] , \
    @"brown"                   : @[ 0.706f , 0.404f , 0.302f , 1.0f ] , \
    @"burntorange"             : @[ 1.000f , 0.498f , 0.286f , 1.0f ] , \
    @"burntsienna"             : @[ 0.918f , 0.494f , 0.365f , 1.0f ] , \
    @"cadetblue"               : @[ 0.690f , 0.718f , 0.776f , 1.0f ] , \
    @"canary"                  : @[ 1.000f , 1.000f , 0.600f , 1.0f ] , \
    @"caribbeangreen"          : @[ 0.110f , 0.827f , 0.635f , 1.0f ] , \
    @"carnationpink"           : @[ 1.000f , 0.667f , 0.800f , 1.0f ] , \
    @"cerise"                  : @[ 0.867f , 0.267f , 0.573f , 1.0f ] , \
    @"cerulean"                : @[ 0.114f , 0.675f , 0.839f , 1.0f ] , \
    @"chestnut"                : @[ 0.737f , 0.365f , 0.345f , 1.0f ] , \
    @"copper"                  : @[ 0.867f , 0.580f , 0.459f , 1.0f ] , \
    @"cornflower"              : @[ 0.604f , 0.808f , 0.922f , 1.0f ] , \
    @"cottoncandy"             : @[ 1.000f , 0.737f , 0.851f , 1.0f ] , \
    @"dandelion"               : @[ 0.992f , 0.859f , 0.427f , 1.0f ] , \
    @"denim"                   : @[ 0.169f , 0.424f , 0.769f , 1.0f ] , \
    @"desertsand"              : @[ 0.937f , 0.804f , 0.722f , 1.0f ] , \
    @"eggplant"                : @[ 0.431f , 0.318f , 0.376f , 1.0f ] , \
    @"electriclime"            : @[ 0.808f , 1.000f , 0.114f , 1.0f ] , \
    @"fern"                    : @[ 0.443f , 0.737f , 0.471f , 1.0f ] , \
    @"forestgreen"             : @[ 0.427f , 0.682f , 0.506f , 1.0f ] , \
    @"fuchsia"                 : @[ 0.765f , 0.392f , 0.773f , 1.0f ] , \
    @"fuzzywuzzy"              : @[ 0.800f , 0.400f , 0.400f , 1.0f ] , \
    @"gold"                    : @[ 0.906f , 0.776f , 0.592f , 1.0f ] , \
    @"goldenrod"               : @[ 0.988f , 0.851f , 0.459f , 1.0f ] , \
    @"grannysmithapple"        : @[ 0.659f , 0.894f , 0.627f , 1.0f ] , \
    @"gray"                    : @[ 0.584f , 0.569f , 0.549f , 1.0f ] , \
    @"green"                   : @[ 0.110f , 0.675f , 0.471f , 1.0f ] , \
    @"greenblue"               : @[ 0.067f , 0.392f , 0.706f , 1.0f ] , \
    @"greenyellow"             : @[ 0.941f , 0.910f , 0.569f , 1.0f ] , \
    @"hotmagenta"              : @[ 1.000f , 0.114f , 0.808f , 1.0f ] , \
    @"inchworm"                : @[ 0.698f , 0.925f , 0.365f , 1.0f ] , \
    @"indigo"                  : @[ 0.365f , 0.463f , 0.796f , 1.0f ] , \
    @"jazzberryjam"            : @[ 0.792f , 0.216f , 0.404f , 1.0f ] , \
    @"junglegreen"             : @[ 0.231f , 0.690f , 0.561f , 1.0f ] , \
    @"laserlemon"              : @[ 0.996f , 0.996f , 0.133f , 1.0f ] , \
    @"lavender"                : @[ 0.988f , 0.706f , 0.835f , 1.0f ] , \
    @"lemonyellow"             : @[ 1.000f , 0.957f , 0.310f , 1.0f ] , \
    @"macaroniandcheese"       : @[ 1.000f , 0.741f , 0.533f , 1.0f ] , \
    @"magenta"                 : @[ 0.965f , 0.392f , 0.686f , 1.0f ] , \
    @"magicmint"               : @[ 0.667f , 0.941f , 0.820f , 1.0f ] , \
    @"mahogany"                : @[ 0.804f , 0.290f , 0.298f , 1.0f ] , \
    @"maize"                   : @[ 0.929f , 0.820f , 0.612f , 1.0f ] , \
    @"manatee"                 : @[ 0.592f , 0.604f , 0.667f , 1.0f ] , \
    @"mangotango"              : @[ 1.000f , 0.510f , 0.263f , 1.0f ] , \
    @"maroon"                  : @[ 0.784f , 0.220f , 0.353f , 1.0f ] , \
    @"mauvelous"               : @[ 0.937f , 0.596f , 0.667f , 1.0f ] , \
    @"melon"                   : @[ 0.992f , 0.737f , 0.706f , 1.0f ] , \
    @"midnightblue"            : @[ 0.102f , 0.282f , 0.463f , 1.0f ] , \
    @"mountainmeadow"          : @[ 0.188f , 0.729f , 0.561f , 1.0f ] , \
    @"mulberry"                : @[ 0.773f , 0.294f , 0.549f , 1.0f ] , \
    @"navyblue"                : @[ 0.098f , 0.455f , 0.824f , 1.0f ] , \
    @"neoncarrot"              : @[ 1.000f , 0.639f , 0.263f , 1.0f ] , \
    @"olivegreen"              : @[ 0.729f , 0.722f , 0.424f , 1.0f ] , \
    @"orange"                  : @[ 1.000f , 0.459f , 0.220f , 1.0f ] , \
    @"orangered"               : @[ 1.000f , 0.169f , 0.169f , 1.0f ] , \
    @"orangeyellow"            : @[ 0.973f , 0.835f , 0.408f , 1.0f ] , \
    @"orchid"                  : @[ 0.902f , 0.659f , 0.843f , 1.0f ] , \
    @"outerspace"              : @[ 0.255f , 0.290f , 0.298f , 1.0f ] , \
    @"outrageousorange"        : @[ 1.000f , 0.431f , 0.290f , 1.0f ] , \
    @"pacificblue"             : @[ 0.110f , 0.663f , 0.788f , 1.0f ] , \
    @"peach"                   : @[ 1.000f , 0.812f , 0.671f , 1.0f ] , \
    @"periwinkle"              : @[ 0.773f , 0.816f , 0.902f , 1.0f ] , \
    @"piggypink"               : @[ 0.992f , 0.867f , 0.902f , 1.0f ] , \
    @"pinegreen"               : @[ 0.082f , 0.502f , 0.471f , 1.0f ] , \
    @"pinkflamingo"            : @[ 0.988f , 0.455f , 0.992f , 1.0f ] , \
    @"pinksherbert"            : @[ 0.969f , 0.561f , 0.655f , 1.0f ] , \
    @"plum"                    : @[ 0.557f , 0.271f , 0.522f , 1.0f ] , \
    @"purpleheart"             : @[ 0.455f , 0.259f , 0.784f , 1.0f ] , \
    @"purplemountain'smajesty" : @[ 0.616f , 0.506f , 0.729f , 1.0f ] , \
    @"purplepizzazz"           : @[ 0.996f , 0.306f , 0.855f , 1.0f ] , \
    @"radicalred"              : @[ 1.000f , 0.286f , 0.424f , 1.0f ] , \
    @"rawsienna"               : @[ 0.839f , 0.541f , 0.349f , 1.0f ] , \
    @"rawumber"                : @[ 0.443f , 0.294f , 0.137f , 1.0f ] , \
    @"razzledazzlerose"        : @[ 1.000f , 0.282f , 0.816f , 1.0f ] , \
    @"razzmatazz"              : @[ 0.890f , 0.145f , 0.420f , 1.0f ] , \
    @"red"                     : @[ 0.0f   , 0.302f , 0.0f   , 1.0f ] , \
    @"redorange"               : @[ 1.000f , 0.325f , 0.286f , 1.0f ] , \
    @"redviolet"               : @[ 0.753f , 0.267f , 0.561f , 1.0f ] , \
    @"robin'seggblue"          : @[ 0.122f , 0.808f , 0.796f , 1.0f ] , \
    @"royalpurple"             : @[ 0.471f , 0.318f , 0.663f , 1.0f ] , \
    @"salmon"                  : @[ 1.000f , 0.608f , 0.667f , 1.0f ] , \
    @"scarlet"                 : @[ 0.988f , 0.157f , 0.278f , 1.0f ] , \
    @"screamin'green"          : @[ 0.463f , 1.000f , 0.478f , 1.0f ] , \
    @"seagreen"                : @[ 0.624f , 0.886f , 0.749f , 1.0f ] , \
    @"sepia"                   : @[ 0.647f , 0.412f , 0.310f , 1.0f ] , \
    @"shadow"                  : @[ 0.541f , 0.475f , 0.365f , 1.0f ] , \
    @"shamrock"                : @[ 0.271f , 0.808f , 0.635f , 1.0f ] , \
    @"shockingpink"            : @[ 0.984f , 0.494f , 0.992f , 1.0f ] , \
    @"silver"                  : @[ 0.804f , 0.773f , 0.761f , 1.0f ] , \
    @"skyblue"                 : @[ 0.502f , 0.855f , 0.922f , 1.0f ] , \
    @"springgreen"             : @[ 0.925f , 0.918f , 0.745f , 1.0f ] , \
    @"sunglow"                 : @[ 1.000f , 0.812f , 0.282f , 1.0f ] , \
    @"sunsetorange"            : @[ 0.992f , 0.369f , 0.325f , 1.0f ] , \
    @"tan"                     : @[ 0.980f , 0.655f , 0.424f , 1.0f ] , \
    @"tealblue"                : @[ 0.094f , 0.655f , 0.710f , 1.0f ] , \
    @"thistle"                 : @[ 0.922f , 0.780f , 0.875f , 1.0f ] , \
    @"ticklemepink"            : @[ 0.988f , 0.537f , 0.675f , 1.0f ] , \
    @"timberwolf"              : @[ 0.859f , 0.843f , 0.824f , 1.0f ] , \
    @"tropicalrainforest"      : @[ 0.090f , 0.502f , 0.427f , 1.0f ] , \
    @"tumbleweed"              : @[ 0.871f , 0.667f , 0.533f , 1.0f ] , \
    @"turquoiseblue"           : @[ 0.467f , 0.867f , 0.906f , 1.0f ] , \
    @"unmellowyellow"          : @[ 1.000f , 1.000f , 0.400f , 1.0f ] , \
    @"violet(purple)"          : @[ 0.573f , 0.431f , 0.682f , 1.0f ] , \
    @"violetblue"              : @[ 0.196f , 0.290f , 0.698f , 1.0f ] , \
    @"violetred"               : @[ 0.969f , 0.325f , 0.580f , 1.0f ] , \
    @"vividtangerine"          : @[ 1.000f , 0.627f , 0.537f , 1.0f ] , \
    @"vividviolet"             : @[ 0.561f , 0.314f , 0.616f , 1.0f ] , \
    @"white"                   : @[ 1.000f , 1.000f , 1.000f , 1.0f ] , \
    @"wildblueyonder"          : @[ 0.635f , 0.678f , 0.816f , 1.0f ] , \
    @"wildstrawberry"          : @[ 1.000f , 0.263f , 0.643f , 1.0f ] , \
    @"wildwatermelon"          : @[ 0.988f , 0.424f , 0.522f , 1.0f ] , \
    @"wisteria"                : @[ 0.804f , 0.643f , 0.871f , 1.0f ] , \
    @"yellow"                  : @[ 0.988f , 0.910f , 0.514f , 1.0f ] , \
    @"yellowgreen"             : @[ 0.773f , 0.890f , 0.518f , 1.0f ] , \
    @"yelloworange"            : @[ 1.000f , 0.682f , 0.259f , 1.0f ] , \
}



/**
 * #### CCCrayola()
 *
 * Another color-logging macro.
 *
 * @param {NSString*} whichColor The name of the Crayola color (from `EDColor/Crayola.h`) in which to print the string.
 * @param {NSString*} __FORMAT__ The string to colorize.
 * @return {NSString*} The colorized string.
 *
 * @@TODO: fix this and make it completely available to the preprocessor
 */
#define CCCrayola(whichColor, __FORMAT__, ...) \
        XCODE_COLORS_FG( \
            CRAYOLA_SIMPLE_HASH[ [whichColor lowercaseString] ][0], \
            CRAYOLA_SIMPLE_HASH[ [whichColor lowercaseString] ][1], \
            CRAYOLA_SIMPLE_HASH[ [whichColor lowercaseString] ][2]  \
        ) \
        x \
        XCODE_COLORS_RESET



