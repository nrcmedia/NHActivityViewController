//
//  NSString+ActivityType.m
//  Extra Extra
//
//  Created by Niels van Hoorn on 09-07-13.
//  Copyright (c) 2013 NRC. All rights reserved.
//

#import "NSString+ActivityType.h"
#import "NHActivity.h"

@implementation NSString (ActivityType)
- (BOOL)activityTypeIsPostToFacebook {
    return [self isEqualToString:NHActivityTypePostToFacebook]
        || (&UIActivityTypePostToFacebook != NULL && [self isEqualToString:UIActivityTypePostToFacebook]);
}
- (BOOL)activityTypeIsPostToTwitter {
    return [self isEqualToString:NHActivityTypePostToTwitter]
    || (&UIActivityTypePostToTwitter != NULL && [self isEqualToString:UIActivityTypePostToTwitter]);
}
- (BOOL)activityTypeIsMessage {
    return [self isEqualToString:NHActivityTypeMessage]
    || (&UIActivityTypeMessage != NULL && [self isEqualToString:UIActivityTypeMessage]);
}
- (BOOL)activityTypeIsMail {
    return [self isEqualToString:NHActivityTypeMail]
        || (&UIActivityTypeMail != NULL && [self isEqualToString:UIActivityTypeMail]);
}
- (BOOL)activityTypeIsPrint {
    return [self isEqualToString:NHActivityTypePrint]
    || (&UIActivityTypePrint != NULL && [self isEqualToString:UIActivityTypePrint]);
}
- (BOOL)activityTypeIsCopyToPasteBoard {
    return [self isEqualToString:NHActivityTypeCopyToPasteboard]
    || (&UIActivityTypeCopyToPasteboard != NULL && [self isEqualToString:UIActivityTypeCopyToPasteboard]);
}
- (BOOL)activityTypeIsSaveToCameraRoll {
    return [self isEqualToString:NHActivityTypeSaveToCameraRoll]
    || (&UIActivityTypeSaveToCameraRoll != NULL && [self isEqualToString:UIActivityTypeSaveToCameraRoll]);
}
@end
