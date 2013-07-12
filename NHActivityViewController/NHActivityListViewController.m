//
//  NHActivityListViewController.m
//  Extra Extra
//
//  Created by Niels van Hoorn on 08-07-13.
//  Copyright (c) 2013 NRC. All rights reserved.
//

#import "NHActivityListViewController.h"
#import "NHActivityListView.h"

@interface NHActivityListViewController ()
@property (strong, nonatomic) NHActivityListView *activityView;
@property (assign, nonatomic) BOOL isPresentingModally;
@property (strong, nonatomic) UIView* backgroundView;
@end

@implementation NHActivityListViewController

@synthesize popoverController = popoverController_;

- (void)loadView {
    [super loadView];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
        self.view.frame = rootViewController.view.bounds;
        self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.backgroundView = [[UIView alloc] initWithFrame:self.view.bounds];
        self.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.backgroundView.backgroundColor = [UIColor blackColor];
        self.backgroundView.alpha = 0;
        [self.view addSubview:self.backgroundView];
    } else {
        self.view.frame = CGRectMake(0, 0, 320, 417);
    }
    
    self.activityView = [[NHActivityListView alloc] initWithFrame:CGRectMake(0,
                                                                         UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ?
                                                                         [UIScreen mainScreen].bounds.size.height : 0,
                                                                         self.view.frame.size.width, self.height)
                                                   activities:self.activities];
    self.activityView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.activityView.activityViewController = self.activityViewController;
    [self.view addSubview:self.activityView];
}

- (CGSize)contentSizeForViewInPopover {
    return CGSizeMake(320, self.height - 60);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!self.popoverController) {
        [UIView animateWithDuration:0.4 animations:^{
            self.backgroundView.alpha = 0.4;
            CGRect frame = _activityView.frame;
            frame.origin.y = self.view.frame.size.height - self.height;
            _activityView.frame = frame;
        }];
    }
}

- (void)modalDismissAnimationWithCompletion:(void(^)(BOOL))completion {
    [UIView animateWithDuration:0.4 animations:^{
        self.backgroundView.alpha = 0;
        CGRect frame = _activityView.frame;
        frame.origin.y = [UIScreen mainScreen].bounds.size.height;
        _activityView.frame = frame;
    } completion:completion];
}


- (NSInteger)height
{
    if (_activities.count <= 3) return 214;
    if (_activities.count <= 6) return 317;
    return 417;
}

@end
