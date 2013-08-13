//
//  FIIconView+Extensions.m
//  BrynKit
//
//  Created by bryn austin bellomy on 4.23.13.
//  Copyright (c) 2013 robot bubble bath LLC. All rights reserved.
//

#if __BRYNKIT_USE_FONTASTICICONS__ == 1

#import <FontasticIcons/FIIconView.h>
#import "FIIconView+Extensions.h"

@implementation FIIconView (Extensions)

/**
 * +iconViewWithIcon:size:
 *
 * @param  {FIIcon *} icon
 * @return {FIIconView *}
 */
+ (instancetype) bryn_iconViewWithIcon:(FIIcon *)icon
                                  size:(CGSize)size
{
    CGRect frame = CGRectMake(0.0f, 0.0f, size.width, size.height);

    FIIconView *iconView = [[[self class] alloc] initWithFrame: frame];

    iconView.backgroundColor = [UIColor clearColor];
    iconView.icon            = icon;
    iconView.padding         = 2;
    iconView.iconColor       = [UIColor blackColor];
    iconView.alpha           = 1.0f;
    return iconView;
}


@end

#endif
