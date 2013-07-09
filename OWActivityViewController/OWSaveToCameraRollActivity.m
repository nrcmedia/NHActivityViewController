//
// OWSaveToCameraRollActivity.m
// OWActivityViewController
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

#import "OWSaveToCameraRollActivity.h"
#import "OWActivityViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface OWSaveToCameraRollActivity()
@property (nonatomic,strong) UIImage* image;
@end

@implementation OWSaveToCameraRollActivity

- (NSString *)activityType {
    return OWActivityTypeSaveToCameraRoll;
}

- (NSString *)activityTitle {
    return NSLocalizedStringFromTable(@"activity.CameraRoll.title", @"OWActivityViewController", @"Save to Camera Roll");
}

- (UIImage *)activityImage {
    return [UIImage imageNamed:@"OWActivityViewController.bundle/Icon_Photos"];
}

- (BOOL)canPerformWithActivityItems:(NSArray*)activityItems {
    for (id item in activityItems) {
        if ([item isKindOfClass:[UIImage class]])
        {
            return YES;
        }
    }
    return NO;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems {
    for (id item in activityItems) {
        if([item isKindOfClass:[UIImage class]]) {
            self.image = item;
        }
    }
}

- (void)performActivity {
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    __weak OWSaveToCameraRollActivity* weakSelf = self;
    [library writeImageToSavedPhotosAlbum:self.image.CGImage
                              orientation:(ALAssetOrientation)self.image.imageOrientation
                          completionBlock:^(NSURL *assetURL, NSError *error) {
                              BOOL completed = error == nil;
                              [weakSelf activityDidFinish:completed];
                          }];
    
}

@end
