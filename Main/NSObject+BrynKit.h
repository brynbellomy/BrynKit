//
//  NSObject+BrynKit.h
//  BrynKit
//
//  Created by bryn austin bellomy on 7.27.13.
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (BrynKit)

- (NSString *) bk_descriptionWithProperties:(NSArray *)properties __attribute__(( nonnull (1) ));
- (NSString *) bk_descriptionWithProperties:(NSArray *)properties separator:(NSString *)separator __attribute__(( nonnull (1, 2) ));
- (NSString *) bk_descriptionWithProperties:(NSArray *)properties separator:(NSString *)separator formatter:(NSString *(^)(NSString *property, id value))formatter __attribute__(( nonnull (1, 2, 3) ));
- (NSString *) bk_descriptionWithString:(NSString *)string __attribute__(( nonnull (1) ));

@end
