//
//  NHActivityItemProviderWrapper.h
//  Extra Extra
//
//  Created by Niels van Hoorn on 29-07-13.
//  Copyright (c) 2013 NRC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NHActivityItemProvider;

@interface NHActivityItemProviderWrapper : UIActivityItemProvider
- (id)initWithItemProvider:(NHActivityItemProvider*)itemProvider;
@end
