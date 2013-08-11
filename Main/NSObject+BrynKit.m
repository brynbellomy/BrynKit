//
//  NSObject+BrynKit.m
//  BrynKit
//
//  Created by bryn austin bellomy on 7.27.13.
//  Copyright (c) 2013 signalenvelope llc. All rights reserved.
//

#import <libextobjc/EXTScope.h>
#import <ObjectiveSugar/ObjectiveSugar.h>

#import "BrynKit-Main.h"
#import "NSObject+BrynKit.h"

@implementation NSObject (BrynKit)

- (NSString *) bk_descriptionWithProperties: (NSArray *)properties
{
    return [self bk_descriptionWithProperties:properties
                                      separator:@"\r"];
}

- (NSString *) bk_descriptionWithProperties:(NSArray *)properties
                                    separator:(NSString *)separator
{
    return [self bk_descriptionWithProperties:properties
                                      separator:separator
                                      formatter:^NSString *(NSString *property, id value) {
                                          return $str(@"    %@ = %@;", property, value);
                                      }];

}

- (NSString *) bk_descriptionWithProperties: (NSArray *)properties
                                    separator: (NSString *)separator
                                    formatter: (NSString *(^)(NSString *property, id value))formatter
{
    @weakify(self);

    NSString *propertyDescriptions = [[properties
                                           map:^NSString *(NSString *property) {
                                               @strongify(self);
                                               return formatter(property, [self valueForKey:property]);
                                           }]
                                           componentsJoinedByString:separator];

    return [self bk_descriptionWithString:propertyDescriptions];
}

- (NSString *) bk_descriptionWithString:(NSString *)string
{
	return [NSString stringWithFormat:@"<%@: %p; = {\n%@\n}>", [[self class] description], self, string];
}

@end
