//
//  Constants.h
//  CouchCall
//
//  Created by Mac Developer on 15.08.13.
//  Copyright (c) 2013 Magora-Systems. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SimpleCompletionBlock)();
typedef void (^SimpleFailBlock)(NSError *error);

@interface Constants : NSObject

extern NSString *const kServerAddress;
extern NSString *const kServerApiVersion;
extern NSString *const kServerApiKey;
extern NSString *const kServerApiFormat;

extern NSString *const kRoutesPath;

//extern NSString *const kRoundsPath;
//extern NSString *const kGamesPath;
//extern NSString *const kGamePath;
//extern NSString *const kEventsPath;
//extern NSString *const kRegistrationPath;
//extern NSString *const kLoginPath;
//extern NSString *const kCommentsPath;
//extern NSString *const kEventCommentsPath;
//extern NSString *const kAddCommentToMatchPath;
//extern NSString *const kAddCommentToEventPath;
//extern NSString *const kVoteOnEvent;
//
//extern NSString *const kDefaultAppName;

@end
