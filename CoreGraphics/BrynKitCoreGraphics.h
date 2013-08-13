//
//  UIImage+BrynKit.h
//  BrynKit
//
//  Created by bryn austin bellomy on 7.30.13.
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>


/**
 * Load a PNG file from the main bundle.  People use `+[UIImage imageNamed:]`
 * because it's much easier than the (minimum) method calls you have to make to
 * load a UIImage the 'right' way.  With a macro like this, there's no excuse.
 * Note: the image filename you pass to this macro should not contain its file
 * extension (".png").
 *
 * @param {NSString*} filename The filename of the image without its ".png" extension.
 */
#if !defined(UIImageWithBundlePNG)
#   define UIImageWithBundlePNG(x) ([UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource:(x) ofType: @"png"]])
#endif


extern CGContextRef     BKCreateARGBBitmapContext( void *bitmapData, CGImageRef inImage ) __attribute__(( nonnull (1, 2) ));
extern CVPixelBufferRef BKCVPixelBufferFromCGImage( CGImageRef image ) __attribute__(( nonnull (1) ));

extern CGImageRef BKCGImageFromFile( NSString *path ) __attribute__(( nonnull (1) ));
extern CGImageRef BKCGImageFromBundlePNG( NSString *basename ) __attribute__(( nonnull (1) ));
extern UIImage*   BKUIImageFromBundlePNG( NSString *basename ) __attribute__(( nonnull (1) ));


