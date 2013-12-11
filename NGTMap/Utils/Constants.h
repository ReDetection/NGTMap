//
//  Constants.h
//  NGTMap
//
//  Created by Bromot Alexey on 14.10.13.
//  Copyright (c) 2013 Alexey Bromot. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    OnlineTransportUnitWorkStatus = 0,
    OfflineTransportUnitWorkStatus = 1
} TransportUnitWorkStatus;

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

//Server
extern NSString *const kServerAddress;
extern NSString *const kServerApiVersion;
extern NSString *const kServerApiKey;
extern NSString *const kServerApiFormat;

extern NSString *const kCustomValueInPath;

extern NSString *const kRoutesPath;
extern NSString *const kTransportUnitsByIdsPath;
extern NSString *const kTracksByIdsPath;

//Map
extern NSString *const kGoogleApiKey;
extern NSInteger const kMaxRoutesOnMap;

@end
