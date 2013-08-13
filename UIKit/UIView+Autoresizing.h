//
//  NEAutoresizing.h
//  TK189
//
//  Created by Chen Weigang on 12-2-3.
//  Copyright (c) 2012年 Fugu Mobile Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIView (Autoresizing)

- (void) autoresizingFixLeftTop;
- (void) autoresizingFixLeftBottom;
- (void) autoresizingFixRightTop;
- (void) autoresizingFixRightBottom;
- (void) autoresizingFixTopFlexibleWidth;
- (void) autoresizingFixBottomFlexibleWidth;
- (void) autoresizingFixLeftFlexibleHeight;
- (void) autoresizingFixRightFlexibleHeight;
- (void) autoresizingFlexibleWidthFlexibleHeight;

@end
