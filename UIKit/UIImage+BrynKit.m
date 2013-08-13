//
//  UIImage+BrynKit.m
//  BrynKit
//
//  Created by bryn austin bellomy on 8.10.13.
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "UIImage+BrynKit.h"
#import "BrynKitCoreGraphics.h"
#import "BrynKit-Main.h"

@implementation UIImage (BrynKit)

+ (UIImage *) bk_imageWithBundlePNG:(NSString *)filename
{
    CGImageRef pngImage = BKCGImageFromBundlePNG( filename );
    yssert_notNull( pngImage );

    UIImage   *image    = [self imageWithCGImage:pngImage];
    yssert_notNilAndIsClass(image, UIImage);

    CGImageRelease( pngImage );

    return image;
}



- (CVPixelBufferRef) bk_CVPixelBuffer
{
    CGImageRef image = self.CGImage;
    yssert_notNull( image );

    CVPixelBufferRef pixelBuffer = BKCVPixelBufferFromCGImage( image );
    //    CGImageRelease( image );

    return pixelBuffer;
}

@end





