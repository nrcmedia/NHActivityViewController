//
// NHActivity.h
// NHActivityViewController
//
// Copyright (c) 2013 Roman Efimov (https://github.com/romaonthego)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import <Foundation/Foundation.h>

@class NHActivityViewController;

extern NSString* const NHActivityTypePostToFacebook;
extern NSString* const NHActivityTypePostToTwitter;
extern NSString* const NHActivityTypePostToWeibo;
extern NSString* const NHActivityTypeMail;
extern NSString* const NHActivityTypeMessage;
extern NSString* const NHActivityTypePrint;
extern NSString* const NHActivityTypeCopyToPasteboard;
extern NSString* const NHActivityTypeAssignToContact;
extern NSString* const NHActivityTypeSaveToCameraRoll;
extern NSString* const NHActivityTypeAddToReadingList;
extern NSString *const NHActivityTypePostToFlickr;
extern NSString *const NHActivityTypePostToVimeo;
extern NSString *const NHActivityTypePostToTencentWeibo;
extern NSString *const NHActivityTypeAirDrop;


#if __IPHONE_OS_VERSION_MAX_ALLOWED <= __IPHONE_6_1
//Defined in iOS7
extern NSString *const UIActivityTypeAddToReadingList;
extern NSString *const UIActivityTypePostToFlickr;
extern NSString *const UIActivityTypePostToVimeo;
extern NSString *const UIActivityTypePostToTencentWeibo;
extern NSString *const UIActivityTypeAirDrop;
#endif

@interface NHActivity : NSObject

@property (strong, readonly, nonatomic) NSString *activityType;
@property (strong, readonly, nonatomic) NSString *activityTitle;
@property (strong, readonly, nonatomic) UIImage *activityImage;

@property (weak, nonatomic) NHActivityViewController* delegate;

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems;
- (void)prepareWithActivityItems:(NSArray*)activityItems;
- (void)performActivity;
- (void)activityDidFinish:(BOOL)completed;
- (UIViewController*)activityPerformingViewController;
@end
