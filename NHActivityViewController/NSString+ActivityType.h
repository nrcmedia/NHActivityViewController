//
//  NSString+ActivityType.h
//  Extra Extra
//
//  Created by Niels van Hoorn on 09-07-13.
//  Copyright (c) 2013 NRC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ActivityType)
- (BOOL)activityTypeIsPostToFacebook;
- (BOOL)activityTypeIsPostToTwitter;
- (BOOL)activityTypeIsMessage;
- (BOOL)activityTypeIsMail;
- (BOOL)activityTypeIsPrint;
- (BOOL)activityTypeIsCopyToPasteBoard;
- (BOOL)activityTypeIsSaveToCameraRoll;
@end
