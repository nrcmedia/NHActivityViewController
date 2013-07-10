//
//  XXItemShareController.h
//  Extra Extra
//
//  Created by Niels van Hoorn on 04-07-13.
//  Copyright (c) 2013 NRC. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XXItem;

@interface OWActivityController : NSObject
@property (nonatomic,copy) void (^onDismiss)();
- (id)initWithActivityItems:(NSArray*)items;
- (void)presentFromBarButtonItem:(UIBarButtonItem *)barButtonItem ofViewController:(UIViewController*)viewController;
- (void)dismiss;
@end