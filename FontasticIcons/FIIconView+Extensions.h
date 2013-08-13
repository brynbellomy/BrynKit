//
//  FIIconView+Extensions.h
//  BrynKit
//
//  Created by bryn austin bellomy on 4.23.13.
//  Copyright (c) 2013 robot bubble bath LLC. All rights reserved.
//

#if __BRYNKIT_USE_FONTASTICICONS__ == 1

#import <FontasticIcons/FIIconView.h>

@interface FIIconView (Extensions)

+ (instancetype) bryn_iconViewWithIcon:(FIIcon *)icon size:(CGSize)size;

@end


#endif

