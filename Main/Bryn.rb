
# line 1 "/Users/bryn/projects/BrynKit/master/Main/Bryn.m"
//
//  Bryn.m
//  BrynKit
//
//  Created by bryn austin bellomy on 7/29/12.
//  Copyright (c) 2012 bryn austin bellomy. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <libextobjc/EXTScope.h>
#import <ImageIO/ImageIO.h>
#import <ObjectiveSugar/ObjectiveSugar.h>
#import "Bryn.h"
#import "BrynKitDebugging.h"

/**!
 * ### dispatch_safe_sync()
 *
 * Exactly like `dispatch_sync()`, except that it prevents you from deadlocking
 * the current queue by calling `dispatch_sync()` on it.  If the `queue`
 * parameter turns out to be the current queue (or the current queue is the main
 * queue, which you can't call `dispatch_sync()` on), it will just call `block()`.
 *
 * @param {dispatch_queue_t} queue The queue on which to execute the block.
 * @param {dispatch_block_t} block The block to execute.
 */
void dispatch_safe_sync(dispatch_queue_t queue, dispatch_block_t block)
{
    if ((dispatch_get_main_queue() == queue && [NSThread isMainThread]) || dispatch_get_current_queue() == queue)
    {
        block();
    }
    else
    {
        dispatch_sync(queue, block);
    }
}



#pragma mark- Image helpers
#pragma mark-

CGImageRef BrynCGImageFromFile(NSString *path)
{
    // Get the URL for the pathname passed to the function.
    NSURL *url = [NSURL fileURLWithPath:path];
    CGImageRef        image = NULL;
    CGImageSourceRef  imageSource;
    CFDictionaryRef   options = NULL;
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

    CFRelease(imageSource);

    // Make sure the image exists before continuing
    yssert_notNull(image);

    return image;
}

UIImage *BrynUIImageFromBundlePNG(NSString *basename)
{
    return [UIImage imageWithCGImage: BrynCGImageFromBundlePNG(basename)];
}

CGImageRef BrynCGImageFromBundlePNG(NSString *basename)
{
    CGImageRef pngImage = BrynCGImageFromFile([[NSBundle mainBundle] pathForResource:basename ofType: @"png"]);
    yssert_notNull(pngImage);
    return pngImage;
}



@implementation UIImage (BrynKit)

+ (UIImage *) bryn_imageWithBundlePNG:(NSString *)filename
{
    CGImageRef pngImage = BrynCGImageFromBundlePNG(filename);
    yssert_notNull(pngImage);

    UIImage   *image    = [self imageWithCGImage:pngImage];
    yssert_notNilAndIsClass(image, UIImage);

    return image;
}

@end



@implementation UIColor (BrynKit)

- (CGFloat) red
{
    CGFloat value;
    [self getRed:&value  green:NULL  blue:NULL  alpha:NULL];
    return value;
}

- (CGFloat) green
{
    CGFloat value;
    [self getRed:NULL  green:NULL  blue:NULL  alpha:NULL];
    return value;
}

- (CGFloat) red
{
    CGFloat value;
    [self getRed:&value  green:NULL  blue:NULL  alpha:NULL];
    return value;
}

@end



#pragma mark- Categories: misc.
#pragma mark-

@implementation NSObject (BrynKit_Description)

- (NSString *) bryn_descriptionWithProperties: (NSArray *)properties
{
    return [self bryn_descriptionWithProperties:properties
                                      separator:@"\r"];
}

- (NSString *) bryn_descriptionWithProperties:(NSArray *)properties
                                    separator:(NSString *)separator
{
    return [self bryn_descriptionWithProperties:properties
                                      separator:separator
                                      formatter:^NSString *(NSString *property, id value) {
                                          return $str(@"    %@ = %@;", property, value);
                                      }];

}

- (NSString *) bryn_descriptionWithProperties: (NSArray *)properties
                                    separator: (NSString *)separator
                                    formatter: (NSString *(^)(NSString *property, id value))formatter
{
    @weakify(self);

    NSString *propertyDescriptions = [[properties
                                           map:^NSString *(NSString *property) {
                                               @strongify(self);
                                               return formatter(property, [self valueForKey:property]);
                                           }]
                                           componentsJoinedByString:separator];

    return [self bryn_descriptionWithString:propertyDescriptions];
}

- (NSString *) bryn_descriptionWithString:(NSString *)string
{
	return [NSString stringWithFormat:@"<%@: %p; = {\n%@\n}>", [[self class] description], self, string];
}

@end



@implementation UIDevice (BrynKit)

+ (BOOL) bryn_isMultitaskingSupported
{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(isMultitaskingSupported)])
    {
        return [[UIDevice currentDevice] isMultitaskingSupported];
    }
    return NO;
}

+ (BOOL) bryn_isIPhone5OrTaller
{
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone
        && [[UIScreen mainScreen] bryn_actualHeight] >= 1136;
}

@end



@implementation UIScreen (BrynKit)

- (CGFloat) bryn_scaledHeight
{
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    return height;
}

- (CGFloat) bryn_scaledWidth
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    return width;
}

- (CGFloat) bryn_actualHeight
{
    CGFloat scale  = [UIScreen mainScreen].scale;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;

    return height * scale;
}

- (CGFloat) bryn_actualWidth
{
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;

    return width * scale;
}

@end



@implementation NSString (BrynKit)

- (NSString *) bryn_replace:(NSString *)strToReplace
                       with:(NSString *)replacementStr
{
    return [self stringByReplacingOccurrencesOfString: strToReplace
                                           withString: replacementStr];
}

- (NSString *) bryn_replaceRegex:(NSString *)regexToReplace
                            with:(NSString *)replacementStr
{
    return [self stringByReplacingOccurrencesOfString: regexToReplace
                                           withString: replacementStr
                                              options: NSRegularExpressionSearch
                                                range: NSMakeRange(0, self.length)];
}

@end



#pragma mark- Categories: UIKit
#pragma mark-

@implementation UILabel (BrynKit)

- (void) bryn_setLabelTextAndSizeToFit:(NSString *)newText
{
    self.text = newText;
    [self sizeToFit];
}

@end



@implementation UIView (BrynKit)


- (void) bryn_animateKey:(NSString *)key
                 toValue:(id)toValue
                duration:(CFTimeInterval)duration
            autoreverses:(BOOL)autoreverses
{
    [self bryn_animateKey:key
                fromValue:[self.layer valueForKey:key]
                  toValue:toValue
                 duration:duration
             autoreverses:autoreverses];
}

- (void) bryn_animateKey:(NSString *)key
               fromValue:(id)fromValue
                 toValue:(id)toValue
                duration:(CFTimeInterval)duration
            autoreverses:(BOOL)autoreverses
{
    CABasicAnimation *animation = [CABasicAnimation animation];

    if (fromValue != nil) animation.fromValue = fromValue;
    if (toValue   != nil) animation.toValue   = toValue;

    animation.duration     = duration;
    animation.autoreverses = autoreverses;

    if (NO == autoreverses)
        animation.fillMode = kCAFillModeForwards;

    [self.layer addAnimation:animation forKey:key];

    if (NO == autoreverses)
        [self.layer setValue:toValue forKey:key];
}

@end



#pragma mark- Categories: collections
#pragma mark-

@implementation NSSet (BrynKitSorting)

- (NSOrderedSet *) bryn_sortByKey:(NSString *)key
{
    NSArray *array = [self sortedArrayUsingDescriptors: @[ [[NSSortDescriptor alloc] initWithKey:key ascending:YES] ]];
    return [NSOrderedSet orderedSetWithArray: array];
}

@end



@implementation NSMutableSet (BrynKitSorting)

- (NSMutableOrderedSet *) bryn_sortByKey:(NSString *)key
{
    NSArray *array = [self sortedArrayUsingDescriptors: @[ [[NSSortDescriptor alloc] initWithKey:key ascending:YES] ]];
    return [[NSMutableOrderedSet orderedSetWithArray: array] mutableCopy];
}

@end



@implementation NSOrderedSet (BrynKit)

+ (instancetype) bryn_orderedSetWithIntegersInRange:(NSRange)range
{
    NSMutableOrderedSet *set = [NSMutableOrderedSet orderedSetWithCapacity: range.length];
    for (NSUInteger i = range.location; i < range.length; i++) {
        [set addObject: @( i )];
    }
    return [NSOrderedSet orderedSetWithOrderedSet: set];
}

@end



@implementation NSOrderedSet (BrynKitSorting)

- (instancetype) bryn_sortByKey:(NSString *)key
{
    NSArray *array = [[self array] bryn_sortByKey:key];
    return [[self class] orderedSetWithArray:array];
}

@end



@implementation NSMutableOrderedSet (BrynKitSorting)

- (instancetype) bryn_sortByKey:(NSString *)key
{

    NSArray *array = [[self array] bryn_sortByKey:key];
    return [[NSMutableOrderedSet orderedSetWithArray:array] mutableCopy];
}

@end



@implementation NSArray (BrynKitSorting)

- (instancetype) bryn_sortByKey:(NSString *)key
{
    return [self sortedArrayUsingDescriptors: @[ [[NSSortDescriptor alloc] initWithKey:key ascending:YES] ]];
}

- (instancetype) bryn_sort:(NSComparator)comparator
{
    return [self sortedArrayUsingComparator:comparator];
}

@end





@implementation NSDictionary (BrynKitSorting)

- (NSArray *) bryn_sortedKeysByComparingSubkey:(NSString *)subkey
{
    @weakify(self);
    return [[self allKeys] bryn_sort:^NSComparisonResult(id key1, id key2) {
        @strongify(self);

        id<BKComparable> key1SubkeyValue = [self[ key1 ] valueForKey:subkey];
        id<BKComparable> key2SubkeyValue = [self[ key2 ] valueForKey:subkey];

        yssert_notNilAndRespondsToSelector(key1SubkeyValue, compare:);
        yssert_notNilAndRespondsToSelector(key2SubkeyValue, compare:);

        return [key1SubkeyValue compare:key2SubkeyValue];
    }];
}

@end



#pragma mark- BKFloatRange
#pragma mark-

BKFloatRange BKMakeFloatRange(Float32 loc, Float32 len)
{
    BKFloatRange r;
    r.location = loc;
    r.length = len;
    return r;
}

BKFloatRange BKMakeFloatRangeWithBounds(Float32 start, Float32 end)
{
    BKFloatRange r;
    r.location = start;
    r.length = end - start;
    return r;
}

BKFloatRange BKMakeZeroLengthFloatRange(Float32 location)
{
    BKFloatRange r;
    r.location = location;
    r.length = 0;
    return r;
}

Float32 BKFloatRangeStartValue(BKFloatRange range) { return BKMinValueInFloatRange(range); }
Float32 BKFloatRangeEndValue(BKFloatRange range)   { return BKMaxValueInFloatRange(range); }
Float32 BKMinValueInFloatRange(BKFloatRange range) { return range.location; }
Float32 BKMaxValueInFloatRange(BKFloatRange range) { return range.location + range.length; }

BOOL BKIsLocationInFloatRange(Float32 loc, BKFloatRange range)       { return loc - range.location < range.length; }
BOOL BKFloatRangesAreEqual(BKFloatRange range1, BKFloatRange range2) { return range1.location == range2.location && range1.length == range2.length; }







