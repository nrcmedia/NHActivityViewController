//
// OWActivityViewController.m
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

#import "OWActivityViewController.h"
#import "OWActivityListViewController.h"

@interface OWActivityViewController ()
@property (nonatomic,strong) OWActivityListViewController* listViewController;
@property (nonatomic,assign) BOOL didFinishActivity;
@property (nonatomic,strong) UIViewController* performingViewController;
@property (nonatomic,strong) NSArray* applicationActivities;
@property (nonatomic,strong) NSArray* items;
@property (nonatomic,strong) NSArray* rawItemCache;
@end

@implementation OWActivityViewController

- (id)initWithActivityItems:(NSArray*)items activities:(NSArray *)activities
- (id)initWithActivityItems:(NSArray*)items applicationActivities:(NSArray *)applicationActivities
{
    self = [super init];
    if (self) {
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        self.items = items;
        self.applicationActivities = applicationActivities;
    }
    return self;
}

- (void)setPopoverController:(UIPopoverController *)popoverController {
    self.listViewController.popoverController = popoverController;
}

- (UIPopoverController *)popoverController {
    return self.listViewController.popoverController;
}

- (CGSize)contentSizeForViewInPopover {
    return self.listViewController.contentSizeForViewInPopover;
}

- (NSArray*)placeHolderItemsForActivityType:(NSString*)activityType {
    NSMutableArray* placeholderItems = [NSMutableArray arrayWithCapacity:[self.items count]];
    for (id item in self.items) {
        if ([item respondsToSelector:@selector(activityViewControllerPlaceholderItem:)]) {
            id placeholderItem = [item activityViewControllerPlaceholderItem:(id)self];
            if (placeholderItem != nil) {
                [placeholderItems addObject:placeholderItem];
            }
        } else {
            [placeholderItems addObject:item];
        }
    }
    return placeholderItems;
}

- (NSArray*)itemsForActivityType:(NSString*)activityType {
    NSMutableArray* rawItems = [NSMutableArray arrayWithCapacity:[self.items count]];
    for (id item in self.items) {
        if ([item respondsToSelector:@selector(activityViewController:itemForActivityType:)]) {
            id rawItem = [item activityViewController:(id)self itemForActivityType:activityType];
            if (rawItem != nil) {
                [rawItems addObject:rawItem];
            }
        } else {
            [rawItems addObject:item];
        }
    }
    return rawItems;
}

- (NSArray*)performableActivities {
    NSMutableArray* performableActivities = [[NSMutableArray alloc] initWithCapacity:[self.activities count]];
    for (OWActivity* activity in self.activities) {
        NSArray* items = [self placeHolderItemsForActivityType:[activity activityType]];
        if ([activity canPerformWithActivityItems:items]) {
            [performableActivities addObject:activity];
        }
    }
    return performableActivities;
}

- (OWActivityListViewController*)listViewController {
    if (_listViewController == nil) {
        _listViewController = [[OWActivityListViewController alloc] init];
        _listViewController.activityViewController = self;
        _listViewController.activities = [self performableActivities];
    }
    return _listViewController;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!self.didFinishActivity) {
        [self addChildViewController:self.listViewController];
        [self.view addSubview:self.listViewController.view];
        [self.listViewController didMoveToParentViewController:self];
    }
}

- (void)performActivity:(OWActivity *)activity {
    __weak OWActivityViewController* weakSelf = self;
    [self dismissListViewControllerWithCompletion:^(BOOL finished) {
        NSArray* items = [self itemsForActivityType:[activity activityType]];
        [activity prepareWithActivityItems:items];
        [weakSelf showActivity:activity];
    }];
}

- (void)showActivity:(OWActivity*)activity {
    activity.delegate = self;
    self.performingViewController = [activity activityPerformingViewController];
    if (self.performingViewController) {
        [self presentViewController:self.performingViewController animated:YES completion:nil];
    } else {
        [activity performActivity];
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}

- (void)dismissListViewControllerWithCompletion:(void(^)(BOOL))completion {
    if (self.popoverController) {
        [self.popoverController dismissPopoverAnimated:YES];
        completion(YES);
    } else {
        [self.listViewController willMoveToParentViewController:nil];
        __weak OWActivityViewController* weakSelf = self;
        [self.listViewController modalDismissAnimationWithCompletion:^(BOOL finished) {
            [weakSelf.listViewController.view removeFromSuperview];
            [weakSelf.listViewController removeFromParentViewController];
            completion(finished);
        }];
    }
}

- (void)didFinishActivity:(OWActivity *)activity completed:(BOOL)completed {
    self.didFinishActivity = YES;
    __weak OWActivityViewController* weakSelf = self;
    if (activity == nil) {
        [self dismissListViewControllerWithCompletion:^(BOOL finished) {
            [weakSelf dismissWithActivity:activity completed:completed];
        }];
        return;
    }
    if (self.performingViewController) {
        [self dismissViewControllerAnimated:YES completion:^{
            [weakSelf dismissWithActivity:activity completed:completed];
        }];
    } else {
        [self dismissWithActivity:activity completed:completed];
    }
}

- (void)dismissWithActivity:(OWActivity*)activity completed:(BOOL)completed {
    [self dismissViewControllerAnimated:NO completion:nil];
    if (self.completionHandler) {
        self.completionHandler([activity activityType],completed);
    }
}

#pragma mark -
#pragma mark Orientation

- (NSUInteger)supportedInterfaceOrientations
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        return UIInterfaceOrientationMaskAll;
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        return YES;
    return NO;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        return YES;
    return (orientation == UIInterfaceOrientationPortrait);
}

@end
