# // BrynKit

# what

a collection of macros and other helpers that have made developing in
objective-c and iOS less excruciating.


# settable settings

- **VERBOSE_NSLOG**: if set to 1, this will add the filename and line num to NSLog calls
- **SILENCE_NSLOG**: if set to 1, all calls to NSLog become no-ops
- **LOG\_MACROS\_ARE\_ACTIVE**: easily turn off all changes to logging
- **NSLOG\_TO\_TESTFLIGHT**: redirect all `NSLog()` calls to `TFLog()`, which sends them to TestFlight
- **AUTOMATIC\_LOG\_COLORS**: automatically colorize `NSLog()` (or `BrynLog()`, as the case may be) output in the xcode console



# debugging/logging macros


## color logging for xcode's debug console

these macros are intended to make using the **XcodeColors** plugin
([DeepIT/XcodeColors](https://github.com/DeepIT/XcodeColors)) easier.



### predefined rgb colors

These macros evaluate to a regular NSString literal, so you can simply
concatenate them into an NSString expression like so:

`NSLog(@"Blah blah" COLOR_RED @"This will be red" XCODE_COLORS_RESET @"This will not");`

- `COLOR_RED`
- `COLOR_YELLOW`
- `COLOR_OLIVE`
- `COLOR_GREEN`
- `COLOR_PURPLE`
- `COLOR_BLUE`



### a predefined color logging "theme"

These are actual `#define` macros, accepting an `NSString *` argument.  The
reason is that they add an `XCODE_COLORS_RESET` after the passed argument.

- `COLOR_ERROR(str)`
- `COLOR_SUCCESS(str)`
- `COLOR_FILENAME(str)`
- `COLOR_LINE(str)`
- `COLOR_FUNC(str)`

For example:

```objective-c
NSLog(COLOR_ERROR(@"You screwed up") @"... but it'll be okay.");
```


## \_\_JUST\_FILENAME\_\_

the built-in macro `__FILE__` contains the entire path to a
file.  you don't often want that. this just gives you the file's actual name.


## BrynLog(formatString, ...)

this is the macro that replaces `NSLog` if you have `VERBOSE_NSLOG` set to 1.  if
you want to use it without replacing `NSLog`, leave `VERBOSE_NSLOG` set to 0 and
just call `BrynLog`.  same syntax as `NSLog()`.


## BrynFnLog(formatString, ...)

just like BrynLog/NSLog except that it prefixes the log message with the
function/selector name instead of the file and line num.



# image-related macros

## UIImageWithBundlePNG(filenameWithoutExtension)

load a PNG file from the main bundle.  people use `+[UIImage imageNamed:]`
because it's much easier than the (minimum) method calls you have to make to
load a `UIImage` the 'right' way.  with a macro like this, there's no excuse.
note: the image filename you pass to this macro should not contain its file
extension (".png").



# system macros

## BrynKit_StartOccasionalMemoryLog()

Starts a timer that spits out the device's currently available memory at an interval
you specify.

```objc
@property (nonatomic, strong, readwrite) SEDispatchSource *memoryUsageLogTimer;
```

... and then in your setup code:

```objc
NSTimeInterval intervalInSeconds = 5.0f;

self.memoryUsageLogTimer =
    BrynKit_StartOccasionalMemoryLog(intervalInSeconds, ^(NSString *msg) {
        NSLog(@"%@", msg);
    });
yssert_notNilAndIsClass(self.memoryUsageLogTimer, SEDispatchSource);
```



# license (WTFPL v2)

DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
Version 2, December 2004

Copyright (C) 2004 Sam Hocevar <[sam@hocevar.net](mailto:sam@hocevar.net)>

Everyone is permitted to copy and distribute verbatim or modified 
copies of this license document, and changing it is allowed as long 
as the name is changed. 

DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION

0. You just DO WHAT THE FUCK YOU WANT TO. 






