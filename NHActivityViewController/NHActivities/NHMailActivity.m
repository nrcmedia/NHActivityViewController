//
// NHMailActivity.m
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

#import "NHMailActivity.h"
#import "NHActivityViewController.h"
#import "NSString+MKNetworkKitAdditions.h"
#import <MessageUI/MessageUI.h>

@interface NHMailActivity()<MFMailComposeViewControllerDelegate>
@property (nonatomic,strong) UIImage* image;
@property (nonatomic,strong) NSString* text;
@property (nonatomic,strong) NSURL* URL;
@end

@implementation NHMailActivity

- (NSString *)activityType {
    return NHActivityTypeMail;
}


- (UIImage *)activityImage {
    return [UIImage imageNamed:@"NHActivityViewController.bundle/Icon_Mail"];
}

- (NSString *)activityTitle {
    return NSLocalizedStringFromTable(@"activity.Mail.title", @"NHActivityViewController", @"Mail");
}

- (BOOL)canPerformWithActivityItems:(NSArray*)activityItems {
    if(![MFMailComposeViewController canSendMail]){
        return NO;
    }
    
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

- (UIViewController *)activityPerformingViewController {
    if(![MFMailComposeViewController canSendMail]){
        return nil;
    }
    MFMailComposeViewController *mailComposeViewController = [[MFMailComposeViewController alloc] init];
    mailComposeViewController.mailComposeDelegate = self;

    NSString* subject = nil;
    BOOL isMailToURL = [[self.URL scheme] isEqualToString:@"mailto"];
    if (isMailToURL) {
        NSDictionary* parameters = [self parameterDictionaryFromURL:self.URL];
        subject = [parameters objectForKey:@"subject"];
    }
    
    if (subject) {
        [mailComposeViewController setSubject:subject];
    }

    if ( self.text) {
        [mailComposeViewController setMessageBody:self.text isHTML:YES];
    } else if(!isMailToURL) {
        [mailComposeViewController setMessageBody:[self.URL absoluteString] isHTML:YES];
    }
    
    if (self.image)
        [mailComposeViewController addAttachmentData:UIImagePNGRepresentation(self.image) mimeType:@"image/png" fileName:@"Image-1.png"];
    
    
    return mailComposeViewController;
}


- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    BOOL completed = result == MFMailComposeResultSent;
    [self.delegate didFinishActivity:self completed:completed];
}

//From http://stackoverflow.com/questions/7310396/parse-a-nsurl-mailto
- (NSDictionary *) parameterDictionaryFromURL:(NSURL *)url {
    NSMutableDictionary *parameterDictionary = [[NSMutableDictionary alloc] init];
    if ([[url scheme] isEqualToString:@"mailto"]) {
        NSString *mailtoParameterString = [[url absoluteString] substringFromIndex:[@"mailto:" length]];
        NSUInteger questionMarkLocation = [mailtoParameterString rangeOfString:@"?"].location;
        [parameterDictionary setObject:[mailtoParameterString substringToIndex:questionMarkLocation] forKey:@"recipient"];
        
        if (questionMarkLocation != NSNotFound) {
            NSString *parameterString = [mailtoParameterString substringFromIndex:questionMarkLocation + 1];
            NSArray *keyValuePairs = [parameterString componentsSeparatedByString:@"&"];
            for (NSString *queryString in keyValuePairs) {
                NSArray *keyValuePair = [queryString componentsSeparatedByString:@"="];
                if (keyValuePair.count == 2)
                    [parameterDictionary setObject:[[keyValuePair objectAtIndex:1] urlDecodedString] forKey:[[keyValuePair objectAtIndex:0] urlDecodedString]];
            }
        }
    }
    else {
        NSString *parameterString = [url parameterString];
        NSArray *keyValuePairs = [parameterString componentsSeparatedByString:@"&"];
        for (NSString *queryString in keyValuePairs) {
            NSArray *keyValuePair = [queryString componentsSeparatedByString:@"="];
            if (keyValuePair.count == 2)
                [parameterDictionary setObject:[[keyValuePair objectAtIndex:1] urlDecodedString] forKey:[[keyValuePair objectAtIndex:0] urlDecodedString]];
        }
    }
    return [parameterDictionary copy];
}
@end
