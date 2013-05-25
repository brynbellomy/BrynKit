//
//  MGBoxHelpers.h
//  BrynKit
//
//  Created by bryn austin bellomy on 4.2.2013.
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//

#import <MGBox2/MGBox.h>
#import <MGBox2/MGLine.h>
#import <MGBox2/MGTableBox.h>

#import "RACFuture.h"

#define SEMGBoxFlattenAppearance(box) \
    do { \
        box.layer.shadowColor = nil; \
        box.layer.shadowOffset = CGSizeZero; \
        box.layer.shadowRadius = 0; \
        box.layer.shadowOpacity = 0; \
        box.borderStyle = MGBorderNone; \
    } while(0)



@interface MGBox (BrynKit)

- (RACSignal *) rac_onTap;
- (RACFuture *) bryn_setBoxes:(NSMutableOrderedSet *)boxes andLayoutWithSpeed:(NSTimeInterval)speed;

@end

@interface MGLine (BrynKit)

- (RACFuture *) bryn_setLeftItems:   (NSArray *)leftItems   andLayoutWithSpeed:(NSTimeInterval)speed;
- (RACFuture *) bryn_setMiddleItems: (NSArray *)middleItems andLayoutWithSpeed:(NSTimeInterval)speed;
- (RACFuture *) bryn_setRightItems:  (NSArray *)rightItems  andLayoutWithSpeed:(NSTimeInterval)speed;

- (RACFuture *) bryn_setMultilineLeft:(NSString *)multilineLeft andLayoutWithSpeed:(NSTimeInterval)speed;

@end


@interface MGTableBox (BrynKit)

- (RACFuture *) bryn_setTopLines:(NSArray *)topLines       andLayoutWithSpeed:(NSTimeInterval)speed;
- (RACFuture *) bryn_setMiddleLines:(NSArray *)middleLines andLayoutWithSpeed:(NSTimeInterval)speed;
- (RACFuture *) bryn_setBottomLines:(NSArray *)bottomLines andLayoutWithSpeed:(NSTimeInterval)speed;

@end







