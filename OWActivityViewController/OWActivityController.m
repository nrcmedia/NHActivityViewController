//
//  XXItemShareController.m
//  Extra Extra
//
//  Created by Niels van Hoorn on 04-07-13.
//  Copyright (c) 2013 NRC. All rights reserved.
//

#import "OWActivityController.h"
#import "OWActivityViewController.h"

@interface OWActivityController()<UIPopoverControllerDelegate>
@property (nonatomic,strong) NSArray* items;
@property (nonatomic, strong) UIPopoverController* sharePopover;
@property (nonatomic, strong) UIViewController* presentingViewController;
@end

@implementation OWActivityController
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
        return [self createOWActivityViewController];
    }
}

- (UIViewController*)createOWActivityViewController {
    OWActivityViewController* activityVC = [[OWActivityViewController alloc] initWithActivityItems:self.items applicationActivities:nil];
    activityVC.excludedActivityTypes = @[OWActivityTypePrint];
    __weak OWActivityController* weakSelf = self;
    activityVC.completionHandler = ^(NSString* activityType, BOOL completed) {
        weakSelf.sharePopover.delegate = nil;
        weakSelf.sharePopover = nil;
        [weakSelf isDismissed];
    };
    return activityVC;
}

- (UIViewController*)createNativeActivityViewController {
    UIActivityViewController* activityVC = [[UIActivityViewController alloc] initWithActivityItems:self.items applicationActivities:nil];
    __weak OWActivityController* weakSelf = self;
    activityVC.completionHandler = ^(NSString *activityType, BOOL completed) {
        weakSelf.sharePopover.delegate = nil;
        weakSelf.sharePopover = nil;
        [weakSelf isDismissed];
    };
    activityVC.excludedActivityTypes = @[UIActivityTypePostToWeibo
//                                         ,UIActivityTypePostToFacebook
//                                         ,UIActivityTypePostToTwitter
                                         ,UIActivityTypeMessage
                                         ,UIActivityTypePrint
                                         ,UIActivityTypeCopyToPasteboard
                                         ,UIActivityTypeAssignToContact
                                         ,UIActivityTypeSaveToCameraRoll
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
        __weak OWActivityController* weakSelf = self;
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
    if ([activityVC isKindOfClass:[OWActivityViewController class]]) {
        viewController.modalPresentationStyle = UIModalPresentationCurrentContext;
        [viewController presentViewController:activityVC animated:YES completion:nil];
    } else {
        [viewController presentViewController:activityVC animated:YES completion:nil];
    }
}

- (void)presentFromBarButtonItem:(UIBarButtonItem *)barButtonItem {
    UIViewController* activityVC = [self createActivityViewController];
    self.sharePopover = [[UIPopoverController alloc] initWithContentViewController:activityVC];
    if ([activityVC isKindOfClass:[OWActivityViewController class]]) {
        OWActivityViewController* owVC = (OWActivityViewController*)activityVC;
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
