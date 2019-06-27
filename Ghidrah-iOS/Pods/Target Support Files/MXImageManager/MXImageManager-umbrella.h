#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "MXImageCache.h"
#import "UIImage+MXAdd.h"
#import "UIImageView+MXAdd.h"

FOUNDATION_EXPORT double MXImageManagerVersionNumber;
FOUNDATION_EXPORT const unsigned char MXImageManagerVersionString[];

