//
//  Route.h
//  NGTMap
//
//  Created by Alexey Bromot on 07.10.13.
//  Copyright (c) 2013 Alexey Bromot. All rights reserved.
//

#import "DataObject.h"

//Маршрут

typedef enum {
    BusRouteType = 1,
    TrolleyBusRouteType = 2,
    TramRouteType = 3,
    MicroBusRouteType = 8
} RouteType;

@interface Route : DataObject

@property (strong, nonatomic) NSString *identifier;
@property (strong, nonatomic) NSNumber *type;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *oldTitle;
@property (strong, nonatomic) NSString *stopBegin;
@property (strong, nonatomic) NSString *stopEnd;

@property (strong, nonatomic) NSArray *tracks;
@property (strong, nonatomic) NSArray *transports;

@end
