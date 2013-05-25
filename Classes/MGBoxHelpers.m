//
//  MGBoxHelpers.m
//  BrynKit
//
//  Created by bryn austin bellomy on 4.2.2013.
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//

#import "BrynKit.h"
#import "RACFuture.h"

#import <ReactiveCocoa/ReactiveCocoa.h>
#import <MGBox2/MGBox.h>
#import <MGBox2/MGTableBox.h>
#import <MGBox2/MGLine.h>
#import "RACHelpers.h"


@implementation MGBox (BrynKit)

- (RACSignal *) rac_onTap
{
    // @@TODO: enable 'tappable' whenever this is subscribed to
//    self.tappable = YES;

   return [[RACSignal combineLatest:@[ [self.tapper                     rac_signalForGestures],
                                       [RACAbleWithStart(self.tappable)  distinctUntilChanged], ]

                             reduce:^id (UIGestureRecognizer *recognizer, NSNumber *tappable) {
                                 return (tappable.boolValue == NO ? nil : self);
                             }]
                             notNil];
}



- (RACFuture *) bryn_setBoxes:(NSMutableOrderedSet *)boxes
           andLayoutWithSpeed:(NSTimeInterval)speed
{
    yssert_onMainThread();

    [self.boxes removeAllObjects];
    [self layout];

    [self.boxes addObjectsFromArray: [boxes array]];

    RACFuture *future = [RACFuture future];
    [self layoutWithSpeed:speed completion:^{ [future resolve]; }];

    return future;
}

@end



@implementation MGTableBox (BrynKit)

- (RACFuture *) bryn_setTopLines: (NSArray *)topLines
              andLayoutWithSpeed: (NSTimeInterval)speed
{
    yssert_onMainThread();

    [self.topLines removeAllObjects];
    [self.boxes removeAllObjects];
    [self layout];

    [self.topLines addObjectsFromArray:topLines];

    RACFuture *future = [RACFuture future];
    [self layoutWithSpeed:speed completion:^{ [future resolve]; }];

    return future;
}



- (RACFuture *) bryn_setMiddleLines: (NSArray *)middleLines
                 andLayoutWithSpeed: (NSTimeInterval)speed
{
    yssert_onMainThread();

    [self.middleLines removeAllObjects];
    [self.boxes removeAllObjects];
    [self layout];

    [self.middleLines addObjectsFromArray:middleLines];

    RACFuture *future = [RACFuture future];
    [self layoutWithSpeed:speed completion:^{ [future resolve]; }];

    return future;
}



- (RACFuture *) bryn_setBottomLines: (NSArray *)bottomLines
                 andLayoutWithSpeed: (NSTimeInterval)speed
{
    yssert_onMainThread();

    [self.bottomLines removeAllObjects];
    [self.boxes removeAllObjects];
    [self layout];

    [self.bottomLines addObjectsFromArray:bottomLines];
    [self layoutWithSpeed:speed completion:nil];

    RACFuture *future = [RACFuture future];
    [self layoutWithSpeed:speed completion:^{ [future resolve]; }];

    return future;
}

@end



@implementation MGLine (BrynKit)

- (RACFuture *) bryn_setLeftItems: (NSArray *)leftItems
               andLayoutWithSpeed: (NSTimeInterval)speed
{
    yssert_onMainThread();

    [self.leftItems removeAllObjects];
    [self.boxes removeAllObjects];
    [self layout];

    [self setLeftItems:(NSMutableArray *)leftItems];

    RACFuture *future = [RACFuture future];
    [self layoutWithSpeed:speed completion:^{ [future resolve]; }];

    return future;
}



- (RACFuture *) bryn_setMiddleItems: (NSArray *)middleItems
                 andLayoutWithSpeed: (NSTimeInterval)speed
{
    yssert_onMainThread();

    [self.middleItems removeAllObjects];
    [self.boxes removeAllObjects];
    [self layout];

    [self setMiddleItems:(NSMutableArray *)middleItems];

    RACFuture *future = [RACFuture future];
    [self layoutWithSpeed:speed completion:^{ [future resolve]; }];

    return future;
}



- (RACFuture *) bryn_setRightItems: (NSArray *)rightItems
                andLayoutWithSpeed: (NSTimeInterval)speed
{
    yssert_onMainThread();

    [self.rightItems removeAllObjects];
    [self.boxes removeAllObjects];
    [self layout];

    [self setRightItems:(NSMutableArray *)rightItems];
    [self layoutWithSpeed:speed completion:nil];

    RACFuture *future = [RACFuture future];
    [self layoutWithSpeed:speed completion:^{ [future resolve]; }];

    return future;
}



- (RACFuture *) bryn_setMultilineLeft: (NSString *)multilineLeft
                   andLayoutWithSpeed: (NSTimeInterval)speed
{
    yssert_onMainThread();

//    [self.multilineLeft removeAllObjects];
//    [self.boxes removeAllObjects];
//    [self layout];

    self.multilineLeft = multilineLeft;

    RACFuture *future = [RACFuture future];
    [self layoutWithSpeed:speed completion:^{ [future resolve]; }];

    return future;
}

@end




