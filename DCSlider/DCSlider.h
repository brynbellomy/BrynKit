//
//  DCSlider.h
//
//  Copyright 2011 Domestic Cat. All rights reserved.
//

#import "DCControl.h"

@interface DCSlider : DCControl

@property (nonatomic, assign, readwrite) CGFloat handleSize;         // default: longest side / 6 (minimum of 35.0)
@property (nonatomic, assign, readwrite) CGFloat minimumHandleSize;  // default: 35.0
@property (nonatomic, assign, readwrite) CGFloat cornerRadius;       // default: 3.0
@property (nonatomic, assign, readwrite) BOOL isHorizontalSlider;
@property (nonatomic, assign, readwrite) BOOL isBidirectional;
@property (nonatomic, assign, readwrite) BOOL isTappable;

/////////////////////////
// Init/Custom Setters //
/////////////////////////

- (id)initWithDelegate:(id)aDelegate;

////////////////////
// Touch Handling //
////////////////////

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;

////////////////////////
// Handle Positioning //
////////////////////////

- (CGRect)rectForHandle;

@end
