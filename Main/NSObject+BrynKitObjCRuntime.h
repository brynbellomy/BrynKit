//
//  NSObject+BrynKitObjCRuntime.h
//  BrynKit
//
//  Created by bryn austin bellomy on 7.27.13.
//  Copyright (c) 2013 bryn austin bellomy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (BrynKitObjCRuntime) {}

/**---------------------------------------------------------------------------------------
 * @name Method swizzling
 * ---------------------------------------------------------------------------------------
 */

#pragma mark- Method swizzling
#pragma mark-


/**
 * Example:
 *
 * Given a method signature like `- (NSString *) testMethod:(NSNumber *)someNum`, you can wrap a class's
 * implementation of that method like so (note that you have to cast the `IMP` return value to `void *`
 * at the moment):

      __block id(* originalImpl)(id, SEL, NSNumber *) = (void *)
          [MyClass bk_wrapMethod: @selector(testMethod:)
                       withBlock: ^id (id _self, NSNumber *someNum) {

          // do something special here

          // call the original implementation if you want
          id retval = originalImpl( _self, @selector(testMethod:), someNum );

          // change the return value if it suits your purposes
          return retval;

      }];

 * @return The IMP associated with the original method implementation.
 */
+ (IMP) bk_wrapMethod:(SEL)selector withBlock:(id (^)())block;

@end


/**---------------------------------------------------------------------------------------
 * @name Objective-C associated objects
 * ---------------------------------------------------------------------------------------
 */

#pragma mark- Objective-C associated objects
#pragma mark-

/** Objective-C wrapper for 10.6+ associated object API.

 In Mac OS X Snow Leopard and iOS 3.0, Apple introduced an addition to the
 Objective-C Runtime called associated objects. Associated objects allow for the
 pairing of a random key and object pair to be saved on an instance.

 In BlocksKit, associated objects allow us to emulate instance variables in the
 ategories we use.

 Class methods also exist for each association. These associations are unique to
 each class, and exist for the lifetime of the application unless set to `nil`.
 Each class is a unique meta-object; the ultimate singleton.

 Created by [Andy Matuschak](https://github.com/andymatuschak) as
 `AMAssociatedObjects`.
 */

@interface NSObject (BrynKit_AssociatedObjects)

/** Strongly associates an object with the reciever.

 The associated value is retained as if it were a property
 synthesized with `nonatomic` and `retain`.

 Using retained association is strongly recommended for most
 Objective-C object derivative of NSObject, particularly
 when it is subject to being externally released or is in an
 `NSAutoreleasePool`.

 @param value Any object.
 @param key A unique key pointer.
 */
- (void) bk_associateValue:(id)value withKey:(const void *)key;

/** Strongly associates an object with the receiving class.

 @see associateValue:withKey:
 @param value Any object.
 @param key A unique key pointer.
 */
+ (void) bk_associateValue:(id)value withKey:(const void *)key;

/** Strongly, thread-safely associates an object with the reciever.

 The associated value is retained as if it were a property
 synthesized with `atomic` and `retain`.

 Using retained association is strongly recommended for most
 Objective-C object derivative of NSObject, particularly
 when it is subject to being externally released or is in an
 `NSAutoreleasePool`.

 @see associateValue:withKey:
 @param value Any object.
 @param key A unique key pointer.
 */
- (void) bk_atomicallyAssociateValue:(id)value withKey:(const void *)key;

/** Strongly, thread-safely associates an object with the receiving class.

 @see associateValue:withKey:
 @param value Any object.
 @param key A unique key pointer.
 */
+ (void) bk_atomicallyAssociateValue:(id)value withKey:(const void *)key;

/** Associates a copy of an object with the reciever.

 The associated value is copied as if it were a property
 synthesized with `nonatomic` and `copy`.

 Using copied association is recommended for a block or
 otherwise `NSCopying`-compliant instances like NSString.

 @param value Any object, pointer, or value.
 @param key A unique key pointer.
 */
- (void) bk_associateCopyOfValue:(id)value withKey:(const void *)key;

/** Associates a copy of an object with the receiving class.

 @see associateCopyOfValue:withKey:
 @param value Any object, pointer, or value.
 @param key A unique key pointer.
 */
+ (void) bk_associateCopyOfValue:(id)value withKey:(const void *)key;

/** Thread-safely associates a copy of an object with the reciever.

 The associated value is copied as if it were a property
 synthesized with `atomic` and `copy`.

 Using copied association is recommended for a block or
 otherwise `NSCopying`-compliant instances like NSString.

 @see associateCopyOfValue:withKey:
 @param value Any object, pointer, or value.
 @param key A unique key pointer.
 */
- (void) bk_atomicallyAssociateCopyOfValue:(id)value withKey:(const void *)key;

/** Thread-safely associates a copy of an object with the receiving class.

 @see associateCopyOfValue:withKey:
 @param value Any object, pointer, or value.
 @param key A unique key pointer.
 */
+ (void) bk_atomicallyAssociateCopyOfValue:(id)value withKey:(const void *)key;

/** Weakly associates an object with the reciever.

 A weak association will cause the pointer to be set to zero
 or nil upon the disappearance of what it references;
 in other words, the associated object is not kept alive.

 @param value Any object.
 @param key A unique key pointer.
 */
- (void) bk_weaklyAssociateValue:(id)value withKey:(const void *)key;

/** Weakly associates an object with the receiving class.

 @see weaklyAssociateValue:withKey:
 @param value Any object.
 @param key A unique key pointer.
 */
+ (void) bk_weaklyAssociateValue:(id)value withKey:(const void *)key;

/** Returns the associated value for a key on the reciever.

 @param key A unique key pointer.
 @return The object associated with the key, or `nil` if not found.
 */
- (id) bk_associatedValueForKey:(const void *)key;

/** Returns the associated value for a key on the receiving class.

 @see associatedValueForKey:
 @param key A unique key pointer.
 @return The object associated with the key, or `nil` if not found.
 */
+ (id) bk_associatedValueForKey:(const void *)key;

/** Returns the reciever to a clean state by removing all
 associated objects, releasing them if necessary. */
- (void) bk_removeAllAssociatedObjects;

/** Returns the recieving class to a clean state by removing
 all associated objects, releasing them if necessary. */
+ (void) bk_removeAllAssociatedObjects;

@end
