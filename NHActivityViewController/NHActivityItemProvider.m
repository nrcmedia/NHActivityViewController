//
//  NHActivityItemProvider.m
//  Extra Extra
//
//  Created by Niels van Hoorn on 29-07-13.
//  Copyright (c) 2013 NRC. All rights reserved.
//

#import "NHActivityItemProvider.h"
@interface NHActivityItemProvider()
@property (nonatomic,strong) id placeholderItem;
@property (nonatomic,strong) id providedItem;
@property (nonatomic,strong) NSString* activityType;
@end
@implementation NHActivityItemProvider
- (id)initWithPlaceholderItem:(id)item
{
    self = [super init];
    if (self) {
        self.placeholderItem = item;
    }
    return self;
}

- (void)main {
    self.providedItem = [self item];
}

- (id)item {
    return nil;
}

- (id)activityViewController:(NHActivityViewController *)activityViewController itemForActivityType:(NSString *)activityType {
    return self.providedItem;
}

- (id)activityViewControllerPlaceholderItem:(NHActivityViewController *)activityViewController {
    return self.placeholderItem;
}

@end
