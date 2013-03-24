# a wee word aboat GCD threadsafe'ing (ah blarney queue)

The GCD foundation upon which `StateMachine-GCDThreadsafe` relies is very simple, very concise, and very widely applicable.

Its primary implementation resides in the [BrynKit library](http://github.com/brynbellomy/BrynKit) (also on CocoaPods),
in `GCDThreadsafe.h`.

The main idea with this thing is to make it extremely familiar.  It more or less looks and acts like an old-school Objective-C `@synchronized` block (pfffff yeah I said "old school" -- look I'm trying to forcefully phase out `@synchronized` -- it's some slow ass grandma shit and has no place in the future next to the flying cars).  You can use nearly the same patterns, the only real exception being the `@strongify(self)` and `@weakify(self)` boilerplate stuff (which simply exists to prevent block-related retain cycles).

In practice, it sometimes looks like this:

```objective-c
@weakify(self);
[self runCriticalMutableSection:^{
    @strongify(self);
    self.someProperty = @"a new value";
    [self.otherProperty someMutationMethodReturningNothingInteresting];
}];
```

...and sometimes like this:

```objective-c
__block NSString *synchronizedValue = nil;

@weakify(self);
[self runCriticalReadonlySection:^{
    @strongify(self);
    
    synchronizedValue = [_someHiddenIvar copy];
    
    // mutation is fine in "read" sections.  obviously need to rename this method.
    self.someProperty = @"a new value";
}];

NSLog(@"synchronizedValue = %@", synchronizedValue);
```

You can add this functionality to any class easily:

1. `#import <StateMachine-GCDThreadsafe/LSStative.h>` (or the umbrella header, `<StateMachine-GCDThreadsafe/StateMachine.h>`)
    
2. Add the `@gcd_threadsafe` macro/annotation to your class's `@implementation` block.  This macro
    is syntactical fuckin maple syrup -- take a look at its definition so you know what's going down
    in the trap.

    ```objective-c
    @implementation ScranglyBones
    @gcd_threadsafe
    
    - (instancetype) initWithScrangleTums:(WangleBums *)tanglyChums
    {
    ```

3. In your designated initializer, initialize `_queueCritical`, the private `dispatch_queue_t` ivar
    on which shit's gonna be goin down.  And make sure you initialize it before doing anything else
    or you might accidentally call methods that rely on GCD synchronization before it's had a chance
    to get bootstrapped:
    
    ```objective-c
    self = [super init];
    if (self) {
        _queueCritical = dispatch_queue_create("com.pton.queueCritical", 0);
        // ...
    ```

As long as you divide your critical sections into two groups:

+ **"mutate" sections**
    - can write to any critical properties/ivars read values out through the boundaries of the synchronizer queue.
    - dispatched as __async__ barrier blocks.  fast as lightning.  synchronized but don't
      necessarily run immediately.
+ **"read" sections**
    - can do anything, including read values through synchronizer queue boundaries.
    - dispatched as __sync__ barrier blocks.  synchronized and run immediately.

... the framework will (should? ... might???) line everything up as it oughta be.  This is an alpha release, to be
sure, so I'd very much welcome any traffic that would like to make its way into the issue queue.



