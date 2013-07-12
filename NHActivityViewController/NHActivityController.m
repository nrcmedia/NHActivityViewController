//
//  XXItemShareController.m
//  Extra Extra
//
//  Created by Niels van Hoorn on 04-07-13.
//  Copyright (c) 2013 NRC. All rights reserved.
//

#import "NHActivityController.h"
#import "NHActivityViewController.h"

@interface NHActivityController()<UIPopoverControllerDelegate>
@property (nonatomic,strong) NSArray* items;
@property (nonatomic, strong) UIPopoverController* sharePopover;
@property (nonatomic, strong) UIViewController* presentingViewController;
@end

@implementation NHActivityController
- (id)initWithActivityItems:(NSArray*)items {
    self = [super init];
    if (self) {
        self.items = items;
    }
    return self;
}

- (UIViewController*)createActivityViewController {
    if ([UIActivityViewController class]) {
        return [self createNativeActivityViewController];
    } else {
        return [self createNHActivityViewController];
    }
}

- (UIViewController*)createNHActivityViewController {
    NHActivityViewController* activityVC = [[NHActivityViewController alloc] initWithActivityItems:self.items applicationActivities:nil];
    activityVC.excludedActivityTypes = @[ NHActivityTypePostToFacebook
                                        , NHActivityTypePostToTwitter
//                                        , NHActivityTypeMail
                                        , NHActivityTypeMessage
                                        , NHActivityTypePrint
                                        , NHActivityTypeCopyToPasteboard
//                                        , NHActivityTypeSaveToCameraRoll
                                        ];
    __weak NHActivityController* weakSelf = self;
    activityVC.completionHandler = ^(NSString* activityType, BOOL completed) {
        weakSelf.sharePopover.delegate = nil;
        weakSelf.sharePopover = nil;
        [weakSelf isDismissed];
    };
    return activityVC;
}

- (UIViewController*)createNativeActivityViewController {
    UIActivityViewController* activityVC = [[UIActivityViewController alloc] initWithActivityItems:self.items applicationActivities:nil];
    __weak NHActivityController* weakSelf = self;
    activityVC.completionHandler = ^(NSString *activityType, BOOL completed) {
        weakSelf.sharePopover.delegate = nil;
        weakSelf.sharePopover = nil;
        [weakSelf isDismissed];
    };
    activityVC.excludedActivityTypes = @[UIActivityTypePostToWeibo
                                         ,UIActivityTypePostToFacebook
                                         ,UIActivityTypePostToTwitter
//                                         ,UIActivityTypeMail
                                         ,UIActivityTypeMessage
                                         ,UIActivityTypePrint
                                         ,UIActivityTypeCopyToPasteboard
                                         ,UIActivityTypeAssignToContact
//                                         ,UIActivityTypeSaveToCameraRoll
                                         ];
    return activityVC;
}

- (void)presentFromBarButtonItem:(UIBarButtonItem *)barButtonItem ofViewController:(UIViewController*)viewController {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [self presentFromViewController:viewController];
    } else {
        [self presentFromBarButtonItem:barButtonItem];
    }
}

- (void)dismiss {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        __weak NHActivityController* weakSelf = self;
        [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
            [weakSelf isDismissed];
        }];
        self.presentingViewController = nil;
    } else {
        [self.sharePopover dismissPopoverAnimated:YES];
        [self isDismissed];
        self.sharePopover = nil;
    }
}

- (void)isDismissed {
    if (self.onDismiss) {
        self.onDismiss();
    }
}

- (void)presentFromViewController:(UIViewController*)viewController {
    self.presentingViewController = viewController;
    UIViewController* activityVC = [self createActivityViewController];
    if ([activityVC isKindOfClass:[NHActivityViewController class]]) {
        viewController.modalPresentationStyle = UIModalPresentationCurrentContext;
        [viewController presentViewController:activityVC animated:YES completion:nil];
    } else {
        [viewController presentViewController:activityVC animated:YES completion:nil];
    }
}

- (void)presentFromBarButtonItem:(UIBarButtonItem *)barButtonItem {
    UIViewController* activityVC = [self createActivityViewController];
    self.sharePopover = [[UIPopoverController alloc] initWithContentViewController:activityVC];
    if ([activityVC isKindOfClass:[NHActivityViewController class]]) {
        NHActivityViewController* owVC = (NHActivityViewController*)activityVC;
        owVC.popoverController = self.sharePopover;
    }
    self.sharePopover.delegate = self;
    [self.sharePopover presentPopoverFromBarButtonItem:barButtonItem permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

#pragma mark - UIPopoverControllerDelegate

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    [self isDismissed];
    self.sharePopover = nil;
}

@end
