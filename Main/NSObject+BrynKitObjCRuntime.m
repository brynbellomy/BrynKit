//
//  NSObject+BrynKitObjCRuntime.m
//  BrynKit
//
//  Created by bryn austin bellomy on 7.27.13.
//  Copyright (c) 2013 signalenvelope llc. All rights reserved.
//

#import <objc/objc.h>
#import <objc/runtime.h>

#import "BrynKit-Main.h"
#import "NSObject+BrynKitObjCRuntime.h"

@implementation NSObject (BrynKitObjCRuntime)

#pragma mark- Method swizzling
#pragma mark-

+ (IMP) bk_wrapMethod: (SEL)selector
            withBlock: (id (^)())block
{
    yssert_notNil( block );

    Method      originalMethod = class_getInstanceMethod( self, selector );                                         yssert_notNil( originalMethod );
    const char *typeEncoding   = method_getTypeEncoding( originalMethod );                                          yssert_notNull( typeEncoding );
    IMP         originalImpl   = method_getImplementation( originalMethod );                                        yssert_notNull( originalImpl );

    SEL wrapperSel    = NSSelectorFromString( $str( @"bk_wrapper_%@",  NSStringFromSelector( selector ) ) );        yssert_notNull( wrapperSel );
    IMP wrapperImpl   = imp_implementationWithBlock( block );                                                       yssert_notNull( wrapperImpl );

    BOOL success = class_addMethod( self, wrapperSel, wrapperImpl, typeEncoding );                                  yssert( success );
    if ( !success )
    {
        lllog( Error, @"Could not add block method with selector '%@' to class '%@'.", NSStringFromSelector(selector), NSStringFromClass(self.class) );
        return NULL;
    }

    Method wrapperMethod = class_getInstanceMethod( self, wrapperSel );                                             yssert_notNil( wrapperMethod );
    yssert( strcmp(method_getTypeEncoding(originalMethod), method_getTypeEncoding(wrapperMethod)) == 0, @"Encoding must be the same." );

    method_exchangeImplementations( originalMethod, wrapperMethod );

    return originalImpl;
}

//- (void)   bk_forSelector: (SEL)selector
//         setPreconditions: (dispatch_block_t)preconditions
//{
//    [self bk_wrapMethod:selector withBlock:^{}];
//}


//- (void)   bk_forSelector: (SEL)selector
//         setPreconditions: (dispatch_block_t)preconditions
//{
////    static NSDictionary *contractsInfo = nil;
////    if (contractsInfo == nil)
////    {
////        contractsInfo = (NSDictionary *) [[self class] associatedValueForKey: BKContractsForClass];
////    }
//    NSMutableDictionary *contractsInfo = (NSMutableDictionary *) [[self class] associatedValueForKey: BKContractsForClass];
//    if ( contractsInfo == nil )
//    {
//        contractsInfo = @{}.mutableCopy;
//
//        [[self class] associateValue: contractsInfo
//                             withKey: BKContractsForClass];
//    }
//
//    contractsInfo[ NSStringFromSelector(selector) ] = preconditions;
//}
//
//
//BKDefineVoidKey( BKContractsForClass );
//
//- (NSString *) contractWrapper_testMethod:(NSNumber *)someNum
//{
//    NSString *strSelector = ({
//        NSMutableArray *selectorParts = [NSStringFromSelector( _cmd ) componentsSeparatedByString:@":"].mutableCopy;
//        [selectorParts removeObjectAtIndex:0];
//        [selectorParts componentsJoinedByString:@":"];
//    });
//
//    NSDictionary *selectors = (NSDictionary *)[[self class] associatedValueForKey: BKContractsForClass];
//    NSDictionary *contractInfo = selectors[ strSelector ];
//
//    void(^preconditionsBlock) ( void ) = contractInfo[ @"pre"  ] ?: nil;
//    void(^postconditionsBlock)( id )   = contractInfo[ @"post" ] ?: nil;
//
//    if (preconditionsBlock) { preconditionsBlock(); }
//
////    id retval = [self CALL_ORIGINAL_METHOD];
//    id retval = [self contractWrapper_testMethod: someNum];
//
//    if (postconditionsBlock) { postconditionsBlock( retval ); }
//
//    return retval;
//}
//
//
//- (NSString *) testMethod:(NSNumber *)someNum
//{
//
//    /** GENERATED **/
//    //    static NSMutableDictionary *bk_contractInfo = nil;
//    //    static void(^bk_preconditions)(void) = nil;
//    //    static void(^bk_postconditions)(void *) = nil;
//
//    //    if ( ! bk_contractInfo )  { bk_contractInfo = @{}.mutableCopy; }
//
//    //    static dispatch_once_t onceToken;
//    //    dispatch_once(&onceToken, ^{
//    //        NSDictionary *bk_contractInfo = (NSDictionary *)[[self class] associatedValueForKey: BKContractsForClass];
//    //
//    //        bk_preconditions  = bk_contractInfo[ @"pre"  ] ?: nil;
//    //        bk_postconditions = bk_contractInfo[ @"post" ] ?: nil;
//    //    });
//
//
//    /** / GENERATED **/
//
//    //    bk_preconditions = ^{
//    //        yssert( someNum.bk_uint > 7 );
//    //    };
//    //
//    //    bk_postconditions = ^(void *retval) {
//    //
//    //    };
//    
//    NSLog( @"[xyzzy testMethod:] someNum = %@", someNum );
//    return @"some string";
//}



#pragma mark- Objective-C associated objects

#pragma mark-
#pragma mark Instance methods

- (void) bk_associateValue:(id)value withKey:(const void *)key {
	objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void) bk_atomicallyAssociateValue:(id)value withKey:(const void *)key {
	objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN);
}

- (void) bk_associateCopyOfValue:(id)value withKey:(const void *)key {
	objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void) bk_atomicallyAssociateCopyOfValue:(id)value withKey:(const void *)key {
	objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_COPY);
}

- (void) bk_weaklyAssociateValue:(id)value withKey:(const void *)key {
	objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_ASSIGN);
}

- (id) bk_associatedValueForKey:(const void *)key {
	return objc_getAssociatedObject(self, key);
}

- (void) bk_removeAllAssociatedObjects {
	objc_removeAssociatedObjects(self);
}

#pragma mark-
#pragma mark Class methods

+ (void) bk_associateValue:(id)value withKey:(const void *)key {
	objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void) bk_atomicallyAssociateValue:(id)value withKey:(const void *)key {
	objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN);
}

+ (void) bk_associateCopyOfValue:(id)value withKey:(const void *)key {
	objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

+ (void) bk_atomicallyAssociateCopyOfValue:(id)value withKey:(const void *)key {
	objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_COPY);
}

+ (void) bk_weaklyAssociateValue:(id)value withKey:(const void *)key {
	objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_ASSIGN);
}

+ (id) bk_associatedValueForKey:(const void *)key {
	return objc_getAssociatedObject(self, key);
}

+ (void) bk_removeAllAssociatedObjects {
	objc_removeAssociatedObjects(self);
}


@end
