//
//  Bryn.h
//
//  Created by bryn austin bellomy on 7/18/12.
//  Copyright (c) 2012 robot bubble bath LLC. All rights reserved.
//

#ifndef __Bryn__
#define __Bryn__  // is this even possible????


/*************************************/
#pragma mark- settable settings
#pragma mark-
/*************************************/

#define VERBOSE_NSLOG 0 // if set to 1, this will add the filename and line num to NSLog calls





/*************************************/
#pragma mark- logging and debug macros
#pragma mark-
/*************************************/

// __FILE__ contains the entire path to a file.  this #define only gives you the file's actual name.
#define __JUST_FILENAME__ [[NSString stringWithUTF8String:__FILE__] lastPathComponent]

// this is the macro that replaces NSLog if you have VERBOSE_NSLOG set to 1.  if you want to use it
// without replacing NSLog, leave VERBOSE_NSLOG set to 0 and just call BrynLog.
#define BrynLog(__FORMAT__, ...) NSLog(@"[%@:%d] %@", __JUST_FILENAME__, __LINE__, [NSString stringWithFormat:__FORMAT__, ##__VA_ARGS__])

// replace NSLog with BrynLog
#if VERBOSE_NSLOG == 1
  #define NSLog(__FORMAT__, ...) BrynLog(__FORMAT__, ##__VA_ARGS__)
#endif

// like BrynLog except it logs the function/selector name instead of the file and line num.
#define BrynFnLog(__FORMAT__, ...) NSLog(@"%s > %@", __func__, [NSString stringWithFormat:__FORMAT__, ##__VA_ARGS__])





/*************************************/
#pragma mark- image-related macros
#pragma mark-
/*************************************/

// UIImageWithBundlePNG(filenameWithoutExtension)
//
// load a PNG file from the main bundle.  people use +[UIImage imageNamed:]
// because it's much easier than the (minimum) method calls you have to make to
// load a UIImage the 'right' way.  with a macro like this, there's no excuse.
// note: the image filename you pass to this macro should not contain its file
// extension (".png").
#if !defined(UIImageWithBundlePNG)
  #define UIImageWithBundlePNG(x) ([UIImage imageWithContentsOfFile: [[NSBundle mainBundle] pathForResource: [NSString stringWithFormat:(x)] ofType: @"png"]])
#endif






/*************************************/
#pragma mark- string-related macros
#pragma mark-
/*************************************/

// SESameStrings(a, b)
//
// tests two NSStrings for sameness, and also prevents the false positive that
// occurs when you call [A compare:B] and A is nil.  this happens because
// NSOrderedSame == 0, which is the same as the return value of any message sent
// to nil -- that is, nil.
#if !defined(SESameStrings)
  #define SESameStrings(x, y) (BOOL)((x != nil) && ([(NSString *)(x) compare:(NSString *)(y)] == NSOrderedSame))
#endif




/*************************************/
#pragma mark- container-related macros
#pragma mark-
/*************************************/

// SEObjectAtIndex(array, index)
//
// calls [array objectAtIndex:index], but first checks to make sure that the
// array contains enough elements to even HAVE an object at the given index.  
// warning: you may fail to notice bugs in your code when using this macro.
// exceptions get thrown for a reason, y'heard?
#if !defined (SEObjectAtIndex)
  #define SEObjectAtIndex(array, index) (array.count >= (index + 1) ? [array objectAtIndex:index] : nil)
#endif


#endif
