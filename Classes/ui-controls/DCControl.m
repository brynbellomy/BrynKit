//
//  DCControl.m
//
//  Copyright 2011 Domestic Cat. All rights reserved.
//

#import "DCControl.h"

@implementation DCControl {
    CGFloat _value;
}

#pragma mark- Lifecycle
#pragma mark-

- (instancetype) initWithDelegate:(id)aDelegate
{
    self = [super init];
	if (self)
	{
        // set defaults for properties inherited from UIView
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = NO;
        self.opaque = NO;

        // setup defaults
        _backgroundColorAlpha = 0.3f;
        _color = [UIColor blueColor];
        _min = 0.0f;
        _max = 1.0f;
        _displaysValue = YES;
        _allowsGestures = YES;
        _labelFont = [UIFont boldSystemFontOfSize:12.5f];

		_delegate = aDelegate;
	}

	return self;
}

- (void)dealloc
{
	_delegate = nil;
}



#pragma mark- Accessors
#pragma mark-

- (CGFloat) value
{
    CGFloat value;
    @synchronized (self)
    {
        value = _value;
    }
    return value;
}

- (void) setValue:(CGFloat)newValue
{
    @synchronized (self)
    {
        [self willChangeValueForKey:@"value"];
        if (newValue > self.max) {
            _value = self.max;
        }
        else if (newValue < self.min) {
            _value = self.min;
        }
        else {
            _value = newValue;
        }
        [self didChangeValueForKey:@"value"];

        if (self.delegate != nil) {
            [self.delegate controlValueDidChange:_value sender:self];
        }

        [self setNeedsDisplay];
    }
}



#pragma mark- Helper methods
#pragma mark-

- (void)        context:(CGContextRef)c
         addRoundedRect:(CGRect)rect
           cornerRadius:(CGFloat)cornerRadius
{
	rect.size.width += 0.5f;
	NSInteger x_left = (NSInteger)floorf(rect.origin.x);
	NSInteger x_left_center = (NSInteger)floorf(rect.origin.x + cornerRadius);
	NSInteger x_right_center = (NSInteger)floorf(rect.origin.x + rect.size.width - cornerRadius);
	NSInteger x_right = (NSInteger)floorf(rect.origin.x + rect.size.width);
	NSInteger y_top = (NSInteger)floorf(rect.origin.y);
	NSInteger y_top_center = (NSInteger)floorf(rect.origin.y + cornerRadius);
	NSInteger y_bottom_center = (NSInteger)floorf(rect.origin.y + rect.size.height - cornerRadius);
	NSInteger y_bottom = (NSInteger)floorf(rect.origin.y + rect.size.height);

	/* Begin! */
	CGContextBeginPath(c);
	CGContextMoveToPoint(c, x_left, y_top_center);

	/* First corner */
	CGContextAddArcToPoint(c, x_left, y_top, x_left_center, y_top, cornerRadius);
	CGContextAddLineToPoint(c, x_right_center, y_top);

	/* Second corner */
	CGContextAddArcToPoint(c, x_right, y_top, x_right, y_top_center, cornerRadius);
	CGContextAddLineToPoint(c, x_right, y_bottom_center);

	/* Third corner */
	CGContextAddArcToPoint(c, x_right, y_bottom, x_right_center, y_bottom, cornerRadius);
	CGContextAddLineToPoint(c, x_left_center, y_bottom);

	/* Fourth corner */
	CGContextAddArcToPoint(c, x_left, y_bottom, x_left, y_bottom_center, cornerRadius);
	CGContextAddLineToPoint(c, x_left, y_top_center);

	/* Done */
	CGContextClosePath(c);	
}

@end
