//
// NHCopyActivity.m
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

#import "NHCopyActivity.h"
#import "NHActivityViewController.h"

@interface NHCopyActivity()
@property (nonatomic,strong) UIImage* image;
@property (nonatomic,strong) NSString* text;
@property (nonatomic,strong) NSURL* URL;
@end

@implementation NHCopyActivity

- (NSString *)activityType {
    return NHActivityTypeCopyToPasteboard;
}

- (NSString *)activityTitle {
    return NSLocalizedStringFromTable(@"activity.Copy.title", @"NHActivityViewController", @"Copy");
}

-(UIImage *)activityImage {
    return [UIImage imageNamed:@"NHActivityViewController.bundle/Icon_Copy"];
}

- (BOOL)canPerformWithActivityItems:(NSArray*)activityItems {
    for (id item in activityItems) {
        if (  [item isKindOfClass:[NSString class]]
            || [item isKindOfClass:[UIImage class]]
            || [item isKindOfClass:[NSURL class]]
            )
        {
            return YES;
        }
    }
    return NO;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems {
    for (id item in activityItems) {
        if ([item isKindOfClass:[NSString class]]) {
            self.text = item;
        } else if([item isKindOfClass:[UIImage class]]) {
            self.image = item;
        } else if([item isKindOfClass:[NSURL class]]) {
            self.URL = item;
        }
    }
}

- (void)performActivity {
    NSMutableDictionary * pasteboardDict = [NSMutableDictionary dictionary];
    if (self.text)
        [pasteboardDict setValue:self.text forKey:@"public.utf8-plain-text"];
    if (self.URL)
        [pasteboardDict setValue:self.URL forKey:@"public.url"];
    if (self.image) {
        NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation(self.image)];
        [pasteboardDict setObject:imageData forKey:@"public.png"];
    }
    [UIPasteboard generalPasteboard].items = [NSArray arrayWithObject:pasteboardDict];
    [self activityDidFinish:YES];
}

@end
