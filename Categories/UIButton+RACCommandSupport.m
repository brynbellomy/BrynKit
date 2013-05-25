//
//  UIButton+RACCommandSupport.m
//  Stan
//
//  Created by bryn austin bellomy on 4.23.13.
//  Copyright (c) 2013 robot bubble bath LLC. All rights reserved.
//

#import "UIButton+RACCommandSupport.h"
#import <ReactiveCocoa/RACCommand.h>
#import <ReactiveCocoa/RACSubscriptingAssignmentTrampoline.h>
#import <ReactiveCocoa/NSObject+RACPropertySubscribing.h>
#import <ReactiveCocoa/RACSignal+Operations.h>
#import <ReactiveCocoa/RACDisposable.h>
#import <objc/runtime.h>

static void * UIControlRACCommandKey = &UIControlRACCommandKey;
static void * UIControlRACCommandSignalKey = &UIControlRACCommandSignalKey;

@implementation UIButton (RACCommandSupport)

- (RACCommand *)rac_command {
	return objc_getAssociatedObject(self, UIControlRACCommandKey);
}

- (void)setRac_command:(RACCommand *)command {
	objc_setAssociatedObject(self, UIControlRACCommandKey, command, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

	if (command == nil) return;

	// Check for stored signal in order to remove it and add a new one
	RACDisposable *existingSignal = objc_getAssociatedObject(self, UIControlRACCommandSignalKey);
	[existingSignal dispose];

	RACDisposable *newSignal = [RACAbleWithStart(command, canExecute) toProperty:@keypath(self.enabled) onObject:self];
	objc_setAssociatedObject(self, UIControlRACCommandSignalKey, newSignal, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

	[self addTarget:self action:@selector(rac_commandPerformAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)rac_commandPerformAction:(id)sender {
	[self.rac_command execute:sender];
}

@end
