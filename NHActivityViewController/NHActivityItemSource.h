//
//  NHActivityItemSource.h
//  Extra Extra
//
//  Created by Niels van Hoorn on 29-07-13.
//  Copyright (c) 2013 NRC. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NHActivityViewController;

@protocol NHActivityItemSource
- (id)activityViewController:(NHActivityViewController*)activityViewController itemForActivityType:(NSString *)activityType;
- (id)activityViewControllerPlaceholderItem:(NHActivityViewController*)activityViewController;
@end
