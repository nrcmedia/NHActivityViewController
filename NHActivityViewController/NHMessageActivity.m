//
// NHMessageActivity.m
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

#import "NHMessageActivity.h"
#import "NHActivityViewController.h"

@interface NHMessageActivity()<MFMessageComposeViewControllerDelegate>
@property (nonatomic,strong) NSString* text;
@property (nonatomic,strong) NSURL* URL;
@end

@implementation NHMessageActivity

- (NSString *)activityType {
    return NHActivityTypeMessage;
}

- (NSString *)activityTitle {
    return NSLocalizedStringFromTable(@"activity.Message.title", @"NHActivityViewController", @"Message");
}

- (UIImage *)activityImage {
    return [UIImage imageNamed:@"NHActivityViewController.bundle/Icon_Message"];
}

- (BOOL)canPerformWithActivityItems:(NSArray*)activityItems {
    if (![MFMessageComposeViewController canSendText]) {
        return NO;
    }
    for (id item in activityItems) {
        if (  [item isKindOfClass:[NSString class]]
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
        } else if([item isKindOfClass:[NSURL class]]) {
            self.URL = item;
        }
    }
}

- (UIViewController *)activityPerformingViewController {
    MFMessageComposeViewController *messageComposeViewController = [[MFMessageComposeViewController alloc] init];
    messageComposeViewController.messageComposeDelegate = self;
    if (self.text && !self.URL)
        messageComposeViewController.body = self.text;
    
    if (!self.text && self.URL)
        messageComposeViewController.body = [self.URL absoluteString];
    
    if (self.text && self.URL)
        messageComposeViewController.body = [NSString stringWithFormat:@"%@ %@", self.text, [self.URL absoluteString]];
    return messageComposeViewController;
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    BOOL completed = result == MessageComposeResultSent;
    [self activityDidFinish:completed];
}


@end
