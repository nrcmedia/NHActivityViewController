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
@end

@implementation OWActivityViewController

- (id)initWithActivities:(NSArray *)activities
{
    self = [super init];
    if (self) {
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        self.activities = activities;
    }
    return self;
}

- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        __typeof (&*self) __weak weakSelf = self;
        [UIView animateWithDuration:0.4 animations:^{
            _backgroundView.alpha = 0;
            CGRect frame = _activityView.frame;
            frame.origin.y = [UIScreen mainScreen].bounds.size.height;
            _activityView.frame = frame;
        } completion:^(BOOL finished) {
            [weakSelf.view removeFromSuperview];
            [weakSelf removeFromParentViewController];
            if (completion)
                completion();
        }];
    } else {
        [self.presentingPopoverController dismissPopoverAnimated:YES];
        [self performBlock:^{
            if (completion)
                completion();
        } afterDelay:0.4];
    }
}

- (UIPopoverController *)popoverController {
    return self.listViewController.popoverController;
}

- (CGSize)contentSizeForViewInPopover {
    return self.listViewController.contentSizeForViewInPopover;
}

- (OWActivityListViewController*)listViewController {
    if (_listViewController == nil) {
        _listViewController = [[OWActivityListViewController alloc] init];
        _listViewController.activityViewController = self;
        _listViewController.activities = self.activities;
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
        [weakSelf showActivity:activity];
    }];
}

#pragma mark - 
#pragma mark Helpers

- (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay
{
    block = [block copy];
    [self performSelector:@selector(runBlockAfterDelay:) withObject:block afterDelay:delay];
}

- (void)runBlockAfterDelay:(void (^)(void))block
{
	if (block != nil)
		block();
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
