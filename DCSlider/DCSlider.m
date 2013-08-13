//
//  DCSlider.m
//
//  Copyright 2011 Domestic Cat. All rights reserved.
//

#import "DCSlider.h"

@interface DCSlider ()

@property (nonatomic, weak,   readwrite) UITapGestureRecognizer *tapGestureRecognizer;
@property (nonatomic, assign, readwrite) CGFloat touchHandleOffset;

@end

@implementation DCSlider {}

#pragma mark- Lifecycle
#pragma mark-

- (id)initWithDelegate:(id)aDelegate
{
    self = [super initWithDelegate:aDelegate];
	if (self)
	{
		_cornerRadius = 3.0;
        _minimumHandleSize = 35.0f;
	}
	
	return self;
}



#pragma mark- Accessors
#pragma mark-

- (void) setIsTappable:(BOOL)isTappable
{
    if (isTappable == YES && self.tapGestureRecognizer == nil)
    {
        // add the tap gesture for jumping the value straight to that point
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        tapGestureRecognizer.numberOfTapsRequired = 1;
        [self addGestureRecognizer:tapGestureRecognizer];
        self.tapGestureRecognizer = tapGestureRecognizer;
    }
    else
    {
        if (self.tapGestureRecognizer != nil) {
            [self removeGestureRecognizer: self.tapGestureRecognizer];
            self.tapGestureRecognizer = nil;
        }
    }
    _isTappable = isTappable;
}

- (void)setFrame:(CGRect)frame
{
	[super setFrame:frame];

    CGFloat height = self.isHorizontalSlider
                        ? self.bounds.size.width / 6.0f
                        : self.bounds.size.height / 6.0f;

	self.handleSize = floorf(height);
}

- (void) setHandleSize:(CGFloat)handleSize
{
	if (handleSize < self.minimumHandleSize) {
		handleSize = 35.0f;
    }
    _handleSize = handleSize;
}



#pragma mark- Touch handling
#pragma mark-

- (void) touchesBegan: (NSSet *)touches
            withEvent: (UIEvent *)event
{
	UITouch *touch = [touches anyObject];
	CGPoint touchPosition = [touch locationInView:self];
	CGFloat handleOrigin;
	CGFloat valueInternal = (self.value - self.min) / (self.max - self.min);

	if (self.isHorizontalSlider) {
		handleOrigin = (self.bounds.size.width - self.handleSize) * valueInternal;
    }
	else {
		handleOrigin = self.bounds.size.height - self.handleSize - (self.bounds.size.height - self.handleSize) * valueInternal;
    }

    //
	// if the touch is inside the handle then save the offset of the touch from the handle
    //
	if ((self.isHorizontalSlider && touchPosition.x > handleOrigin && touchPosition.x < handleOrigin + self.handleSize)
		|| (!self.isHorizontalSlider && touchPosition.y > handleOrigin && touchPosition.y < handleOrigin + self.handleSize))
	{
		self.touchHandleOffset = (self.isHorizontalSlider) ? touchPosition.x - handleOrigin : touchPosition.y - handleOrigin;
	}
	else
	{
		// set the handle offset to -1 so touchesmoved events are ignored
		self.touchHandleOffset = -1;
	}
}

- (void) touchesMoved: (NSSet *)touches
            withEvent: (UIEvent *)event
{
	if (self.touchHandleOffset == -1) {
		return;
    }

	UITouch *touch        = [touches anyObject];
	CGPoint touchPosition = [touch locationInView:self];

	CGFloat newValue;

	if (self.isHorizontalSlider) {
		newValue = (touchPosition.x - self.touchHandleOffset) / (self.bounds.size.width - self.handleSize);
    }
	else {
		newValue = 1 - (touchPosition.y - self.touchHandleOffset) / (self.bounds.size.height - self.handleSize);
    }

	self.value = self.min + newValue * (self.max - self.min);
}

- (void) tap:(UIGestureRecognizer *)gesture
{
	if (self.allowsGestures == NO) {
		return;
    }
	
	CGPoint tapPoint = [gesture locationInView:self];

    //
	// work out the touch position and therefore value
    //

	CGFloat newValue;

	if (self.isHorizontalSlider) {
		newValue = (tapPoint.x - self.handleSize / 2) / (self.bounds.size.width - self.handleSize);
    }
	else {
		newValue = 1 - (tapPoint.y - self.handleSize / 2) / (self.bounds.size.height - self.handleSize);
    }

    self.value = self.min + newValue * (self.max - self.min);
}



#pragma mark- Drawing
#pragma mark-

- (void)drawRect:(CGRect)rect
{
	CGContextRef context = UIGraphicsGetCurrentContext();
    UIColor     *backgroundColor = (self.deselectedColor != nil
                                        ? [self.deselectedColor colorWithAlphaComponent:self.backgroundColorAlpha]
                                        : [self.color           colorWithAlphaComponent:self.backgroundColorAlpha]);

    CGFloat lighterBackgroundColorAlpha = self.backgroundColorAlpha / 2.0f;
	UIColor *lighterBackgroundColor     = (self.deselectedColor != nil
                                               ? [self.deselectedColor colorWithAlphaComponent: lighterBackgroundColorAlpha]
                                               : [self.color           colorWithAlphaComponent: lighterBackgroundColorAlpha]);

    //
	// draw background of slider
    //

	[lighterBackgroundColor set];
	[self context:context addRoundedRect:self.bounds cornerRadius:self.cornerRadius];
	CGContextFillPath(context);

    //
	// draw the 'filled' section to the left of the handle (or from the handle if in bidirectional mode)
    //

	[backgroundColor set];

	CGRect valueRect;
    CGRect  rectForHandle = [self rectForHandle];
    CGFloat handlePos     = CGRectGetMinY(rectForHandle);
    CGFloat handleMid     = CGRectGetMidY(rectForHandle);
    CGFloat handleMin     = CGRectGetMinY(rectForHandle);
    CGFloat handleMax     = CGRectGetMaxX(rectForHandle);

    if (self.isHorizontalSlider)
	{
		if (self.isBidirectional)
		{
			if (self.value > (self.max - self.min) / 2) {
				valueRect = CGRectMake(self.bounds.size.width / 2, 0, handleMid - (self.bounds.size.width / 2), self.bounds.size.height);
            }
			else {
				valueRect = CGRectMake(handleMid, 0.0f, self.bounds.size.width - handleMid - (self.bounds.size.width / 2), self.bounds.size.height);
            }

			[self context:context addRoundedRect:valueRect cornerRadius:0];
		}
		else
		{
			valueRect = CGRectMake(0, 0, self.bounds.size.width - (self.bounds.size.width - handleMax), self.bounds.size.height);
			[self context:context addRoundedRect:valueRect cornerRadius:self.cornerRadius];
		}

		CGContextFillPath(context);

		valueRect = CGRectMake(handlePos, 0, self.handleSize, self.bounds.size.height);
	}
	else
	{
        //
		// draw the 'filled' section below the handle (or from the handle if in bidirectional mode) using a colour slightly lighter than the theme
        //

        if (self.isBidirectional)
		{
			if (self.value > (self.max - self.min) / 2) {
				valueRect = CGRectMake(0, handleMid, self.bounds.size.width, (self.bounds.size.height / 2) - handleMid);
            }
			else {
				valueRect = CGRectMake(0, self.bounds.size.height, self.bounds.size.width, handleMid - self.bounds.size.height / 2);
            }

            valueRect = CGRectIntegral(valueRect);

			[self context:context addRoundedRect:valueRect cornerRadius:0];
		}
		else
		{
			valueRect = CGRectIntegral(CGRectMake(0, handleMin, self.bounds.size.width, self.bounds.size.height - handleMin));

			[self context:context addRoundedRect:valueRect cornerRadius:self.cornerRadius];
		}

		CGContextFillPath(context);

		valueRect = CGRectMake(0, handlePos, self.bounds.size.width, self.handleSize);
	}

    //
	// draw the handle
    //

    valueRect = CGRectIntegral(valueRect);
	[self.color set];
	[self context:context addRoundedRect:valueRect cornerRadius:self.cornerRadius];

	CGContextFillPath(context);

    //
	// draw value string as needed
    //

	if (self.displaysValue)
	{
		[self.labelColor set];
		NSString *valueString = nil;

		if (self.isBidirectional) {
			valueString = [NSString stringWithFormat:@"%02.0f%%", ((self.value - self.min - (self.max - self.min) / 2) / (self.max - self.min)) * 100];
        }
		else {
			valueString = [NSString stringWithFormat:@"%03.0f%%", ((self.value - self.min) / (self.max - self.min)) * 100];
        }

		CGSize valueStringSize = [valueString sizeWithFont:self.labelFont];
		CGRect handleRect = [self rectForHandle];
		[valueString drawInRect:CGRectMake(handleRect.origin.x + (handleRect.size.width - valueStringSize.width) / 2,
										   handleRect.origin.y + (handleRect.size.height - valueStringSize.height) / 2,
										   valueRect.size.width,
										   valueRect.size.height)
					   withFont:self.labelFont
				  lineBreakMode:NSLineBreakByTruncatingTail];
	}
}

- (CGRect)rectForHandle
{
	CGRect valueRect;

	if (self.isHorizontalSlider)
	{
		CGFloat handlePos = (self.bounds.size.width - self.handleSize) * ((self.value - self.min) / (self.max - self.min));
		valueRect = CGRectMake(handlePos, 0, self.handleSize, self.bounds.size.height);
	}
	else
	{
		CGFloat handlePos = (self.bounds.size.height - self.handleSize) - ((self.bounds.size.height - self.handleSize) * ((self.value - self.min) / (self.max - self.min)));
		valueRect = CGRectMake(0, handlePos, self.bounds.size.width, self.handleSize);
	}

	return valueRect;
}

@end






