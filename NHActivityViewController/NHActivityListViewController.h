//
//  NHActivityListViewController.h
//  Extra Extra
//
//  Created by Niels van Hoorn on 08-07-13.
//  Copyright (c) 2013 NRC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NHActivityViewController;

@interface NHActivityListViewController : UIViewController
@property (strong, nonatomic) NSArray *activities;
@property (strong, nonatomic) NHActivityViewController* activityViewController;
@property (weak, nonatomic) UIPopoverController *popoverController;

- (void)modalDismissAnimationWithCompletion:(void(^)(BOOL))completion;
@end
