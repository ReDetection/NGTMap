//
//  Route.m
//  NGTMap
//
//  Created by Alexey Bromot on 07.10.13.
//  Copyright (c) 2013 Alexey Bromot. All rights reserved.
//

#import "Route.h"

NSDictionary *ROUTE_TYPE_IMAGE_NAMES;

@implementation Route

+ (void)load {
    ROUTE_TYPE_IMAGE_NAMES = @{@(BusRouteType): @"routes_bus_icon.png", @(TrolleyBusRouteType): @"routes_trolleybus_icon.png", @(TramRouteType): @"routes_trambus_icon.png", @(MicroBusRouteType): @"routes_microbus_icon.png"};
}

@end
