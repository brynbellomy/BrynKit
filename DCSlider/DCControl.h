//
//  DCControl.h
//
//  Copyright 2011 Domestic Cat. All rights reserved.
//

#import <UIKit/UIKit.h>

#define	kDCControlIsPhone (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad)
#define kDCControlDegreesToRadians(x) (M_PI * (x) / 180.0)
#define kDCControlRadiansToDegrees(x) ((x) * 180.0 / M_PI)

@protocol DCControlDelegate <NSObject>

@required

- (void)controlValueDidChange:(float)value sender:(id)sender;

@end

@interface DCControl : UIView

@property (nonatomic, weak, readwrite) id delegate;
@property (atomic, strong, readwrite) UIColor *color;			// default: black
@property (atomic, assign, readwrite) CGFloat backgroundColorAlpha;					// default: 0.3
@property (atomic, strong, readwrite) UIColor *deselectedColor; // default: nil

@property (atomic, strong, readwrite) UIFont *labelFont;		// default: bold, system, 12.5
@property (atomic, strong, readwrite) UIColor *labelColor;		// default: use self.color
@property (atomic, assign, readwrite) CGPoint labelOffset;							// default: CGPointZero

@property (atomic, assign, readwrite) CGFloat min;									// default: 0.0
@property (atomic, assign, readwrite) CGFloat max;									// default: 1.0
@property (atomic, assign, readwrite) CGFloat value;					// default: 0.0

@property (atomic, assign, readwrite) BOOL displaysValue;							// default: YES
@property (atomic, assign, readwrite) BOOL allowsGestures;							// default: YES

//@property (nonatomic, strong, readonly) RACSignal *rac_signalForValues;

- (id)initWithDelegate:(id)aDelegate;

/////////////////////
// Drawing Methods //
/////////////////////

- (void)context:(CGContextRef)context addRoundedRect:(CGRect)rect cornerRadius:(float)cornerRadius;

@end
