//
//  NSDictionary+BrynKit.h
//  BrynKit
//
//  Created by bryn austin bellomy on 8.2.13.
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bryn.h"

@interface NSDictionary (BrynKit)

- (NSDictionary *) bk_remapKeys:(BKRemapBlock)block;
- (NSArray *) bk_sortedKeysByComparingSubkey:(NSString *)subkey;

@end
