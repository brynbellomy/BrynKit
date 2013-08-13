//
//  NSObject+BrynKit.m
//  BrynKit
//
//  Created by bryn austin bellomy on 7.27.13.
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//

#import <libextobjc/EXTScope.h>
#import "BrynKit-Main.h"
#import "NSObject+BrynKit.h"

@implementation NSObject (BrynKit)

- (NSString *) bk_descriptionWithProperties: (NSArray *)properties
{
    return [self bk_descriptionWithProperties: properties
                                    separator: @"\r"];
}

- (NSString *) bk_descriptionWithProperties: (NSArray *)properties
                                  separator: (NSString *)separator
{
    return [self bk_descriptionWithProperties: properties
                                    separator: separator
                                    formatter: ^NSString *(NSString *property, id value) {
                                        return $str(@"    %@ = %@;", property, value);
                                    }];
}

- (NSString *) bk_descriptionWithProperties: (NSArray *)properties
                                  separator: (NSString *)separator
                                  formatter: (NSString *(^)(NSString *property, id value))formatter
{
    NSMutableArray *formattedProperties = [NSMutableArray arrayWithCapacity:properties.count];
    for ( id property in properties )
    {
        id formattedProperty = formatter(property, [self valueForKey:property]);
        [formattedProperties addObject:formattedProperty];
    }

    NSString *propertyDescriptions = [formattedProperties componentsJoinedByString:separator];

    return [self bk_descriptionWithString:propertyDescriptions];
}

- (NSString *) bk_descriptionWithString:(NSString *)string
{
	return [NSString stringWithFormat:@"<%@: %p; = {\n%@\n}>", [[self class] description], self, string];
}

@end
