//
//  UIImage+BrynKit.m
//  BrynKit
//
//  Created by bryn austin bellomy on 7.30.13.
//  Copyright (c) 2013 signalenvelope llc. All rights reserved.
//

#import <ImageIO/ImageIO.h>
#import <CoreVideo/CoreVideo.h>
#import "BrynKit-Main.h"
#import "BrynKitCoreGraphics.h"


CGImageRef BKCGImageFromFile(NSString *path)
{
    // Get the URL for the pathname passed to the function.
    NSURL *url = [NSURL fileURLWithPath:path];
    CGImageRef        image         = NULL;
    CGImageSourceRef  imageSource   = NULL;
    CFDictionaryRef   options       = NULL;
    CFStringRef       keys[2];
    CFTypeRef         values[2];

    // Set up options if you want them. The options here are for
    // caching the image in a decoded form and for using floating-point
    // values if the image format supports them.
    keys  [0] = kCGImageSourceShouldCache;
    values[0] = (CFTypeRef)kCFBooleanTrue;
    keys  [1] = kCGImageSourceShouldAllowFloat;
    values[1] = (CFTypeRef)kCFBooleanTrue;

    // Create the dictionary
    options = CFDictionaryCreate(NULL,
                                 (const void **)keys,
                                 (const void **)values,
                                 2,
                                 &kCFTypeDictionaryKeyCallBacks,
                                 &kCFTypeDictionaryValueCallBacks);

    // Create an image source from the URL.
    imageSource = CGImageSourceCreateWithURL((__bridge CFURLRef)url, options);

    CFRelease(options);

    // Make sure the image source exists before continuing
    yssert_notNull(imageSource);
    if (imageSource == NULL) return NULL;

    // Create an image from the first item in the image source.
    image = CGImageSourceCreateImageAtIndex(imageSource, 0, NULL);

    CFRelease( imageSource );

    // Make sure the image exists before continuing
    yssert_notNull( image );

    return image;
}

UIImage *BKUIImageFromBundlePNG(NSString *basename)
{
    CGImageRef cgimage  = BKCGImageFromBundlePNG( basename );
    UIImage *image      = [UIImage imageWithCGImage: cgimage];

    CGImageRelease( cgimage );

    return image;
}

CGImageRef BKCGImageFromBundlePNG(NSString *basename)
{
    CGImageRef pngImage = BKCGImageFromFile([[NSBundle mainBundle] pathForResource:basename ofType: @"png"]);
    yssert_notNull(pngImage);
    return pngImage;
}


CGContextRef BKCreateARGBBitmapContext (void *bitmapData, CGImageRef inImage)
{
    CGContextRef    context = NULL;
    CGColorSpaceRef colorSpace;
    size_t          bitmapBytesPerRow;

    // Get image width, height. We'll use the entire image.
    const size_t pixelsWide = CGImageGetWidth(inImage);
    const size_t pixelsHigh = CGImageGetHeight(inImage);

    // Declare the number of bytes per row. Each pixel in the bitmap in this
    // example is represented by 4 bytes; 8 bits each of red, green, blue, and
    // alpha.
    bitmapBytesPerRow   = (pixelsWide * (size_t)4);

    // Use the generic RGB color space.
    colorSpace = CGColorSpaceCreateDeviceRGB();
    if (colorSpace == NULL)
    {
        lllogc(Error, @"Error allocating color space");
        return NULL;
    }

    // Allocate memory for image data. This is the destination in memory
    // where any drawing to the bitmap context will be rendered.
    //  bitmapData = malloc( bitmapByteCount );
    //  if (bitmapData == NULL)
    //  {
    //    fprintf (stderr, "Memory not allocated!");
    //    CGColorSpaceRelease( colorSpace );
    //    return NULL;
    //  }

    // Create the bitmap context. We want pre-multiplied ARGB, 8-bits
    // per component. Regardless of what the source image format is
    // (CMYK, Grayscale, and so on) it will be converted over to the format
    // specified here by CGBitmapContextCreate.
    context = CGBitmapContextCreate (bitmapData,
        pixelsWide,
        pixelsHigh,
        8,      // bits per component
        bitmapBytesPerRow,
        colorSpace,
        kCGImageAlphaPremultipliedFirst | kCGBitmapByteOrder32Little);
    if (context == NULL)
    {
        free (bitmapData);
        lllogc(Error, @"Context not created!");
    }

    // Make sure and release colorspace before returning
    CGColorSpaceRelease( colorSpace );

    return context;
}



CVPixelBufferRef BKCVPixelBufferFromCGImage(CGImageRef image)
{
    CGSize frameSize = CGSizeMake(CGImageGetWidth(image), CGImageGetHeight(image));
    NSDictionary *options = nil;

    // this constant doesn't exist on earlier versions of iOS
    if ( BKCheckIfGlobalConstantIsAvailable( kCVPixelBufferOpenGLESCompatibilityKey ) ) {
        options = @{ (NSString *)kCVPixelBufferOpenGLESCompatibilityKey: @YES, };
    }
    else {
        options = @{};
    }

    CVPixelBufferRef pxbuffer = NULL;
    CVReturn status = CVPixelBufferCreate(kCFAllocatorDefault,
        (size_t)frameSize.width,
        (size_t)frameSize.height,
        kCVPixelFormatType_32BGRA,
        (__bridge CFDictionaryRef) options,
        &pxbuffer);

    yssert( status == kCVReturnSuccess );
    yssert_notNull( pxbuffer );

    size_t bytesPerPixel = CVPixelBufferGetBytesPerRow(pxbuffer) / frameSize.width;
    yssert( bytesPerPixel == 4 );

    CVPixelBufferLockBaseAddress( pxbuffer, 0 );
    {
        void *pxdata = CVPixelBufferGetBaseAddress( pxbuffer );

        CGContextRef context = BKCreateARGBBitmapContext( pxdata, image );
        yssert_notNull(context);

        CGRect rect = { {0, 0}, frameSize };
        CGContextDrawImage( context, rect, image );

        void *data = CGBitmapContextGetData(context);
        yssert_notNull( data );

        CGContextRelease( context );
    }
    CVPixelBufferUnlockBaseAddress(pxbuffer, 0);

    yssert_notNull(pxbuffer);
    return pxbuffer;
}



