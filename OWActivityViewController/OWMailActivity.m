//
// OWMailActivity.m
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

#import "OWMailActivity.h"
#import "OWActivityViewController.h"
#import "OWActivityDelegateObject.h"

@interface OWMailActivity()<MFMailComposeViewControllerDelegate>
@end

@implementation OWMailActivity

- (id)init
{
    self = [super initWithTitle:NSLocalizedStringFromTable(@"activity.Mail.title", @"OWActivityViewController", @"Mail")
                          image:[UIImage imageNamed:@"OWActivityViewController.bundle/Icon_Mail"]
                    actionBlock:nil];
    
    
    if (!self)
        return nil;
    
    return self;
}

- (UIViewController *)activityPerformingViewController {
    if(![MFMailComposeViewController canSendMail]){
        return nil;
    }
    NSDictionary *userInfo = self.userInfo;
    NSString *subject = [userInfo objectForKey:@"subject"];
    NSString *text = [userInfo objectForKey:@"text"];
    UIImage *image = [userInfo objectForKey:@"image"];
    NSURL *url = [userInfo objectForKey:@"url"];
    MFMailComposeViewController *mailComposeViewController = [[MFMailComposeViewController alloc] init];
    mailComposeViewController.mailComposeDelegate = self;

    if (subject) {
        [mailComposeViewController setSubject:subject];
    }

    if (text && !url)
        [mailComposeViewController setMessageBody:text isHTML:YES];

    if (!text && url)
        [mailComposeViewController setMessageBody:url.absoluteString isHTML:YES];
    
    if (text && url)
        [mailComposeViewController setMessageBody:[NSString stringWithFormat:@"%@ %@", text, url.absoluteString] isHTML:YES];
    
    if (image)
        [mailComposeViewController addAttachmentData:UIImageJPEGRepresentation(image, 0.75f) mimeType:@"image/jpeg" fileName:@"photo.jpg"];
    
    
    return mailComposeViewController;
}


- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    BOOL completed = result == MFMailComposeResultSent;
    [self.delegate didFinishActivity:self completed:completed];
}
@end
