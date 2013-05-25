//
//  SEGradientSwatch.h
//  BrynKit
//
//  Created by bryn austin bellomy on 5.8.13.
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bryn.h"
#import "BrynKitDebugging.h"
#import "BrynKitLogging.h"


@interface SEGradientSwatch : NSObject

@property (nonatomic, assign, readwrite) NSUInteger steps;
@property (nonatomic, assign, readwrite) BKFloatRange redRange;
@property (nonatomic, assign, readwrite) BKFloatRange greenRange;
@property (nonatomic, assign, readwrite) BKFloatRange blueRange;
@property (nonatomic, assign, readwrite) BKFloatRange alphaRange;

- (instancetype) initWithNumSteps:(NSUInteger)numSteps
                        fromColor:(UIColor *)fromColor
                          toColor:(UIColor *)toColor;

- (instancetype) initWithNumSteps:(NSUInteger)numSteps
                         redRange:(BKFloatRange)redRange
                       greenRange:(BKFloatRange)greenRange
                        blueRange:(BKFloatRange)blueRange
                       alphaRange:(BKFloatRange)alphaRange;

- (UIColor *) objectAtIndexedSubscript:(NSUInteger)index;

@end
