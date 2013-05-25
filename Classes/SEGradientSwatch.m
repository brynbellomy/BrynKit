//
//  SEGradientSwatch.m
//  BrynKit
//
//  Created by bryn austin bellomy on 5.8.13.
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//

#import "SEGradientSwatch.h"

@implementation SEGradientSwatch

- (instancetype) initWithNumSteps:(NSUInteger)numSteps
                         redRange:(BKFloatRange)redRange
                       greenRange:(BKFloatRange)greenRange
                        blueRange:(BKFloatRange)blueRange
                       alphaRange:(BKFloatRange)alphaRange
{
    self = [super init];
    if (self)
    {
        _redRange = redRange;
        _greenRange = greenRange;
        _blueRange = blueRange;
        _alphaRange = alphaRange;
        _steps = numSteps;
    }
    return self;
}



- (instancetype) initWithNumSteps:(NSUInteger)numSteps
                        fromColor:(UIColor *)fromColor
                          toColor:(UIColor *)toColor
{
    CGFloat onRed, offRed, onGreen, offGreen, onBlue, offBlue, onAlpha, offAlpha;

    [fromColor getRed:&onRed  green:&onGreen  blue:&onBlue  alpha:&onAlpha];
    [toColor   getRed:&offRed green:&offGreen blue:&offBlue alpha:&offAlpha];

    self = [self initWithNumSteps: numSteps
                         redRange: BKMakeFloatRangeWithBounds(onRed, offRed)
                       greenRange: BKMakeFloatRangeWithBounds(onGreen, offGreen)
                        blueRange: BKMakeFloatRangeWithBounds(onBlue, offBlue)
                       alphaRange: BKMakeFloatRangeWithBounds(onAlpha, offAlpha)];

    return self;
}



- (UIColor *)objectAtIndexedSubscript:(NSUInteger)index
{
    yssert(index < self.steps, @"Index out of range.");

    CGFloat redStart    = (CGFloat)BKFloatRangeStartValue(self.redRange);
    CGFloat redEnd      = (CGFloat)BKFloatRangeEndValue(self.redRange);

    CGFloat greenStart  = (CGFloat)BKFloatRangeStartValue(self.greenRange);
    CGFloat greenEnd    = (CGFloat)BKFloatRangeEndValue(self.greenRange);

    CGFloat blueStart   = (CGFloat)BKFloatRangeStartValue(self.blueRange);
    CGFloat blueEnd     = (CGFloat)BKFloatRangeEndValue(self.blueRange);

    CGFloat alphaStart  = (CGFloat)BKFloatRangeStartValue(self.alphaRange);
    CGFloat alphaEnd    = (CGFloat)BKFloatRangeEndValue(self.alphaRange);

    CGFloat redStepSize   = (redEnd   - redStart)   / (CGFloat)self.steps;
    CGFloat blueStepSize  = (blueEnd  - blueStart)  / (CGFloat)self.steps;
    CGFloat greenStepSize = (greenEnd - greenStart) / (CGFloat)self.steps;
    CGFloat alphaStepSize = (alphaEnd - alphaStart) / (CGFloat)self.steps;

    CGFloat redValue   = redStart   + (redStepSize   * index);
    CGFloat greenValue = greenStart + (greenStepSize * index);
    CGFloat blueValue  = blueStart  + (blueStepSize  * index);
    CGFloat alphaValue = alphaStart + (alphaStepSize * index);

    UIColor *color = [UIColor colorWithRed:redValue green:greenValue blue:blueValue alpha:alphaValue];
    yssert_notNilAndIsClass(color, UIColor);

    return color;
}

@end
