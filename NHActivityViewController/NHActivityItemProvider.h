//
//  NHActivityItemProvider.h
//  Extra Extra
//
//  Created by Niels van Hoorn on 29-07-13.
//  Copyright (c) 2013 NRC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NHActivityItemSource.h"

@interface NHActivityItemProvider : NSOperation<NHActivityItemSource>
@property (nonatomic,readonly) id placeholderItem;
@property (nonatomic,readonly) NSString* activityType;
- (id)initWithPlaceholderItem:(id)item;
- (id)item;
#pragma private
- (void)setActivityType:(NSString *)activityType;
@end
