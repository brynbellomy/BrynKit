# // BrynKit

# what

a collection of macros and other helpers that have made developing in
objective-c and iOS less excruciating.  the CocoaPods podspec also contains a
few subspecs for libraries that i tend to use a lot:

- ObjC-DesignByContract ([brynbellomy/ObjC-DesignByContract](http://github.com/brynbellomy/ObjC-DesignByContract))
- Underscore.m ([underscorem.org](http://underscorem.org))
- ConciseKit ([petejkim/ConciseKit](http://github.com/petejkim/ConciseKit))
- MAObjCRuntime ([mikeash/MAObjCRuntime](http://github.com/mikeash/MAObjCRuntime))


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



# container-related macros

## SEObjectAtIndex(array, index)

calls `[array objectAtIndex:index]`, but first checks to make sure that the
array contains enough elements to even HAVE an object at the given index. 
**warning:** you may fail to notice bugs in your code when using this macro.
exceptions get thrown for a reason, y'heard?



# license

Copyright (c) 2012 bryn austin bellomy < <bryn.bellomy@gmail.com> >

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in the
Software without restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the
Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.






