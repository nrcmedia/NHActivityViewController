//
//  NHActivityItemProviderWrapper.m
//  Extra Extra
//
//  Created by Niels van Hoorn on 29-07-13.
//  Copyright (c) 2013 NRC. All rights reserved.
//

#import "NHActivityItemProviderWrapper.h"
#import "NHActivityItemProvider.h"

@interface NHActivityItemProviderWrapper()
@property (nonatomic,strong) NHActivityItemProvider* itemProvider;
@end

@implementation NHActivityItemProviderWrapper
- (id)initWithItemProvider:(NHActivityItemProvider *)itemProvider
{
    self = [super initWithPlaceholderItem:itemProvider.placeholderItem];
    if (self) {
        self.itemProvider = itemProvider;
    }
    return self;
}

- (id)item {
    [self.itemProvider setActivityType:[self activityType]];
    return [self.itemProvider item];
}

@end
