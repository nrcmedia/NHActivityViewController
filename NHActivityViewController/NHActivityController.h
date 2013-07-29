//
//  XXItemShareController.h
//  Extra Extra
//
//  Created by Niels van Hoorn on 04-07-13.
//  Copyright (c) 2013 NRC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NHActivity.h"
@class XXItem;

@interface NHActivityController : NSObject
@property (nonatomic,copy) void (^onDismiss)();
@property (nonatomic, copy) NSArray *excludedActivityTypes;
- (id)initWithActivityItems:(NSArray*)items;
- (void)presentFromBarButtonItem:(UIBarButtonItem *)barButtonItem ofViewController:(UIViewController*)viewController;
- (void)dismiss;
@end
