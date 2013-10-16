//
//  Constants.h
//  CouchCall
//
//  Created by Mac Developer on 15.08.13.
//  Copyright (c) 2013 Magora-Systems. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    BusRouteType = 1,
    TrolleyBusRouteType = 2,
    TramRouteType = 3,
    MicroBusRouteType = 8
} RouteType;

typedef enum {
    DirectDirectionType = 0,
    ReverseDirectionType = 1,
    BothDirectionType = 2,
} DirectionType;

typedef void (^SimpleCompletionBlock)();
typedef void (^SimpleFailBlock)(NSError *error);

@interface Constants : NSObject

extern NSString *const kServerAddress;
extern NSString *const kServerApiVersion;
extern NSString *const kServerApiKey;
extern NSString *const kServerApiFormat;

extern NSString *const kCustomValueInPath;

extern NSString *const kRoutesPath;
extern NSString *const kTransportUnitsByIdsPath;

@end
