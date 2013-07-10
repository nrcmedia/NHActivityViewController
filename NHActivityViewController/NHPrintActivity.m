//
// NHPrintActivity.m
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

#import "NHPrintActivity.h"
#import "NHActivityViewController.h"

@interface NHPrintActivity()
@property (nonatomic,strong) UIImage* image;
@property (nonatomic,strong) NSString* text;
@end

@implementation NHPrintActivity

- (NSString *)activityType {
    return NHActivityTypePrint;
}

- (NSString *)activityTitle {
    return NSLocalizedStringFromTable(@"activity.Print.title", @"NHActivityViewController", @"Print");
}

- (UIImage *)activityImage {
    return [UIImage imageNamed:@"NHActivityViewController.bundle/Icon_Print"];
}

- (BOOL)canPerformWithActivityItems:(NSArray*)activityItems {
    if (![UIPrintInteractionController isPrintingAvailable]) {
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
        }
    }
}

- (void)performActivity {
    UIPrintInteractionController *pc = [UIPrintInteractionController sharedPrintController];
    UIPrintInfo *printInfo = [UIPrintInfo printInfo];
    printInfo.outputType = UIPrintInfoOutputGeneral;
    printInfo.jobName = self.text;
    pc.printInfo = printInfo;
    pc.printingItem = self.image;
    void (^completionHandler)(UIPrintInteractionController *, BOOL, NSError *) =
    ^(UIPrintInteractionController *printController, BOOL completed, NSError *error) {
        if (!completed && error) {
            //TODO: make this nicer
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"activity.Print.error.title", @"NHActivityViewController", @"Error.")
                                                         message:[NSString stringWithFormat:NSLocalizedStringFromTable(@"activity.Print.error.message", @"NHActivityViewController", @"An error occured while printing: %@"), error]
                                                        delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil, nil];
            
            [av show];
        }
        [self activityDidFinish:completed];
    };
    [pc presentAnimated:YES completionHandler:completionHandler];
}


@end
