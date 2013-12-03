//
// NHActivity.m
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

#import "NHActivity.h"
#import "NHActivityViewController.h"

NSString* const NHActivityTypePostToFacebook = @"PostToFacebook";
NSString* const NHActivityTypePostToTwitter = @"PostToTwitter";
NSString* const NHActivityTypePostToWeibo = @"PostToWeibo";
NSString* const NHActivityTypeMail = @"Mail";
NSString* const NHActivityTypeMessage = @"Message";
NSString* const NHActivityTypePrint = @"Print";
NSString* const NHActivityTypeCopyToPasteboard = @"CopyToPasteboard";
NSString* const NHActivityTypeAssignToContact = @"AssignToContact";
NSString* const NHActivityTypeSaveToCameraRoll = @"SaveToCameraRoll";
NSString* const NHActivityTypeAddToReadingList = @"AddToReadingList";
NSString *const NHActivityTypePostToFlickr = @"PostToFlickr";
NSString *const NHActivityTypePostToVimeo = @"PostToVimeo";
NSString *const NHActivityTypePostToTencentWeibo = @"PostToTencentWeibo";
NSString *const NHActivityTypeAirDrop = @"AirDrop";



#if __IPHONE_OS_VERSION_MAX_ALLOWED <= __IPHONE_6_1
//Defined in iOS7
NSString *const UIActivityTypeAddToReadingList = @"com.apple.UIKit.activity.AddToReadingList";
NSString *const UIActivityTypePostToFlickr = @"com.apple.UIKit.activity.PostToFlickr";
NSString *const UIActivityTypePostToVimeo = @"com.apple.UIKit.activity.PostToVimeo";
NSString *const UIActivityTypePostToTencentWeibo = @"com.apple.UIKit.activity.TencentWeibo";
NSString *const UIActivityTypeAirDrop = @"com.apple.UIKit.activity.AirDrop";
#endif

@implementation NHActivity

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems {
    return NO;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems {
}

- (void)performActivity {
    [self activityDidFinish:YES];
}

- (void)activityDidFinish:(BOOL)completed {
    [self.delegate didFinishActivity:self completed:completed];
}

- (UIViewController *)activityPerformingViewController {
    return nil;
}
@end
