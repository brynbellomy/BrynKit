# // bryn.h

# what

a collection of macros that have made developing in objective-c and iOS less
excruciating.

# contents

## i. settings/customization


### VERBOSE_NSLOG

if set to 1, this will add the filename and line num to NSLog calls



## ii. debugging/logging macros

### \_\_JUST\_FILENAME\_\_

the built-in macro `__FILE__` contains the entire path to a
file.  you don't often want that. this just gives you the file's actual name.


### BrynLog(formatString, ...)

this is the macro that replaces `NSLog` if you have `VERBOSE_NSLOG` set to 1.  if
you want to use it without replacing `NSLog`, leave `VERBOSE_NSLOG` set to 0 and
just call `BrynLog`.  same syntax as `NSLog()`.


### BrynFnLog(formatString, ...)

just like BrynLog/NSLog except that it prefixes the log message with the
function/selector name instead of the file and line num.



## iii. image-related macros

### UIImageWithBundlePNG(filenameWithoutExtension)

load a PNG file from the main bundle.  people use `+[UIImage imageNamed:]`
because it's much easier than the (minimum) method calls you have to make to
load a `UIImage` the 'right' way.  with a macro like this, there's no excuse.
note: the image filename you pass to this macro should not contain its file
extension (".png").



## iv. string-related macros

### SESameStrings(a, b)

tests two `NSStrings` for sameness, and also prevents the false positive that
occurs when you call `[A compare:B]` and `A` is `nil`.  this happens because
`NSOrderedSame == 0`, which is the same as the return value of any message sent
to `nil` -- namely, `nil` (or 0 if you cast to a numeric type).




## v. container-related macros

### SEObjectAtIndex(array, index)

calls `[array objectAtIndex:index]`, but first checks to make sure that the
array contains enough elements to even HAVE an object at the given index.  
warning: you may fail to notice bugs in your code when using this macro.
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






